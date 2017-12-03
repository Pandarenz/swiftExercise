//
//  testClass.swift
//  闭包
//
//  Created by JiWuChao on 2017/10/28.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class testClass: NSObject {
    func someFunction(closeur:()->Void) {
        closeur()
    }
    
    var x  = 10
    func doSomething()  {
        someFunction {
            self.x = 100
        }
        someFunction {
            x = 200
        }
    }
    
    
    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
}
