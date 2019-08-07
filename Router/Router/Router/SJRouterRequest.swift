//
//  SJRouterRequest.swift
//  Router
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

public struct SJRouterRequest {
    
    var url : SJRouterURL
    var parameters:[String:Any]?
    
    public init (url:SJRouterURL,parameters:Parameters?) {
        self.url = url
        self.parameters = parameters
    }
    
}
