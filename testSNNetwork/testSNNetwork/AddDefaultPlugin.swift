//
//  AddDefaultPlugin.swift
//  testSNNetwork
//
//  Created by JiWuChao on 2019/7/22.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation
import Moya

class AddDefaultPlugin : PluginType {
    
    public init() {
        
    }
    /// Called to modify a request before sending
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        mutateableRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        mutateableRequest.timeoutInterval = 15
        let commonParams = ["device" : "ios",
                                          "appstore_id" : "123288392"]
       let commonHeaderFields = ["Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8",
                                                "COOKIE" :  "JSESSIONID=jiwuchao",
                                                "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*",
                                                "access_token" : "******"]
        return mutateableRequest.addCommonHeader(header: commonHeaderFields, commonParams: commonParams);
    }
    
}


extension URLRequest {
    mutating func addCommonParams() -> URLRequest {
        let newHeaderFields = (allHTTPHeaderFields ?? [:]).merging(commonHeaderFields) { (current, _) in current }
        allHTTPHeaderFields = newHeaderFields
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }
    public mutating func addCommonHeader(header:[String:String],commonParams:[String:Any]) ->URLRequest {
        
        let newHeaderFields = (allHTTPHeaderFields ?? [:]).merging(header) { (current, _) in current }
        allHTTPHeaderFields = newHeaderFields
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}
