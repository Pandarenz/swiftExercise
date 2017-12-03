//: Playground - noun: a place where people can play

import UIKit

// if let
let oName: String? = "张三"
let oAge: Int? = 20

if oName != nil && oAge != nil {
    print("Mr" + oName! + "---" + String(oAge!))
}

// if let 可以设置数值，进入分支后，name 可以保证一定有值
if let name = oName {
    print("Hi " + name)
}

// 多值的设置，使用 , 分隔
// 注意：if let 语句中不能使用 && || 条件
if let name = oName, let age = oAge {
    print("Hi " + name + "---" + String(age))
}
