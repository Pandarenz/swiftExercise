//
//  LZNetworking.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

import Alamofire

public typealias  Success = (_ result:Any?)->Void
public typealias Failure = (_ error:Error?)->Void


public class SNNetwork {
    
    private let provider: MoyaProvider<MultiTarget>
    public init(configuration:SNNetworkConfiguration) {
        provider = MoyaProvider.init(configuration: configuration)
        
    }
    public static let `default`: SNNetwork = {
        let confif = SNNetworkConfiguration.default
//            confif.plugins = [RequestHandlingPlugin()]
        return SNNetwork.init(configuration: confif)
    }()
   
}

 
extension SNNetwork {
    
    // MARK: GET/POST
    @discardableResult
    open func request<T: Codable>(_ target: TargetType,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable? {

        let mutarget = MultiTarget.init(target)

        return provider.request(mutarget, model: model, success: success, failure: failure)
    }
    
    // MARK: 自定义字典转模型
    @discardableResult
    open func requestCleanJson<T: Codable>(_ target: TargetType,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable? {
        
        let mutarget = MultiTarget.init(target)
        
        return provider.requestCleanJson(mutarget, model: model, success: success, failure: failure)
    }
    
}





