//
//  SNRequestHandlingPlugin.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

// MARK: SNRequestHandlingPlugin

public class SNRequestHandlingPlugin: PluginType {
    
   public init() {
        
    }
    /// Called to modify a request before sending
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {

        return request;
    }
    
}
