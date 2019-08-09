//
//  LZURLOperation.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

// 没注册一个就会产生一个 operation
struct LZURLOperation {
    
    enum Error:Swift.Error {
        case noMatch //没有匹配到
    }
    
    
    /// register 的时候的处理类
    var handle:RouterHandle?
    /// open时的处理类
    var complate:RouterComplate?
    /// 1.register 时url中参数 LZModule://home/find?name=zhangsan&age=12
    /// 2 open时 url中的参数 LZModule://home/find?like=apple&page=122
    /// 3 open时的 parameters 的参数 ["roomid":12323,"userid":88888]
    /// 则 此时的parameters 为 ["name":"zhangsan","age":12,"like":"apple","page":122,"roomid":12323,"userid":88888]
    var parameters:Parameters?
    
    // open 或者 register 的url
    var routerUrl :LZURLConvertible = ""
    
    
    init(routerUrl url:LZURLConvertible,parameters:Parameters?,handle:RouterHandle?,complate:RouterComplate?) {
//        self.init()
        self.routerUrl = url
        self.parameters = parameters
        self.handle = handle
        self.complate = complate
    }
}


extension LZURLOperation {
    
    mutating func addParameters(dic:[String:Any]?) {
        guard let d = dic else {
            return
        }
        for (key,value) in d {
            parameters?[key] = value
        }
    }
    
}
