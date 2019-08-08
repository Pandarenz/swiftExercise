//
//  LZURLParser.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation



public class LZURLParser {
    
    
    init() {
        
    }
    
    
    public func isValid(address:String) -> LZURLParser.Result {
        
        return LZURLParser.Result.Failure(LZURLParser.Error.UnKonw)
    }
    
    
    func parserURL(url:SJURLConvertible) -> LZURLParser.Result {
        
        
        
        return LZURLParser.Result.Failure(LZURLParser.Error.UnKonw)
    }
    
    
    /// 提取关键的key
    ///
    /// - Parameter url: <#url description#>
    /// - Returns: <#return value description#>
    func extractUrlKeyValue(url:SJURLConvertible) -> String? {
        
        return nil
    }
    
}

extension LZURLParser {
    /// 解析出错
    public enum Error:Swift.Error {
        case NoScheme // 没有scheme
        case NoHost   // 没有host
        case NoValue // 为空
        case UnKonw // 错误未知
    }
    
    /// 解析结果
    public enum Result {
        /// 失败
        case Failure(LZURLParser.Error)
        
        /// eg: LZModule://home/find?name=zhangsan&age=12
        /// parameters 为url中的参数对 eg: ["name":"zhangsan","age":"12"]
        /// keyValue 在路由字典中当做key eg: LZModule://home/find
        
        case Success(parameters:[String:String]?,keyValue:String)
    }

}
