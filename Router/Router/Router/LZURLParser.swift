//
//  LZURLParser.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

/// 解析出错
public enum LZURLParserError:String {
    case NoScheme // 没有scheme
    case NoHost   // 没有host
    case NoValue // 为空
    case UnKonw // 错误未知
}

/// 解析结果
public enum LZURLParserResult {
    /// 失败
    case failure(LZURLParserError)
    
    /// eg: LZModule://home/find?name=zhangsan&age=12
    ///parameters 为url中的参数对 eg: ["name":"zhangsan","age":"12"]
    ///keyValue 在路由字典中当做key eg: LZModule://home/find
    
    case success(parameters:[String:String]?,keyValue:String)
}


public class LZRouterURLParser {
    
    
    init() {
        
    }
    
    
   public func isValid(address:String) -> LZURLParserResult {
        
        return LZURLParserResult.failure(LZURLParserError.UnKonw)
    }
    
    
    func parserURL(url:SJURLConvertible) -> LZURLParserResult {
        
        
        
        return LZURLParserResult.failure(LZURLParserError.UnKonw)
    }
    
    
    /// 提取关键的key
    ///
    /// - Parameter url: <#url description#>
    /// - Returns: <#return value description#>
    func extractUrlKeyValue(url:SJURLConvertible) -> String? {
        
        return nil
    }
    
}

