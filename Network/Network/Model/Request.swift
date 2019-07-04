//
//  Request.swift
//  Network
//
//  Created by JiWuChao on 2019/7/4.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Alamofire

struct RequestInfo {
    static let baseURL = "http://id-api.longzhu.com/guard/room?pageIndex=1&pageSize=200&roomid=2241427"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}

enum Request:URLRequestConvertible {
        case list
    
        func asURLRequest() throws -> URLRequest {
            
            let url = try RequestInfo.baseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest.timeoutInterval = 60
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            
            return urlRequest
        }
        // 方法
        private var method:HTTPMethod {
            switch self {
            case .list:
                return .get
            }
        }
        
        private var path:String {
            switch self {
            case .list:
                return ""
            }
        }
    
    /*
     ["roomid":2241427,
     "pageSize":200,
     "version":"5.9.5",
     "pageIndex":1]
     
     */
        private var parameters:Parameters?{
            switch self {
            case .list:
                return nil
            }
        }
    
}

