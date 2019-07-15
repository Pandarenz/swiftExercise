//
//  PostAPI.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

enum PostAPI :TargetType{
    
    
    case post
}

extension PostAPI {
    var baseURL: URL {
        return URL.init(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        return "/posts"
    }
    
    var method:Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        let para:[String:Any] = ["title": "title", "body": "body", "userId": 1]
        return .requestParameters(parameters: para, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
