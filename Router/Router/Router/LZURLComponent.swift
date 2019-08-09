//
//  LZURLComponent.swift
//  Router
//
//  Created by JiWuChao on 2019/8/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

/*
    添加这一层主要时为了
    1.对遵循LZURLConvertible 协议的String 做一个简单的处理
    2.方便后期的扩展
 */

struct LZURLComponent {
    
    private static let SchemeSeparator = "?"
    
    var scheme:String
    
    var host:String
    
    var path:String
    
    var parameters:[String:Any]?
    
    var baseURL:URL?
    /// 除了参数的urlString eg:LZModule://home/find?name=zhangsan
    /// LZModule://home/find
    var keyPath:String {
        get {
            return extractURLKeyPathString()
        }
    }
    
    var absoluteString:String
    
    
    private let parser = LZURLParser.init()
    
    
    init(url:LZURLConvertible) {
        absoluteString = url.stringValue
        scheme = url.urlValue?.scheme ?? ""
        host = url.urlValue?.host ?? ""
        path = url.urlValue?.path ?? ""
        parameters = url.urlValue?.queryParameters
        baseURL = url.urlValue
    }
    
//    // 可失败构造器
    init?(convertibleString:LZURLConvertible) {
        guard convertibleString.stringValue.count > 0 else { return nil }
        absoluteString = convertibleString.stringValue
        // string 转化成url 不为空 且 host 和scheme 不为空
        guard let urlValue = convertibleString.urlValue, let tHost = urlValue.host,tHost.count > 0, let tScheme = urlValue.scheme,tScheme.count > 0 else { return nil }
        scheme = tScheme
        host = tHost
        baseURL = urlValue
        path = urlValue.path
        parameters = urlValue.queryParameters

    }
    
    
    /// 提取当前url的keypath
    ///
    /// - Returns: <#return value description#>
    func extractURLKeyPath() -> ExtractResult {
        
        guard absoluteString.count > 0 else {  return ExtractResult.Failure(LZURLComponent.ExtractError.NoValue) }
        
        let stringA = absoluteString.components(separatedBy: LZURLComponent.SchemeSeparator)
        
        guard let key = stringA.first else { return ExtractResult.Failure(LZURLComponent.ExtractError.NoValue) }
        
        return LZURLComponent.ExtractResult.Success(keyPath: key)
    }
    
    
    /// 提取当前url的keypath
    ///
    /// - Returns: <#return value description#>
    func extractURLKeyPathString() -> String {
        
        guard absoluteString.count > 0 else {  return "" }
        
        let stringA = absoluteString.components(separatedBy: LZURLComponent.SchemeSeparator)
        
        guard let key = stringA.first else { return ""}
        
        return key
    }
    
    
    /// 判断当前的url是否有效
    ///
    /// - Returns: <#return value description#>
    func isValidUrl() -> Bool {
        return parser.isValidURL(urlString: self.absoluteString)
    }
    
    /// 判断当前的url是否有效
    ///
    /// - Returns: <#return value description#>
    func isValidURLString() -> LZURLComponent.LZURLParser.Result {
        return parser.isValidURLString(urlComonent: self)
    }
    
}

extension LZURLComponent {
    
    // 提取keyPath 出错
    enum ExtractError:Swift.Error {
        case NoValue
    }
    // 提取keyPath的结果
    enum ExtractResult {
        case Failure(LZURLComponent.ExtractError)
        case Success(keyPath:String)
    }
    
}
