//
//  DownloadVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

//定义下载的DownloadDestination（不改变文件名，遇到同名文件会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!),
            [.removePreviousFile])
}

//保存的名称
let timeInterval:TimeInterval = Date().timeIntervalSince1970
let saveName = "\(Int(timeInterval)).png"

class DownloadVM {
    
    let provider = MoyaProvider<Download>.init(plugins: [RequestHandlingPlugin()])
    
    func startDownload() {
        provider.request(Download.Image(download: DefaultDownloadDestination)) { (result) in
            switch result {
            case .success(let value):
                
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(saveName)
                let image = UIImage(contentsOfFile: localLocation.path)
                print("下载完毕！保存地址：\(localLocation)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
