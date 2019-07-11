//
//  LZNetworking.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya





extension MoyaProvider {
    @discardableResult
    open func request<T: Codable>(_ target: Target,
                                    model: T.Type,
                                    completed: ((_ returnData: T?,_ error:Error?) -> Void)?) -> Cancellable? {
        return request(target, completion: { (result) in
            guard let completion = completed else {return}
            guard let returnData = try? result.value?.map(model.self) else {
                completion(nil, result.error)
                return
            }
            completion(returnData,result.error)
        })
        
    }

    
}



