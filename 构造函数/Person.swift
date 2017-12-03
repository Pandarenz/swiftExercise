//
//  Person.swift
//  构造函数
//
//  Created by JiWuChao on 2017/10/14.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

/*
    构造函数的写法:
       1 给自己的属性分配空间并设置初始值
       2 调用父类的'构造函数' 给父类的属性分配空间并设置初始值
        NSObject 没有属性 只有一个成员变量 'isa'
 */

/*
 错误1: 'Person' cannot be constructed because it has no accessible initializers
   Person 类没有初始化器(s) -> 构造函数 可以有多个 默认是 init
 错误2: Property 'self.name' not initialized at implicitly generated super.init call
    调用父类的初始函数之前 属性 self.name 没有被初始化
 
 错误3:Property 'self.name' not initialized at super.init call
  提示 给 self.name 初始化 --> 分配空间,设置初始值
 
 */
class Person: NSObject {

    var name :String
    override init() {
        name = "li"
        super.init()
      
    }
    
}
