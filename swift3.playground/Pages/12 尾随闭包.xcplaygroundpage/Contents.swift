//: [Previous](@previous)

import Foundation


func loadData(completion:@escaping ( _ result: [String] ) -> () )->() {// completion:(result:[String])->() 闭包作为一个参数
    
    DispatchQueue.global().async {
        
        let json = ["头条","八卦","出大事了"]
        
        // 回调 -> 执行闭包(通过参数传递)
        
        print("耗时操作\(Thread.current)")
        completion(json)
    }
}

// 尾随闭包: 如果函数的最后一个参数是闭包,函数参数可以提前结束 最后一个参数直接使用 {} 包装闭包的代码

loadData { (result) in
    print(result)
}
