//
//  LZURLOperation.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

/// 每注册一个就会产生一个 operation

struct LZURLOperation {
    
    enum Error:Swift.Error {
        case noMatch //没有匹配到
    }
    
    /// register 的时候的处理类
    var handle:RegisterHandle?
    /// open时的处理类
    var complate:OpenComplate?
    /// 1.register 时url中参数 LZModule://home/find?name=zhangsan&age=12
    /// 2 open时 url中的参数 LZModule://home/find?like=apple&page=122
    /// 3 open时的 parameters 的参数 ["roomid":12323,"userid":88888]
    /// 则 此时的parameters 为 ["name":"zhangsan","age":12,"like":"apple","page":122,"roomid":12323,"userid":88888]
    var parameters:Parameters?
    
    // open 或者 register 的url
    var routerUrl :LZURLConvertible = ""
    
    var component:LZURLComponent
    
    
//    private lazy var urlParser: LZURLParser = {
//        let parser = LZURLParser.init()
//        return parser
//    }()
//
    init(routerUrl url:LZURLConvertible,parameters:Parameters?,handle:RegisterHandle?,complate:OpenComplate?) {
//        self.init()
        self.routerUrl = url
        self.parameters = parameters
        self.handle = handle
        self.complate = complate
        self.component = LZURLComponent(convertibleString: self.routerUrl)!
    }
    init(parameters:Parameters?,component:LZURLComponent,handle:RegisterHandle?,complate:OpenComplate?) {
        //        self.init()
        
        self.parameters = parameters
        self.handle = handle
        self.complate = complate
        self.component = component
    }

    
}


extension LZURLOperation {
    
    mutating func addParameters(dic:[String:Any]?) -> [String:Any]? {
        
        if var _ = parameters {
            
        } else {
            parameters = [String:Any]()
        }
        
        guard let d = dic else {
            return parameters
        }
        for (key,value) in d {
            parameters?[key] = value
        }
        return parameters
    }
    
}
