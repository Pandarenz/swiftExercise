import Foundation

/// URLMatcher provides a way to match URLs against a list of specified patterns.
///
/// URLMatcher extracts the pattern and the values from the URL if possible.
open class URLMatcher {
  public typealias URLPattern = String
  public typealias URLValueConverter = (_ pathComponents: [String], _ index: Int) -> Any?

  static let defaultURLValueConverters: [String: URLValueConverter] = [
    "string": { pathComponents, index in
      return pathComponents[index]
    },
    "int": { pathComponents, index in
      return Int(pathComponents[index])
    },
    "float": { pathComponents, index in
      return Float(pathComponents[index])
    },
    "uuid": { pathComponents, index in
      return UUID(uuidString: pathComponents[index])
    },
    "path": { pathComponents, index in
      return pathComponents[index..<pathComponents.count].joined(separator: "/")
    }
  ]

  open var valueConverters: [String: URLValueConverter] = URLMatcher.defaultURLValueConverters

  public init() {
    // 🔄 I'm an URLMatcher!
  }

  /// Returns a matching URL pattern and placeholder values from the specified URL and patterns.
  /// It returns `nil` if the given URL is not contained in the URL patterns.
  ///
  /// For example:
  ///
  ///     let result = matcher.match("myapp://user/123", from: ["myapp://user/<int:id>"])
  ///
  /// The value of the `URLPattern` from an example above is `"myapp://user/<int:id>"` and the
  /// value of the `values` is `["id": 123]`.
  ///
  /// - parameter url: The placeholder-filled URL. 当前要打开的url
  /// - parameter from: The array of URL patterns. 字典handlerFactories的keys
  ///
  /// - returns: A `URLMatchComponents` struct that holds the URL pattern string, a dictionary of
  ///            the URL placeholder values.
  open func match(_ url: URLConvertible, from candidates: [URLPattern]) -> URLMatchResult? {
    let url = self.normalizeURL(url)
    let scheme = url.urlValue?.scheme
    // 获取当前url的path  navigator://user/devxoul 为：[user,devxoul]
    let stringPathComponents = self.stringPathComponents(from :url)
    // candidates: 字典handlerFactories的keys 就是当时注册的 url
    for candidate in candidates {
        // 如果当前的scheme 和候选的scheme一样则继续比较 如果不一样则进行下一个候选的url
        //1 先比较scheme
      guard scheme == candidate.urlValue?.scheme else { continue }
      if let result = self.match(stringPathComponents, with: candidate) {
        return result
      }
    }

    return nil
  }
  // stringPathComponents 要打开的url的path 如 navigator://user/devxoul 为：[user,devxoul]
    // 2 比较path
  func match(_ stringPathComponents: [String], with candidate: URLPattern) -> URLMatchResult? {
    print("stringPathComponents=>\n",stringPathComponents)
    print("candidate=>\n",candidate)
    let normalizedCandidate = self.normalizeURL(candidate).urlStringValue
    // 把字典的key 分解成 URLPathComponent 如 navigator://alert/patch/jjj [alert,patch,jjj] 然后转化成
    let candidatePathComponents = self.pathComponents(from: normalizedCandidate)
    
    print("normalizedCandidate=>\n",normalizedCandidate)
    print("candidatePathComponents=>\n",candidatePathComponents)
    
    // 先匹配path的个数
    guard self.ensurePathComponentsCount(stringPathComponents, candidatePathComponents) else {
      return nil
    }

    var urlValues: [String: Any] = [:]
    
    // 取出长度最小的一个
    let pairCount = min(stringPathComponents.count, candidatePathComponents.count)
    for index in 0..<pairCount {
      let result = self.matchStringPathComponent( at: index, from: stringPathComponents, with: candidatePathComponents )

      switch result {
      case let .matches(placeholderValue):
        if let (key, value) = placeholderValue {
          urlValues[key] = value
        }

      case .notMatches:
        return nil
      }
    }
    
    return URLMatchResult(pattern: candidate, values: urlValues)
  }

  func normalizeURL(_ dirtyURL: URLConvertible) -> URLConvertible {
    guard dirtyURL.urlValue != nil else { return dirtyURL }
    var urlString = dirtyURL.urlStringValue
    urlString = urlString.components(separatedBy: "?")[0].components(separatedBy: "#")[0]
    urlString = self.replaceRegex(":/{3,}", "://", urlString)
    urlString = self.replaceRegex("(?<!:)/{2,}", "/", urlString)
    urlString = self.replaceRegex("(?<!:|:/)/+$", "", urlString)
    return urlString
  }

  func replaceRegex(_ pattern: String, _ repl: String, _ string: String) -> String {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return string }
    let range = NSMakeRange(0, string.count)
    return regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: repl)
  }
    
  // 先匹配path的个数是否合适 （是合适不是相等）
  func ensurePathComponentsCount(  _ stringPathComponents: [String], _ candidatePathComponents: [URLPathComponent]
  ) -> Bool {
    
//    1. http://<path:_>
//    placeholder(type: "path", key: "_")
//
//    2. navigator://user/<username>
//    placeholder(type: nil, key: "username")
    
    let hasSameNumberOfComponents = (stringPathComponents.count == candidatePathComponents.count)
    let containsPathPlaceholderComponent = candidatePathComponents.contains {
      if case let URLPathComponent.placeholder(type, _) = $0, type == "path" {
        return true // 是 http://<path:_>
      } else {
        return false//navigator://user/<username>
      }
    }
    // （如果当前的url String 和 候选的 url String path的个数一样 ）或者 （是 http://<path:_> 且 当前的 path个数 比 候选的path个数大 ） 则为匹配成功
    return hasSameNumberOfComponents || (containsPathPlaceholderComponent && stringPathComponents.count > candidatePathComponents.count)
  }

  func stringPathComponents(from url: URLConvertible) -> [String] {
    return url.urlStringValue.components(separatedBy: "/").lazy
      .filter { !$0.isEmpty }
      .filter { !$0.hasSuffix(":") }
  }

  func pathComponents(from url: URLPattern) -> [URLPathComponent] {
    return self.stringPathComponents(from: url).map(URLPathComponent.init)
  }
  //stringPathComponents 要打开的url的path 如 navigator://user/devxoul 为：[user,devxoul]
  func matchStringPathComponent( at index: Int, from stringPathComponents: [String], with candidatePathComponents: [URLPathComponent]
  ) -> URLPathComponentMatchResult {
    let stringPathComponent = stringPathComponents[index]
    let urlPathComponent = candidatePathComponents[index]
    
    print("urlPathComponent->\n",urlPathComponent)
    print("valueConverters->\n",self.valueConverters)
    switch urlPathComponent {
    case let .plain(value):
      guard stringPathComponent == value else { return .notMatches }
      return .matches(nil)
        
    case let .placeholder(type, key):
      guard let type = type, let converter = self.valueConverters[type] else {
        return .matches((key, stringPathComponent))
      }
      if let value = converter(stringPathComponents, index) {
        return .matches((key, value))
      } else {
        return .notMatches
      }
    }
  }
}
