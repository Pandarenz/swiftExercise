//: [Previous](@previous)

import Foundation


//MARK: -传统for 循环
func demo() {
    
    // 传统的写法 在 swift3.0 被取消
    // i++ / ++i 在 swift3.0 被取消
//    for var i = 0 ; i < 10  ; i ++ {
//        print("1")
//    }
    
}

//demo()

// ---------- 分割线

func demo1 () {
    // 范围定义是一个固定的格式 一定要注意空格
    // 区间 [0,5)
    for i in 0..<5 {
        print(String(i))
    }
    // 区间 [0, 5]
    for i in 0...5 {
        print(String(i))
    }
}

demo1()

// 反序遍历
func demo2 () {
    for i in (0...10).reversed() {
        print(i)
    }
}

demo2()


