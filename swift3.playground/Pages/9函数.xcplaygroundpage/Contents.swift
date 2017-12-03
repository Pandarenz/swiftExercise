//: [Previous](@previous)

import Foundation

// 1 MARK: 函数的定义 格式 函数名(形参列表)-> 返回值类型 x y 形参
func sum (x: Int,y:Int)->Int {
    return x + y
}

//sum(x: 1, y: 2)

// 2 MARK: -外部参数
/*
    1 外部参数就是在 形参前面加一个名字
    2 外部参数不会影响函数内部的细节
    3 外部参数会让外部调用方法看起来更加直观
    4 外部参数如果用 _ ,在外部调用函数时会忽略形参的名字
    5 ***  在 swift 中 _可以忽略任何不感兴趣的值 (重要)
 */

func sum2 (num1 x: Int,num2 y:Int)->Int {
    return x + y
}
// 3 MARK: 外部参数就是在 形参前面加一个名字
//print(sum2(num1: 20, num2: 30))

func sum3 (_ x: Int ,_ y:Int) -> Int {
    return x + y
}


// 4 MARK: 外部参数如果用 _ ,在外部调用函数时会忽略形参的名字
//print(sum3(2, 5))


func sum4 (_ x: Int ,_ y:Int) -> Int {
    // 在 swift 中 _可以忽略任何不感兴趣的值
    for _ in 0...4 { // for i in 0...4 可以写成这样的 但是 i 永远执行不到
        print("哈哈哈")
    }
    return x + y
}

//print(sum4(2, 4))

// 5 MARK : 函数的默认值  (重要)
 /*
    通过给函数设置默认值,在调用的时候,可以以任意组合参数,如果不指定 就使用默认值
 */
func sum5(x:Int = 1,y: Int = 5) -> Int {
    return x + y;
}


//print(sum5())
//print(sum5(x: 2, y: 5))
//print(sum5(x: 2))


// 6 MARK: 无返回值 (知道就行 主要知识点在闭包)
 /*
  1 直接省略
  2 用 ()
  3 用 void
 */

func demo () {
    print("哈哈")
}

func demo2 () -> (){ // -> 前面表示执行 后面表示 输出到的 目标
    print("哈哈()")
}

func demo3 () -> Void {
    print("哈哈 Void")
}

//demo()
//demo2()
//demo3()





