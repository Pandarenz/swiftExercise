//: [Previous](@previous)

import Foundation
import UIKit

func demo (num:Int){
    switch num {
    case 10:
        print("优")
    default:
        print("一般")
    }
    
}

/*
    1 switch 可以对任意类型的值进行分支 不在局限于整数(oc)
    2 switch 一般不需要 break
    3 switch 如果要多值 使用 ","
    4 所有的分支 至少需要一条指令 如果什么都不干 才使用 break
    5  可以使用 where 语句
 */


func demo2 (num:String){
    switch num {
    case "10","9":
        print("优")
        case "8":
        break // 什么都不干
    default:
        print("一般")
    }
    
}



func demo3 () {
    
    let point = CGPoint(x: 10, y: 10)
    switch point {
    case let p where p.x == 0 && p.y == 0:
        print("中心点")
    case let p where p.x == 0:
        print("Y轴")
    case let p where p.y == 0:
        print("X轴")
    case let p where abs(p.x) == abs(p.y):
        print("对角线")
    default:
        print("其他")
    }


}


demo(num: 10)

demo2(num: "10")

demo3()


