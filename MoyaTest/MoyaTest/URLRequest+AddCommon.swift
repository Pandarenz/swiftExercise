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
    private var commonParams: [String: Any] {
        return [
            "device" : "ios",
            "appstore_id" : "123288392"
        ]
    }
    
    /// 默认请求头
    private var commonHeaderFields: [String : String] {
        
        return [
            "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8",
            "COOKIE" :  "JSESSIONID=jiwuchao",
            "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*",
            "access_token" : "******"
        ]
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

