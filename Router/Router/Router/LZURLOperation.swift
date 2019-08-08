//
//  LZURLOperation.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

public struct LZURLOperation {
    /// register 的时候的处理类
    var handle:Handle?
    /// open时的处理类
    var complate:Complate?
    /// 1.register 时url中参数 LZModule://home/find?name=zhangsan&age=12
    /// 2 open时 url中的参数 LZModule://home/find?like=apple&page=122
    /// 3 open时的 parameters 的参数 ["roomid":12323,"userid":88888]
    /// 则 此时的parameters 为 ["name":"zhangsan","age":12,"like":"apple","page":122,"roomid":12323,"userid":88888]
    var parameters:Parameters?
    
    
}
