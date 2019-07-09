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
    
    
}
