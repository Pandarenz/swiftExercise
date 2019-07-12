//
//  LZNobleAPI.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

class LZNobleAPI {
    
    enum LZNoble {
        case list( roomid:String, pageIdx:Int )
    }
    //MoyaProvider<LZSearch>.init(
//    manager:  LZNetworking<LZSearch>().manager,
//    plugins: [RequestHandlingPlugin()])
    
    //init( plugins: [RequestHandlingPlugin()])
//    let provider = MoyaProvider<LZNoble>.init(
//        manager:  LZNetworking<LZNoble>().manager,
//        plugins: [RequestHandlingPlugin()])
    
    let provider = MoyaProvider<LZNoble>.init( plugins: [RequestHandlingPlugin()])

}

extension LZNobleAPI.LZNoble :TargetType {
    var baseURL: URL {
        return URL.init(string: "https://id-api.longzhu.com")!
    }
    
    var path: String {
        return "guard/room"
    }
    
    var method:Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "222".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .list(let roomid, let pIdx):
            
            let param:[String:Any] = ["roomid":roomid,
                                      "pageSize":"200",
                                      "pageIndex":pIdx
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}



