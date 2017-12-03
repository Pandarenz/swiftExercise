//
//  Person.swift
//  构造函数 KVC
//
//  Created by JiWuChao on 2017/10/25.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

/*
     1 定义模型属性的时候,如果是对象,通常是可选的
     - 在需要的时候创建
     - 避免写构造函数 可以简化代码
     2 如果是基本数据类型 不能设置可选的 而且要设置初始值 否则 kvc 会崩溃
     3 如果需要 KVC 赋值不能设置成 private
     4 使用 KVC 之前应该调用super.init()方法 保证对象实例化完成
 */
class Person: NSObject {
    // name 属性是可选的 OC 中的属性都是在需要的时候创建的
    //延迟加载:在需要的时候再创建
    var name : String?
    var age :Int = 0
    
    // 重载构造函数 使用字典为本类设置初始值
    init(dict:[String:AnyObject]) {
        // 错误:'self' used before super.init call
        //使用self的方法'setValuesForKeys'之前 应该调用 super.init
        super.init()// 保证对象已经初始化完成
        // KVC 的方法 是OC 的方法 特点: 在运行时给对象发送消息 所以给对象发送消息之前 要求对象已经实例化完成
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "name" {
            self.name = value as? String
        }
    }
}
