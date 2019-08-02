//
//  RouterManager.swift
//  testCrossroad
//
//  Created by JiWuChao on 2019/8/1.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Crossroad

struct User {
    let name: String
}
extension User: Extractable {
    static func extract(from string: String) -> User? {
        return User(name: string)
    }
}

class RouterManager {
    
    public static let manager = RouterManager.init()
    
    private let routers = Router<[String:Any]>(scheme: "SNRouter")
    
    
    private let router = Router<User>(scheme: "foobar")
    
    func register() {
        router.register([
            ("foobar://pokemons", { context in
                let userInfo: User = context.userInfo
                print(userInfo)
                return true
            })
            ])
        router.register([
            ("foobar://pokemons/jsjjs?name=zhangsan", { context in
                let userInfo: User = context.userInfo
                print(userInfo)
                return true
            })
            ])
        
        
    }
    
    func registers()  {
        routers.register ([
            ("://fine", { context in
                let userInfo:[String:Any] = context.userInfo
                print(userInfo)
                return true
            })
            ])
    }
    
    
    func openTestVC() {
        
        router.openIfPossible(URL.init(string: "foobar://pokemons")!, userInfo: User.init(name: "ceshi"))
        router.openIfPossible(URL.init(string: "foobar://pokemons/jsjjs?name=zhangsan")!, userInfo: User.init(name: "ceshi"))
        
        
    }
    
    func open() {
        routers.openIfPossible(URL.init(string: "fine")!, userInfo: ["userName":"zhangsan"])
    }
    
}
