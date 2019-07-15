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

class LZNetworking {
    
    
    private var configu:Configuration = Configuration.default
    
    init() {
        
    }
    
    convenience init(configuration:Configuration) {
        self.init()
        configu = configuration
    }
    
    public static let `default`:LZNetworking = LZNetworking()
    
    private let provider = MoyaProvider<MultiTarget>.init(plugins: [RequestHandlingPlugin]())
    
    lazy var config: Configuration = {
        let config = Configuration.default
            config.plugins = [RequestHandlingPlugin()]
        return config
    }()
    
    lazy var custom: MoyaProvider<MultiTarget> = {
        let cus = MoyaProvider<MultiTarget>.init(configuration: config)
        return cus
    }()
    
    
}

public class Configuration {
    
    public static var `default`: Configuration = Configuration()
    
    public var addingHeaders: (TargetType) -> [String: String] = { _ in [:] }
    
    public var replacingTask: (TargetType) -> Task = { $0.task }
    
    public var timeoutInterval: TimeInterval = 15
    
    public var plugins: [PluginType] = []
    
    public init() {}
}

extension LZNetworking {
    
   
    
    
}



extension LZNetworking {
    
 
    
    @discardableResult
    open func request<T: Codable>(_ target: MultiTarget,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable? {
        
        return custom.request(target, model: model, success: success, failure: failure)
    }
    
    @discardableResult
    open func request<T: Codable>(_ target: TargetType,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable? {
        
        let mutarget = MultiTarget.init(target)
        
        return custom.request(mutarget, model: model, success: success, failure: failure)
    }
}


extension MoyaProvider {
    
    convenience init(configuration: Configuration) {
        
        let endpointClosure = { target -> Endpoint in
            MoyaProvider.defaultEndpointMapping(for: target)
                .adding(newHTTPHeaderFields: configuration.addingHeaders(target))
                .replacing(task: configuration.replacingTask(target))
        }
        
        let requestClosure =  { (endpoint: Endpoint, closure: RequestResultClosure) -> Void in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = configuration.timeoutInterval
                closure(.success(request))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(.parameterEncoding(error)))
            } catch {
                closure(.failure(.underlying(error, nil)))
            }
        }
        
        self.init(endpointClosure: endpointClosure,
                  requestClosure: requestClosure,
                  plugins: configuration.plugins)
    }

    
    
    
    @discardableResult
    open func request<T: Codable>(_ target: Target,
                                  model: T.Type,
                                  completed: ((_ returnData: T?,_ error:Error?) -> Void)?) -> Cancellable? {
        return request(target, completion: { (resut) in
            guard let completion = completed else {return}
            switch resut {
            case .success(let resultValue):
                guard let returnData = try? resultValue.map(model.self) else {
                    completion(nil, resut.error)
                    return
                }
                completion(returnData,resut.error)
                break
                
            case .failure(let error):
                completion(nil,error)
                break
            }
        })
    }
    
    
    @discardableResult
    open func request<T: Codable>(_ target: Target,
                                    model: T.Type,
                                    success: @escaping Success,
                                    failure:@escaping Failure) -> Cancellable?{
        return request(target, completion: { (resut) in
            
            switch resut {
                case .success(let resultValue):
                    guard let returnData = try? resultValue.map(model.self) else {
                        success(nil)
                        return
                    }
                    success(returnData)
                break
                
            case .failure(let error):
                    failure(error)
                break
            }
        })
    }

}



