//
//  URLRequest+AddCommon.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

extension URLRequest {
    
    /// 全局公共参数
    public var commonParams: [String: Any] {
        return [
            "device" : "ios"
        ]
    }
    
    /// 默认请求头
    public var commonHeaderFields: [String : String] {
        
        return [
            "access_token" : "******11"
        ]
    }
    
    public mutating func addCommonHeader(header:[String:String],commonParams:[String:Any]) ->URLRequest {
        
        let newHeaderFields = (allHTTPHeaderFields ?? [:]).merging(header) { (current, _) in current }
        allHTTPHeaderFields = newHeaderFields
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }
    
    
    mutating func appendCommonParams() -> URLRequest {
        let newHeaderFields = (allHTTPHeaderFields ?? [:]).merging(commonHeaderFields) { (current, _) in current }
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

