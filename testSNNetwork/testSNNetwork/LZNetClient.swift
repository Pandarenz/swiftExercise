//
//  LZNetClient.swift
//  testSNNetwork
//
//  Created by JiWuChao on 2019/7/22.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import SNNetwork

import Moya

class LZNetClient {
    
    public static let `default`: LZNetClient = {
        return LZNetClient.init()
    }()
    
    
    let networkActivityPlugin = NetworkActivityPlugin { (change,target) -> () in
        switch(change) {
        case .ended:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        case .began:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    
    
    let con = SNNetworkConfiguration.default
    
    init() {
        let configu = SNNetworkConfiguration.default
        
        configu.commonParams = ["device" : "ios&android",
                                "appstore_id" : "jiwuchao"]
        
        configu.commonHeaders = { target in
            
            return [
                "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8",
                "COOKIE" :  "JSESSIONID=jiwuchao",
                "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*",
                "access_token" : "******",
                "userName":"zhangsan"
            ]
            
        }
        configu.plugins = [networkActivityPlugin]
    }
    
    

    
}
