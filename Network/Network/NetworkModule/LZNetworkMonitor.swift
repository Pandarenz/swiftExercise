//
//  LZNetworkMonitor.swift
//  Network
//
//  Created by JiWuChao on 2019/7/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Alamofire

enum LZNetworkStatus:Int {
    case unknown = -1
    case notReachable = 0
    case wwan = 1
    case wifi = 2
}



struct LZNetworkMonitor {
    
    let net = NetworkReachabilityManager.init()
    
    public var networkStatus:LZNetworkStatus = .unknown
    
    private static var sInstance: LZNetworkMonitor? = nil;
    
    public static func sharedInstance() -> LZNetworkMonitor?{
        if sInstance == nil {
            sInstance = LZNetworkMonitor();
            sInstance?.start()
        }
        return sInstance;
    }

    public func start() {
        net?.startListening()
        net?.listener = { status in
            switch status {
            case .notReachable:
                LZNetworkMonitor.sInstance?.networkStatus = LZNetworkStatus.notReachable
            case .unknown:
                LZNetworkMonitor.sInstance?.networkStatus = LZNetworkStatus.unknown
            case .reachable(.wwan):
                LZNetworkMonitor.sInstance?.networkStatus = LZNetworkStatus.wwan
            case .reachable(.ethernetOrWiFi):
                LZNetworkMonitor.sInstance?.networkStatus = LZNetworkStatus.wifi
            
            }
        }
    }
    
    
    public func stop() {
        net?.stopListening()
    }
    
}
