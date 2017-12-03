//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

// if let 与 if guard 使用技巧

// 使用同名的变量接收值 在后续的使用都是非空值 不需要解包 还可以避免取名字的烦恼

func demo (name:String?,age:Int?) {
    if let name = name, let age = age {
        print(name + String(age))
    }
    
    guard let name = name, let age = age else {
        print("名字或者年龄为空 ")
        return;
    }
    print(name + String(age))
}

  demo(name: "老姬", age: 20)