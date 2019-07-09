//
//  LZRequest.swift
//  Network
//
//  Created by JiWuChao on 2019/7/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


class LZRequest <T> where T:Codable {
    
    public var url: String;
    public var header: [String: String]?;
    public var params: [String: Any]?;
    public var success: ((_ jsonDict: Any?, _ model: T?) -> Void)?;
    public var failure: ((_ error: LZRequestError?) -> Void)?;
    public var failureOnce: ((_ error: LZRequestError?) -> Void)?;

    private var responseModel:T?
    
    
    //初始化
    init(url: String, header:[String: String]?, params:[String: Any]?, success:((_ jsonDict: Any?, _ model: T?) -> Void)?, failure: ((_ error: LZRequestError?) -> Void)?) {
        self.url = url;
        self.header = header;
        self.params = params;
        self.success = success;
        self.failure = failure;
        
        self.addDefaultParamsAndHeaders();
    }
    
    
    
    private func addDefaultParamsAndHeaders(){
        if let dp = self.defaultParams() {
            for key in dp.keys {
                if self.params == nil {
                    self.params = [:];
                }
                if self.params?[key] == nil {
                    self.params?[key] = dp[key];
                }
            }
        }
        
        if let dh = self.defaultHeaders() {
            for key in dh.keys {
                if self.header == nil {
                    self.header = [:];
                }
                if self.header?[key] == nil {
                    self.header?[key] = dh[key];
                }
            }
        }
    }
    
    
    //TODO: 加入默认参数
    public func defaultParams() -> [String: Any]? {
        return nil;//LZNetworkClient.sharedInstance()?.defaultParams()
    }
    
    //TODO：加入默认header
    public func defaultHeaders() -> [String: String]? {
        return nil //LZNetworkClient.sharedInstance()?.defaultHeaders();
    }
}
