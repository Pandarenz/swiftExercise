//
//  LZURLParser.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


public class LZURLParser {
    
    private static let schemeSeparator = "?"
    
    
    /// <#Description#>
    ///
    /// - Parameter address: <#address description#>
    /// - Returns: LZURLParser.Result
    public func isValidURLString(address:LZURLConvertible) -> LZURLParser.Result {
        
        if address.stringValue.count == 0 {
            return LZURLParser.Result.Failure(LZURLParser.Error.NoValue)
        }
        guard let url = address.urlValue  else {  return LZURLParser.Result.Failure(LZURLParser.Error.FailureStringToURL)
        }
        
        guard let scheme = url.scheme ,scheme.count > 0 else { return LZURLParser.Result.Failure(LZURLParser.Error.Illegality)
        }
        guard let host = url.host, host.count > 0 else { return LZURLParser.Result.Failure(LZURLParser.Error.Illegality)
        }
        return LZURLParser.Result.Success(parameters: url.queryParameters, absoluteString: url.stringValue)
    }
    
    
    /// 验证urlstring是否有效
    ///
    /// - Parameter urlString: <#urlString description#>
    /// - Returns: Bool
    public func isValidURL(urlString:LZURLConvertible) -> Bool {
        let result = isValidURLString(address: urlString)
        
        switch result {
        case .Failure(_):
            return false
        default:
            return true
        }
    }
    
    
    
    
   public func parserURL(urlString:LZURLConvertible) -> LZURLParser.Result {
        
        let result = isValidURLString(address: urlString)
        switch result {
            
        case .Failure(_):
            return result

            /// eg: LZModule://home/find?name=zhangsan&age=12
            /// parameters 为url中的参数对 eg: ["name":"zhangsan","age":"12"]
        /// keyValue 在路由字典中当做key eg: LZModule://home/find
        case .Success(let p, let key):
            return .Success(parameters: p, absoluteString: extractUrlKeyValue(urlString: key) ?? "")
        }
    }
    
    
    /// 提取关键的key
    ///
    /// - Parameter url: LZModule://home/find?name=zhangsan&age=12
    /// - Returns: LZModule://home/find
    func extractUrlKeyValue(urlString:String) -> String? {
        
        guard urlString.count == 0 else {  return nil }
        
        let stringA = urlString.components(separatedBy: LZURLParser.schemeSeparator)
        
        guard let key = stringA.first else { return nil }
        
        return key
    }
    
}

extension LZURLParser {
    /// 解析出错
    public enum Error:Swift.Error {
        case Illegality // 非法:no Scheme no host
        case FailureStringToURL // 字符串转url失败
        case NoValue // 字符串为空
        case UnKonw // 错误未知
        
        public var localizedDescription: String {
            return "URL 解析失败:\(self)"
        }
    }
    
    /// 解析结果
    public enum Result {
        /// 失败
        case Failure(LZURLParser.Error)
        
        /// eg: LZModule://home/find?name=zhangsan&age=12
        /// parameters 为url中的参数对 eg: ["name":"zhangsan","age":"12"]
        /// absoluteString 在路由字典中当做key eg:  LZModule://home/find?name=zhangsan&age=12
        
        case Success(parameters:[String:String]?,absoluteString:String)
    }

}
