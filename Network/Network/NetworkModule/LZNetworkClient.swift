//
//  LZNetworkClient.swift
//  Network
//
//  Created by JiWuChao on 2019/7/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


@objcMembers public class LZNetworkClient: NSObject {
    // MARK: 初始化
    
//    public static let `default`: SessionManager = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
//
//        return SessionManager(configuration: configuration)
//    }()
//    public static let `default`: LZNetworkClient = {
//        let client = LZNetworkClient()
//        client.
//        return client
//    }
    private static var sInstance: LZNetworkClient? = nil;
    public static func sharedInstance() -> LZNetworkClient?{
        if sInstance == nil {
            sInstance = LZNetworkClient();
            sInstance?.onInit();
        }
        return sInstance;
    }
    
    public static func destroyInstance(){
        LZNetworkMonitor.sharedInstance()?.stop()
        sInstance = nil;
    }
    
    public static func start(){
        _ = self.sharedInstance();
    }
    
    private func onInit(){
//        self.startAFNetworking();
         LZNetworkMonitor.sharedInstance()?.start()
    }
    
    
    func get(url:String?,parm:Parameters) -> <#return type#> {
        <#function body#>
    }
    
    
    
}
