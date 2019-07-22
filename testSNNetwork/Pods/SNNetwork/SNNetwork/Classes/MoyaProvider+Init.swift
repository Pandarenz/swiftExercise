//
//  MoyaProvider+Init.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/18.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

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
    
    
    
    // MARK: 成功和失败在一个block中
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
    
    // MARK: 成功和失败在两个block中
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
    
    
    /*
      MARK: 自定义解析 字典转模型
         //resultValue.mapObj(model.self) else { }
         resultValue 是Response 类型 mapObj是对Response 的扩展 是对系统的Codable 的优化，因为
     系统的Coable如果在model中出现字段的类型和服务端下发的不一样的时候 整个序列化的结果是失败的
     */
    @discardableResult
    open func requestCleanJson<T: Codable>(_ target: Target,
                                  model: T.Type,
                                  success: @escaping Success,
                                  failure:@escaping Failure) -> Cancellable?{
        
        return request(target, completion: { (resut) in
            
            switch resut {
            case .success(let resultValue):
                guard let returnData = try? resultValue.mapObj(model.self) else {
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
