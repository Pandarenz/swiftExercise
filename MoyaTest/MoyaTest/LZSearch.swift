//
//  LZSearch.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation
import Moya

enum LZSearch {
    case searchHot
    case searchRelative(inputText: String)
    //搜索结果
    case searchResult(argCon: Int, q: String)
}

//let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<LZSearch>.RequestResultClosure) -> Void in
//    let defaultHeader = ["name":"longzhu",
//                         "devaceid":"1"]
//    let header = endpoint.httpHeaderFields
//    
//    
//    
//    if var urlRequest = try? endpoint.urlRequest() {
//        urlRequest.timeoutInterval = 20
//        closure(.success(urlRequest))
//    } else {
//        closure(.failure(MoyaError.requestMapping(endpoint.url)))
//    }
//}
//
//
//let myEndpointClosure = { (target: LZSearch) -> Endpoint in
//    
//    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
//    
//    
//    let endpoint = Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
//    
//    
//    
//    //在这里设置你的HTTP头部信息
//    return endpoint.adding(newHTTPHeaderFields: [
//        "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8",
//        "COOKIE" :  "JSESSIONID=jiwuchao",
//        "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*"
//        ])
//    
//    
//}

//let requestSet = {(endpoint:Endpoint,done:@escaping MoyaProvider<LZSearch>.RequestResultClosure) in
//    do {
//        var request:URLRequest = try endpoint.urlRequest()
//        request.timeoutInterval = 15
//        done(.success(request))
//    } catch {
//        print("错误了\(error)")
//    }
//}


//init(plugins: [RequestHandlingPlugin()])
let LZSearchProvider = MoyaProvider<LZSearch>.init(
    manager:  LZNetworking<LZSearch>().manager,
                                                   plugins: [RequestHandlingPlugin()])

extension LZSearch:TargetType {
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
    }
    
    var path: String {
        switch self {
        case .searchHot:
            return "search/hotkeywordsnew"
        case .searchRelative:
            return "search/relative"
        case .searchResult:
            return "search/searchResult"
        }
    }
    
    var method:Moya.Method{
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .searchHot:
            break
        case .searchRelative(let inputText):
            parmeters["inputText"] = inputText
            break
        case .searchResult( let argCon, let q):
            parmeters["argCon"] = argCon
            parmeters["q"] = q
            break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
    
}
