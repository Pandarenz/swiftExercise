//
//  NavigatorRouter.swift
//  testCrossroad
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import URLNavigator

let navigator = Navigator()

class NavigatorRouter {
 
    public static let `default` = NavigatorRouter.init()
    
    func register() {
    
        navigator.handle("navigator://alert", self.alert(navigator: navigator))
    }
    
    private func alert(navigator: NavigatorType) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
    }
    func open() {
//        navigator.handler(for: "navigator://alert?title=Hello&message=World", context: ["name":"zhanhsan","age":18,"userid":123456])
        navigator.push("navigator://alert?title=Hello&message=World")
//        navigator.push("SJRouter://home/find/user/123212")
//        navigator.open("SJRouter://home/find/user", context: ["name":"zhanhsan","age":18,"userid":123456])
    }
    
    static func initialize(navigatorw: NavigatorType) {
        //handler(for: "SJRouter://home/find", context: ["name":"zhangsan","age":15])
        
        navigator.register("SJRouter://home/find/user") { (url, dic, content) -> UIViewController? in
            print(dic)
            print(url)
            print(content)
            return UIViewController.init()
        }
        
 
    }

    
}
