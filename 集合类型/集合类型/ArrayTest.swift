//
//  ArrayTest.swift
//  集合类型
//
//  Created by JiWuChao on 2017/11/8.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ArrayTest: NSObject {
 
    func textArr() {
        var someInts = [Int]()
        someInts.append(23)
        print("someInts is of type [Int] with \(someInts.count) items.")
        
        //1创建一个带有默认值的数组
        var threeDouble = Array(repeating: 2.5, count: 3)
        print(threeDouble)
        // [2.5, 2.5, 2.5, 2.5]
        // 2 通过两个数组相加创建一个数组
        var anotherThree = Array(repeating: 2.6, count: 3)
        var six = anotherThree + threeDouble
        
        print(six)// [2.6000000000000001, 2.6000000000000001, 2.6000000000000001, 2.5, 2.5, 2.5]
        //数组字面量构造数组
        
        var list = ["hahha","hshsh"]
        print("list= \(list)")
    }
    
    
    
}
