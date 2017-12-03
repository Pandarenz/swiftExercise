//: [Previous](@previous)

import Foundation
import UIKit
// 1 MARK: 数组的定义
func demo() {
    // 与 oc 不一样 swift 中存放的基本数据类型不需要包装 oc 需要转化成 NSNumber 类型 或 NSValue
    let array = [1,2,3,4]//自动推到的结果是[Int]表示数组中存放的都是 Int

    print(array)
    
    let arrStr = ["1","2","3"] // 自动推到的结果是[String]表示数组中存放的都是 String
    print(arrStr)
    
    let point = CGPoint(x:100,y:100)
    
    let arr3 = [point]
    print(arr3)
    
    // 注意:混合数组 :开发中几乎不用 因为数组是根据 index 下标取数据 如果数组中数据不一样 自动推到的结果是[NSObject]
    // 在 swift 中 有一种类型 [AnyObject]-> 任意类型
    
    // 在 swift 中一个类可以没有任何父类 在 oc 中不可以
    // 注意:在混合数组中CG 结构体需要包装
    let arr4 : [Any] = ["2", 2, NSValue(cgPoint: point)]
    print(arr4)
}

//demo()

// 2 MARK : 数组的遍历

func demo2 (){
    let arrStr = ["one","two","three"]
     print("---按照下标进行遍历---")
    // 1> 按照下标进行遍历
    for i in 0..<arrStr.count { // 或者 0...arrStr.count
        print(i)
    }
   
     print("---for in 遍历元素---")
    // 2> for in 遍历元素
    
    for s in arrStr {
        print(s)
    }
    print("---enum block 遍历 1---")
    // 3> enum block 遍历 同时遍历内容和下标
    // e 是元组
    for e in arrStr.enumerated() {
        //print(e) // 输出下标和对应的内容
        print("\(e.offset) \(e.element) ")
    }
    print("---enum block 遍历 2---")
    // e 对应的是索引下标 s 是 索引下标e 对应的[String] 数组的值
    // e / s 名字可以随便取
    for (e,s) in arrStr.enumerated() {
        print(e,s)
    }
    
    print("----反序遍历----")
    for s in arrStr.reversed() {
        print(s)
    }
    print("--- 反序索引+ 内容 正确写法")
    // 先枚举 再反序
    for (e,s) in arrStr.enumerated().reversed() {
        print("\(e) \(s)")
    }
    //
     print("--- 反序索引+ 内容 错误写法")
    
    for (e,s) in arrStr.reversed().enumerated() {
        print("\(e) \(s)")
    }
}

//demo2()


//3 MARK: 数组的增删改查

func demo3 () {
    // oc中分为可变 NSMutableArray (var) / 不可边 NSArray (let)
    var muarr = ["zhang","wang","li","sun"]
    muarr.append("huang")
    print(muarr)
    // 修改
    muarr[0] = "老李"
    print(muarr)
    // 删除
    
    muarr.remove(at: 2)

    // 删除全部并且保留空间
    muarr.removeAll(keepingCapacity: true)
//    print(muarr)
    print(muarr.capacity)

}

//demo3()

// 4MARK: 数组的容量

func demo4() {
    // 定义一个数组 指定类型是存放 int 的数组 但是没有初始化
    
//    var arrCapacity :[Int]
//    // 给数组进行初始化
//    arrCapacity = [Int]()
    
    // 以上两句代码 可以合并成一句
    var arrCapacity = [Int]()
    print("初始化容量 \(arrCapacity.capacity)")
    
    for i in 0..<8 {
        arrCapacity.append(i)
         print("\(arrCapacity) 容量 \(arrCapacity.capacity)" )
    }
   /* print 结果
     初始化容量 0
     [0] 容量 2 // 插入元素时如果容量不够 容量 = 容量*2 (初始化为0 时 第一次就是2) 容量不够 直接在现有的基础上 * 2
     [0, 1] 容量 2
     [0, 1, 2] 容量 4
     [0, 1, 2, 3] 容量 4
     [0, 1, 2, 3, 4] 容量 8
     [0, 1, 2, 3, 4, 5] 容量 8
     [0, 1, 2, 3, 4, 5, 6] 容量 8
     [0, 1, 2, 3, 4, 5, 6, 7] 容量 8
    */
    
}

//demo4()


// 5 MARK: 数组的合并
func demo5() {
    var arr1 = ["1","2","3"]
    let arr2 = ["4","5"]
    arr1 += arr2
    // 注意两个数组合并时 两个数组的数据类型必须一至
    print(arr1)
    
    
    
}

demo5()
