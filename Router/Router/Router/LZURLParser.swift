//
//  LZURLParser.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


extension LZURLComponent {
    
    
    // 判断 LZURLComponent 是否合法
    
    struct LZURLParser {
        /// 判断LZURLComponent 是否合法
        ///
        /// - Parameter urlComonent: <#urlComonent description#>
        /// - Returns: <#return value description#>
        public func isValidURLString(urlComonent:LZURLComponent) -> LZURLParser.Result {
            
            guard urlComonent.absoluteString.count > 0 else {
                return LZURLParser.Result.Failure(LZURLParser.Error.NoValue)
            }
            
            guard let url = urlComonent.baseURL  else {  return LZURLParser.Result.Failure(LZURLParser.Error.FailureStringToURL)
            }
            
            guard urlComonent.scheme.count > 0 else { return LZURLParser.Result.Failure(LZURLParser.Error.Illegality)
            }
            
            guard urlComonent.host.count > 0 else { return LZURLParser.Result.Failure(LZURLParser.Error.Illegality)
            }
            
            return LZURLParser.Result.Success(parameters: url.queryParameters, absoluteString: urlComonent.absoluteString)
        }
        
        /// 验证urlstring是否有效
        ///
        /// - Parameter urlString: <#urlString description#>
        /// - Returns: Bool
        public func isValidURL(urlString:LZURLConvertible) -> Bool {
            let comonment = LZURLComponent.init(url: urlString)
            
            let result = isValidURLString(urlComonent: comonment)
            
            switch result {
            case .Failure(_):
                return false
            default:
                return true
            }
        }
        
    }
    
}



extension LZURLComponent.LZURLParser {
    /// 解析出错
    public enum Error: Swift.Error {
        
        case Illegality
        
        case FailureStringToURL
        
        case NoValue
        
        case UnKonw
        
        public var localizedDescription: String {
            switch self {
            case .Illegality:
                return "非法:no Scheme or no host"
            case .FailureStringToURL:
                return "字符串转url失败"
            case .NoValue:
                return "字符串为空"
            case .UnKonw:
                return "错误未知"
            }
        }
    }
    
    /// 解析结果
    public enum Result {
        /// 失败
        case Failure(LZURLComponent.LZURLParser.Error)
        
        /// eg: LZModule://home/find?name=zhangsan&age=12
        /// parameters 为url中的参数对 eg: ["name":"zhangsan","age":"12"]
        /// absoluteString  eg:  LZModule://home/find?name=zhangsan&age=12
        
        case Success(parameters:[String:String]?,absoluteString:String)
    }

}
