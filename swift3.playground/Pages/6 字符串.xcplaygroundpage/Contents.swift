//: [Previous](@previous)

import Foundation
import UIKit

// 1>  MARK: 字符串的遍历

func demo() {
    let str:String = "好好好学习 swift"
    for c in str.characters {
        print(c)
    }
}

//demo()

// 2>  MARK: 字符串的长度
func demo2 () {

    let str:String = "hello world 你好"
    //1 字符串长度-- 返回指定编码的对应的字节个数
    //UTF8 的编码(0-4)每个汉字是3个字节
 print(str.lengthOfBytes(using: .utf8)) // 17
    //2 字符串长度-- 返回字符的个数
    print(str.characters.count)
    // 3 使用oc 中转 swift 中使用 `值 as 类型 ` 做类型转换
    
    let ocstr = str as NSString
    print(ocstr.length)
    
}

//demo2()

// 3 MARK: 字符串拼接

func demo3() {
    let name = "张三"
    let age = 15
    
    let title:String? = "test"
    
    // 规则 : \(常量/变量)
//    let str = "\(name) \(age) 岁 \(title)" // 直接加可选类型 输出会有可选标识 : 张三 15 岁 Optional("test")
    
    let str = "\(name) \(age) 岁 \(title ?? "")"
    print(str)
    
    // 可以拼接 point 类型
    let point = CGPoint(x: 100, y: 200)
    
    let str1 = "\(name) \(age) 岁 \(title ?? "") \(point)"
    print(str1)
    

}

demo3()


//4 MARK:- 格式化字符串

func demo4() -> () {
    let h = 8;
    let m = 9
    let s = 20
    let dateStr = "\(h):\(m):\(s)"
    
    print(dateStr)
    
    // 使用格式化字符串
    let dateStr2 = String(format:"%02d:%02d:%02d",h,m,s)
    
    print(dateStr2)
    
}

//demo4()

// 5 MARK: 字符串的子串

func demo5 (){
    let str = "我们一起写代码"
    // 1> 用 oc 中转
    let ocStr = str as NSString
    let str2 = ocStr.substring(to: 3)
    print(str2)
    
    // 2>   swift 3.0方法
    print(str.startIndex) //startIndex position: 0
    print(str.endIndex) //endIndex position: str.length
    
    let s1 = str.substring(from: "我们".endIndex)
    print(s1)
    
    let s2 = str.substring(from: "haha".endIndex)
    print(s2)
    
    // 注意: 上面的"我们" 和 "haha"和原字符串没有任何关系 只是用来取 index 的 
    
    // 
    guard let range = str.range(of: "我们") else {
        print("没有该字符串")
        return
    }
    
    let s3 = str.substring(with: range)
    print(s3)
    
    
}


demo5()
