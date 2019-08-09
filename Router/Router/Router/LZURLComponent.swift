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

public struct LZURLComponent {
    
    private static let SchemeSeparator = "?"
    
    
    var scheme:String?
    
    var host:String?
    
    var path:String?
    
    var parameters:[String:Any]?
    
    var baseURL:URL?
    /// 除了参数的urlString eg:LZModule://home/find?name=zhangsan
    /// LZModule://home/find
    var keyPath:String?
    
    var absoluteString:String
    
    
    init(url:LZURLConvertible) {
        absoluteString = url.stringValue
        scheme = url.urlValue?.scheme
        host = url.urlValue?.host
        path = url.urlValue?.path
        parameters = url.queryParameters
        baseURL = url.urlValue
    }
    
     func extractURLKeyPath() -> ExtractResult {
        
        guard absoluteString.count == 0 else {  return ExtractResult.Failure(LZURLComponent.ExtractError.NoValue) }
        
        let stringA = absoluteString.components(separatedBy: LZURLComponent.SchemeSeparator)
        
        guard let key = stringA.first else { return ExtractResult.Failure(LZURLComponent.ExtractError.NoValue) }
        
        return LZURLComponent.ExtractResult.Success(keyPath: key)
    }
    
}

extension LZURLComponent {
    
    enum ExtractError:Swift.Error {
        case NoValue
    }
    
    enum ExtractResult {
        case Failure(LZURLComponent.ExtractError)
        case Success(keyPath:String)
    }
    
}
