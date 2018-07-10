//
//  ViewController.swift
//  闭包
//
//  Created by JiWuChao on 2017/10/28.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        test11()
//        test1()
//        test2()
//        test3()
//        test4()
    }
    
    // 简单的闭包
    
    func test(){
        //1 无参 无反回值
        let b = {
            print( "heheh")
        }
        b()
        // 2 带参数的闭包
        /*
         1> 闭包中参数和返回值都写在 {} 中 使用关键字 'in' 分割定义和实现
         2> {形参列表 ->返回值类型 in 实现}
         */
        let b1 = { // 有参数 不返回值
            (x:Int) in
            print(x)
        }
        b1(2)
        let b2 = {// 有参数 有 返回值
            (x : Int, y:Int) -> Int in
            return x + y
        }
        print(b2(2, 2))
    }
    
    
    func test11() {
        
        loadData { (result) in
            print(result)
        }
        
    }
    
    func loadData(complation:@escaping (_ result:[String])->()) -> () {
        DispatchQueue.global().async {
            print("耗时操作")
        }
        Thread.sleep(forTimeInterval: 3)
        let json = ["haha","哈哈还","嗯嗯嗯"]
        DispatchQueue.main.async {
            print("主线程更新")
            complation(json)
        }
        
    }
    
    
    
    
    // 1闭包表达式
    func test1() {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: backword)
        print(reversedNames)
        names.sorted(by: {(s1:String,s2 :String)-> Bool in
            return s1>s2
        })
    }
    
    func backword(s1:String,s2:String) -> Bool {
        return s1 > s2
    }
    // 2 尾随闭包
    func test2() {
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
    
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
                
            } while number > 0
            return output
        }
        
    print(strings)
    }
    
    // 3 值捕获 闭包是引用类型
    
    func test3()  {
        let incrementByTen = makeIncremneter(forIncrement: 10)
        print(incrementByTen())
        print(incrementByTen())
        print(incrementByTen())
        print(incrementByTen())
    }
    
    func makeIncremneter(forIncrement amount:Int ) -> ()->Int {
        var runingTotal = 0
        func incrementer() ->Int { //嵌套函数 可以捕获期自身外面的值
            runingTotal += amount
            return runingTotal
        }
        return incrementer
    }
    
    // 4 逃逸闭包
    
    func test4()  {
        let instance = testClass()
        instance.doSomething()
        print(instance.x)
        
        instance.completionHandlers.first?()
        print(instance.x)
    }
    
   
    
    
    
    

}

 

