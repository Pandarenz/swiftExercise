//
//  NetworkReachability.swift
//  testSNNetwork
//
//  Created by JiWuChao on 2019/7/23.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Alamofire

enum SNNetworkReachabilityStatus:Int {
    case unknown = 0// 未知
    case notReachable = 1 // 断网
    case ethernetOrWiFi = 2 // wifi
    case wwan = 4 // 4g
}



class NetworkReachability {
    
    public static let `default` = NetworkReachability.init()
    
    private let reachability = NetworkReachabilityManager.init()
    
    public var status = SNNetworkReachabilityStatus.unknown
    
    init() {
        
        reachability?.listener = { [weak self] status in
            
            switch status {
            case .notReachable:
                self?.status = .notReachable
                break
            case .unknown:
                self?.status = .unknown
                break
            case .reachable( let connectType):
                switch connectType {
                    
            case .ethernetOrWiFi:
                self?.status = .ethernetOrWiFi
                break
            case .wwan:
                self?.status = .wwan
                break
                 
                }
            }
            
        }
    }
    
    func startListening() {
        reachability?.startListening()
    }
    
    func stop() {
        reachability?.stopListening()
    }
}

