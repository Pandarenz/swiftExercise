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

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<LZSearch>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let LZSearchProvider = MoyaProvider<LZSearch>(requestClosure: timeoutClosure)

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
