//
//  InsertSort.swift
//  Sort
//
//  Created by JiWuChao on 2018/6/19.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class InsertSort: NSObject {

    
    func insertSort(sortDatas:[Int])->[Int] {
        var origin = sortDatas
        
        if origin.count == 0 {
            return origin
        }
        var j:Int = 0
        
        var temp:Int = 0
        for i in 1..<origin.count {
            temp = origin[i]
            j = i - 1
            
            while (j >= 0 && temp < origin[j]){
                origin[j+1] = origin[j] //前一个和后一个交换位置
                j -= 1
            }
            origin[j+1] = temp
            
        }
        
        return origin
    }
    
}
