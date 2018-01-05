//
//  ArrayDisorder.swift
//  SwiftFramework
//
//  Created by JiWuChao on 2018/1/5.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class ArrayDisorder: NSObject {

  open func disorder (orders:Array<Any>) -> Array<Any> {
        var temp = orders
        var count = Int(temp.count)
        while count > 0 {
            let index = Int(arc4random() % UInt32(count))
            let last =  Int(count-1)
            temp.swapAt(index, last-1)
            count -= 1
        }
        return temp
    }
}


