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


let networking = MoyaProvider<MultiTarget>.init(plugins: [RequestHandlingPlugin]())

class LZNetworking {
    
    public static let `default`:LZNetworking = LZNetworking()
    
    let provider = MoyaProvider<MultiTarget>.init(plugins: [RequestHandlingPlugin]())
}

extension MoyaProvider {
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

}



