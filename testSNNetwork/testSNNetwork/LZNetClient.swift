//
//  LZNetClient.swift
//  testSNNetwork
//
//  Created by JiWuChao on 2019/7/22.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import SNNetwork

class LZNetClient {
    
    
    lazy var config: Configuration = {
        let con = Configuration.init()
            con.timeoutInterval = 15
//            con.addingHeaders = [:]
//            con.plugins = [AddDefaultPlugin()]
        return con
    }()
    
    public static let `default`: LZNetClient = LZNetClient.init()
    
    init() {
        let networ = LZNetworking.init(configuration: config)
        
    }
    
}
