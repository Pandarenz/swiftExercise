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
let vipTimeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<LZVip>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let LZVipProvider = MoyaProvider<LZVip>(requestClosure: vipTimeoutClosure)

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

