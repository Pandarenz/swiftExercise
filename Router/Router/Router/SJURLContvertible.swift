//
//  SJURLContvertible.swift
//  Router
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

protocol SJURLConvertible{
    // string 转化成URL
    var urlValue: URL? { get }
    
    var stringValue: String { get }
    
    
    /// 返回Url中的 query 参数 返回的参数不会为nil 加入没有query 参数则返回 [:]
     
    /// eg: SJModule://home/search?keyworld=zhangsan&startindex = 12
     
    /// return ["keyworld":"zhangsan","startindex"="12"]
  
    
    var queryParameters: [String: String] { get }
    
    
}

extension SJURLConvertible {
    
    public var queryParameters: [String: String] {
        var parameters = [String:String]()
        let queryItems:[URLQueryItem]? = URLComponents.init(string: self.stringValue)?.queryItems
        guard let querys = queryItems else { return parameters }
        
        for item in querys {
            /// item.name 可能为空 eg: SJModule://home/path?queue=aa&&name=zhangsan
            /// 1.name:queue value:aa 2.name="",value=  3. name=name,value=zhangsan
            if item.name.count > 0  {
                parameters[item.name] = item.value ?? ""
            }
        }
        return parameters
    }
    
}


extension String:SJURLConvertible{
    var urlValue: URL? {
        if let url = URL.init(string: self) {
            return url
        }
        var set = CharacterSet()
        set.formUnion(.urlHostAllowed)//URL 中Host子模块中允许的字符集.
        set.formUnion(.urlPathAllowed)// URL 中domain后面的路径子模块中允许的字符集.
        set.formUnion(.urlQueryAllowed)// URL中请求信息子模块中允许的字符集.
        set.formUnion(.urlFragmentAllowed)// 片段URL子模块中允许的字符集.
        return self.addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0) }
    }
    
    var stringValue: String {
        return self
    }
}


extension URL:SJURLConvertible {
    
    public var urlValue: URL? {
        return self
    }
    
    public var stringValue: String {
        return self.absoluteString
    }
}
