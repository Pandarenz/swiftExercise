//
//  Download.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [])
}

//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

enum Download:TargetType {
    
    
    case MV
    case Image
}
//http://image.chnpec.com/img/photoworkspace/contentimg/2019/05/22/2019052216041434426.jpg
extension Download {
    var baseURL: URL {
        switch self {
        case .Image:
            return URL.init(string: "http://image.chnpec.com/img/photoworkspace/contentimg/2019/05/22/2019052216041434426.jpg")!
        case .MV:
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
        
        return .downloadDestination(DefaultDownloadDestination)
        
    }
    
    var headers: [String : String]? {
        return nil
    }
}


extension Download {
    
    
}
