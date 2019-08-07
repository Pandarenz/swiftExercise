//
//  SJRoute.swift
//  Router
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

class SJRoute {
    
    var url:SJRouterURL?
    var request:SJRouterRequest?  
    var handle:Handle?
    var complate:Complate?
    
     public init(url:SJRouterURL,request:SJRouterRequest?,handle:Handle?,complate:Complate?) {
        self.url = url
        self.request = request
        self.handle = handle
        self.complate = complate
    }
    
    init(url:String) {
        
    }
    
}

