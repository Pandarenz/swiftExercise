//
//  LZURLConvertible.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

public protocol LZURLConvertible {
    // string 转化成URL
    var urlValue: URL? { get }
    
    var stringValue: String { get }
    
    
    /// 返回Url中的 query 参数 返回的参数不会为nil 加入没有query 参数则返回 [:]
    
    /// eg: SJModule://home/search?keyworld=zhangsan&startindex = 12
    
    /// return ["keyworld":"zhangsan","startindex"="12"]
    
    
    var queryParameters: [String: String] { get }
    
    
}

extension LZURLConvertible {
    
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


extension String:LZURLConvertible {
    public var urlValue: URL? {
        if let url = URL.init(string: self.stringValue) {
            return url
        }
        var set = CharacterSet()
        set.formUnion(.urlHostAllowed)//URL 中Host子模块中允许的字符集.
        set.formUnion(.urlPathAllowed)// URL 中domain后面的路径子模块中允许的字符集.
        set.formUnion(.urlQueryAllowed)// URL中请求信息子模块中允许的字符集.
        set.formUnion(.urlFragmentAllowed)// 片段URL子模块中允许的字符集.
        set.formUnion(.whitespacesAndNewlines)
        return self.addingPercentEncoding(withAllowedCharacters: set).flatMap({ (url) -> URL? in
            return URL.init(string: url.stringValue)
        })
        
    }
    
    //TODO: 去除空格
    public var stringValue: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}


extension URL:LZURLConvertible {
    
    public var urlValue: URL? {
        return self
    }
    
    public var stringValue: String {
        return self.absoluteString
    }
}
