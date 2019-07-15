//
//  Download.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya


enum Download:TargetType {
    
    case MV(download:DownloadDestination)
    case Image(download:DownloadDestination)
}
//http://image.chnpec.com/img/photoworkspace/contentimg/2019/05/22/2019052216041434426.jpg
extension Download {
    var baseURL: URL {
        switch self {
        case .Image(_):
            return URL.init(string: "http://image.chnpec.com/img/photoworkspace/contentimg/2019/05/22/2019052216041434426.jpg")!
        case .MV(_):
            return URL.init(string: "http://113.105.248.47/7/i/z/k/q/izkqgqywhfwpnrtqwmaswobxprggmq/sh.yinyuetai.com/8697016A335B24C07B3A5E52B7AE9EE6.mp4")!
        }
    }
    var path: String {
        return ""
    }
    
    var method:Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        
        switch self {
        case .Image(let download):
            return .downloadDestination(download)
        case .MV(let download):
            return .downloadDestination(download)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

