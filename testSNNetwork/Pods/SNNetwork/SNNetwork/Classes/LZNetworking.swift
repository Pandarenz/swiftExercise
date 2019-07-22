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


public class LZNetworking {
    
    
    private var configu:Configuration = Configuration.default
    
    init() {
        
    }
    
   public convenience init(configuration:Configuration) {
        self.init()
        configu = configuration
    }
    

    public static var defaultHeaders: (TargetType) -> [String: String] = { _ in [:] }
    
    public static let `default`: LZNetworking = {
        let confif = Configuration.default
            confif.plugins = [RequestHandlingPlugin()]
            confif.addingHeaders = defaultHeaders
        return LZNetworking.init(configuration: confif)
    }()
    

    
    lazy var custom: MoyaProvider<MultiTarget> = {
        let cus = MoyaProvider<MultiTarget>.init(configuration: self.configu)
        return cus
    }()
    
    
}

public class Configuration {
    
    public static var `default`: Configuration = Configuration()
    
    public var addingHeaders: (TargetType) -> [String: String] = { _ in [:] }
    
    public var replacingTask: (TargetType) -> Task = { $0.task }
    
    public var timeoutInterval: TimeInterval = 15
    
    public var plugins: [PluginType] = [RequestHandlingPlugin()]
    
    public init() {}
}

 
extension LZNetworking {
    
    // MARK: GET/POST
    @discardableResult
    open func request<T: Codable>(_ target: TargetType,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable? {

        let mutarget = MultiTarget.init(target)

        return custom.request(mutarget, model: model, success: success, failure: failure)
    }
    
    // MARK: 自定义字典转模型
    @discardableResult
    open func requestCleanJson<T: Codable>(_ target: TargetType,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable? {
        
        let mutarget = MultiTarget.init(target)
        
        return custom.requestCleanJson(mutarget, model: model, success: success, failure: failure)
    }
    
}





