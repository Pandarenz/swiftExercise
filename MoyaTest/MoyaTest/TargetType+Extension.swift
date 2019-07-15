//
//  TargetType+Extension.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

extension TargetType {
    
    @discardableResult
    public func request<T: Codable>(model: T.Type,
                            success: @escaping Success,
                            failure:@escaping Failure) -> Cancellable? {
        return LZNetworking.default.request(MultiTarget.init(self), model: model, success: success, failure: failure)
    }
}

