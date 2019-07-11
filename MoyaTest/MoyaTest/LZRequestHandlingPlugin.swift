//
//  LZRequestHandlingPlugin.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

// MARK: RequestHandlingPlugin

class RequestHandlingPlugin: PluginType {
    
    /// Called to modify a request before sending
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        mutateableRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        mutateableRequest.timeoutInterval = 15
        
        return mutateableRequest.appendCommonParams();
    }
    
}
