//
//  Response+Codable.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/18.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

import CleanJSON



public extension Response {
    
    func mapObj<T: Codable>(_ type: T.Type, atKeyPath path: String? = nil, using decoder: JSONDecoder = CleanJSONDecoder(), failsOnEmptyData: Bool = true) throws -> T {
        
        do {
            return try map(type, atKeyPath: path, using: decoder, failsOnEmptyData: failsOnEmptyData)
        } catch {
            throw MoyaError.objectMapping(error, self)
        }
    }
}
