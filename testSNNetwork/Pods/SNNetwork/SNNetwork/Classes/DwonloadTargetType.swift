//
//  DwonloadTargetType.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya
//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
//private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
//    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [])
//}

typealias DownloadTargetType = DownloadTarget & TargetType & Codable

public protocol DownloadTarget {
    
    var downloadDir: URL { get }
    var destination:DownloadDestination {get}
    
}

public extension DownloadTarget {
    
    var downloadDir: URL {
        let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                     in: .userDomainMask)
        return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
}



