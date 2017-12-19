//
//  ViewController.swift
//  枚举
//
//  Created by JiWuChao on 2017/10/28.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        swithcEnum()
        barCode()
        rawValue()
        digui()
    }
    
    
    
    //1 使用 Switch 语句匹配枚举值
    func swithcEnum()  {
        let  passponit = CompassPoint.west
        switch passponit {
        case .north:
            print("north")
        case .south:
            print("sorth")
        case .east:
            print( "east")
            //        case .west:
        //            print( "west")
        default:
            print( "unknow")
        }
    }
    // 2 关联值
    func barCode() -> () {
        var protectBarcode = Barcode.upc(10, 2020, 203, 2)
        protectBarcode = .qrCode("哈哈哈?")
//        protectBarcode = .upc(12, 12, 12, 21)
        switch protectBarcode {
        case .upc(let nub, let fas, let protect, let check):
            print("UPC:\(nub),\(fas),\(protect),\(check)")
        case .qrCode(let pre):
            print("QR code:\(pre)")
     }
    }
    // 3 原始值
    func rawValue() {
        let earths = Original.mars.rawValue
        print( "earths-->:\(earths)")
        
    }
    // 4 递归
    func digui() {
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        
        print(evaluate(product))
        
    }
    func evaluate(_ expression:ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left,right):
            return evaluate(_:left) + evaluate(_:right)
        case let .multiplication(left,right):
            return evaluate(_:left) * evaluate(_:right)
            
//        default:
//
        }
    }
    
}

