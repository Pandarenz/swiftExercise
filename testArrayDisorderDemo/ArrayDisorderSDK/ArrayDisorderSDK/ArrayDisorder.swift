//
//  ArrayDisorder.swift
//  ArrayDisorderSDK
//
//  Created by JiWuChao on 2018/1/6.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

open class ArrayDisorder: NSObject {
    
    public func disorder (orders:Array<Any>) -> Array<Any> {
        var temp = orders
        var count = Int(temp.count)
        while count > 0 {
            let index = Int(arc4random_uniform(UInt32(Int32(count))))
            let last =  Int(count-1)
            temp.swapAt(index, last)
            count -= 1
        }
        return temp
    }
}
