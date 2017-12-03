//
//  ViewController.swift
//  函数
//
//  Created by JiWuChao on 2017/10/28.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test1(firtPara: 1, secondPara: 2)
        print(greet(person:  "laoji ", from: "hanan"))
        print(greet2( "laoji ", hometown:  "shanghai "))
        
        print(test2(sec: 343))
        
        print(arithmeticMean(numbers: 1,2,3,4,5))
        
        print(arithmeticMean(numbers: 1,2))
        // 6
        var some = 2
        var another = 34
        swapTwoInts(a: &some, b: &another)
        print("some = \(some) another = \(another)")
        // print : some = 34 another = 2
        // 7
        print(printMathResul(mathFunction: addTow(a:b:), a: 2, b: 4))
        print(printMathResul(mathFunction: multiplyTwoInts(a:b:), a: 2, b: 4))
        // 8 函数类型作为返回类型
        
        var currentValue = 4
        let moveNearToZero = chooseStep(backWard: currentValue > 0)
        print(currentValue)
        
        print("Counting to zero:")
        // Counting to zero:
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearToZero(currentValue)
        }
        print("zero!")
        
    }

    // 1 参数标签
    func test1 (firtPara:Int,secondPara:Int) {
        print("first")
    }
    // 2 指定参数标签
    func greet (person:String,from hometown:String) -> String {
        return "hello \(person)! Glad you could visit from \(hometown)"
    }
    // 3 忽略参数标签
    func greet2 (_ person:String, hometown:String) -> String {
        return "hello \(person)! Glad you could visit from \(hometown)"
    }
    //  4 默认参数值
    func test2(first: Int = 2, sec:Int ,third: String = "helll") -> String {
        return "\(first) + \(sec) +\(third)"
    }
    // 5 可变参数  可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数
    
    func arithmeticMean(numbers:Double...) -> Double {
        var total:Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    // 6 输入输出参数
    func swapTwoInts(a:inout Int,b:inout Int) {
        let tem = a
        a = b
        b = tem
    }
    // 7 函数作为参数类型
    // (Int,Int)-> Int 作为一个参数
    func printMathResul(mathFunction:(Int,Int)-> Int, a:Int ,b:Int )  {
        print("Result:\(mathFunction(a,b))")
    }
    
    func addTow(a:Int,b:Int) -> Int {
        return a + b
    }
     func multiplyTwoInts(a: Int, b: Int) -> Int {
        return a * b
    }
    
    // 8 函数类型作为返回类型
    
    func stepForward( input :Int) -> Int {
        return input + 1
    }
    
    func stepBack(input:Int) -> Int {
        return input - 1
    }
    
    func chooseStep(backWard:Bool) -> (Int)->Int {
        return backWard ? stepBack : stepForward
    }
}

