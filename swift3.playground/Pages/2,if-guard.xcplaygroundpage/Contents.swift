//: [Previous](@previous)

import Foundation

/// guard － 是和 if let 刚好相反的指令



func demo() {

    let oName: String? = "张三"
    let oAge: Int? = 20
    
    guard let name = oName else {
        print("name 为 nil")
        return
    }
    
    guard let age = oAge else {
        print("age 为 nil")
        return
    }
    
    // 代码执行到此,name 和 age 一定有值
    // 在实际开发中，复杂的代码在条件判断之后
    // 使用 guard 会让嵌套层次少一层！
    print("Hi \(name) --- \(age)")

}

demo()

