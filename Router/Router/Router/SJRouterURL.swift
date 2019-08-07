//
//  SJRouterURL.swift
//  Router
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

public struct SJRouterURL {
    // eg:SJModule://home/find/search?name=zhangs&age=19
    // SJModule
    let scheme: String?
    //home
    let host: String?
    //[find,search]
    let pathComponents: [String]?
    //SJModule://home/find/search?name=zhangs&age=19
    let pattern: String
    /*
     ["name":zhangsan,"age":19]
     */
    var parameters:[String:Any]?
    
    init(url:String) {
        
        let tempURL = URL.init(string: url)
        self.scheme = tempURL?.scheme
        self.host = tempURL?.host
        self.parameters = [String:Any]()
        self.pathComponents = [String]()
        self.pattern = tempURL?.absoluteString ?? ""
    }
    
}
