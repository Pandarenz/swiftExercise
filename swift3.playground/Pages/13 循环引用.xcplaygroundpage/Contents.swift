//: [Previous](@previous)

import Foundation

// 属性
var complationCallBack: (()->())?

func loadData (completion:@escaping ()->())->(){
    // 使用属性记录闭包 -> self 对闭包进行了引用
    complationCallBack = completion
    
    DispatchQueue.global().async { 
        print("耗时操作")
        completion();
    }
    
}

 