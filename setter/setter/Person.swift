//
//  Person.swift
//  setter
//
//  Created by JiWuChao on 2017/11/2.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class Person: NSObject {
    // getter / setter 仅供参考 实际开发不用
   private var _name :String?
    var name: String? {
        get {
            //返回成员变量
            return _name
        }
        set {
            //为成员变量赋值
            _name = newValue
        }
    }
    
    // swift 的只读属性 又称为计算型属性 -> 本身只保存内容 都是通过计算获得
    var title: String {
        return "M.r" + (name ?? "")
    }
     
}
