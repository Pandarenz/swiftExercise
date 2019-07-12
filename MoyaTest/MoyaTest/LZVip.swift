//
//  LZVip.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

// MARK: VIP 模块

enum LZVip {
    case vipList

}

//
let LZVipProvider = MoyaProvider<LZVip>.init(plugins: [RequestHandlingPlugin()])
//MoyaProvider<MultiTarget>.init(endpointClosure: <#T##(MultiTarget) -> Endpoint#>, requestClosure: <#T##(Endpoint, @escaping (Result<URLRequest, MoyaError>) -> Void) -> Void#>, stubClosure: <#T##(MultiTarget) -> StubBehavior#>, callbackQueue: <#T##DispatchQueue?#>, manager: <#T##Manager#>, plugins: <#T##[PluginType]#>, trackInflights: <#T##Bool#>)

extension LZVip:TargetType {
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
    }
    
    var path: String {
        return "list/vipList"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        let parmeters:[String:Any] = [:]
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
         return nil
    }
    
    
    
    
    
}

