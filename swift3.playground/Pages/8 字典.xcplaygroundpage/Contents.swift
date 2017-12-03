//: [Previous](@previous)

import Foundation

// 1 定义
func demo1 () {
    // oc 中定义字典 用{} swift 的中使用[]
     // [KEY:VALUE] [String: NSObject]
    let dict:[String:Any] = ["name":"张","age":18]
    print(dict)
    
    let array:[[NSString:Any]] = [
        ["name":"张","age":18],
        ["name":"张","age":19],
        ["name":"张","age":20],
        ["name":"张","age":21]
    ]
 print(array)
}

//demo1()

// 2 MARK:增删改
func demo2 () {
    // 可变/不可变 var/let
    var dict:[String:Any] = ["name":"张","age":18]
    // 新增 :如果 key 不存在就是添加
    dict["title"] = "姓名"
    print(dict)
    // 修改 : 字典中通过 key 取值的key 在字典中必须唯一 如果 key存在就是修改

    dict["name"] = "张三"
    print(dict)
    // 删除
    dict.removeValue(forKey: "name")
}

//demo2()

// 3 MARK:遍历
func demo3 () {
     let dict:[String:Any] = ["name":"张","age":18,"title":"哈哈"]
    for e in dict {
        print("\(e.key),\(e.value)")
    }
    for (key,value) in dict {
        print("\(key),\(value)")
    }

}

demo3()

// 4 MARK:合并
func demo4 () {
    var dict:[String:Any] = ["name":"张","age":18,"title":"哈哈"]
    let dict2 = ["name":"as","age":"12"]
    
    for e in dict2 {
        //如果 key 存在则 修改 如果不存在 则新增
        dict[e.key] = dict2[e.key]
    }
    
     print(dict)
}

demo4()
