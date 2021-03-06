//
//  LZNobleAPI.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

let nobleProvider = MoyaProvider<LZNoble>.init(plugins: [RequestHandlingPlugin]())

class LZNobleAPI {
    
    let provider = MoyaProvider<LZNoble>.init( plugins: [RequestHandlingPlugin()])

}

enum LZNoble {
    case list( roomid:String, pageIdx:Int )
}

extension LZNoble :TargetType {
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



extension LZNoble {
    
}
