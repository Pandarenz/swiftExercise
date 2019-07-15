//
//  DownloadVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya
let timeInterval:TimeInterval = Date().timeIntervalSince1970
let saveName = "\(Int(timeInterval)).png"
class DownloadVM {
    
    let provider = MoyaProvider<Download>.init(plugins: [RequestHandlingPlugin()])
    
    func startDownload() {
        provider.request(Download.Image) { (result) in
            switch result {
            case .success(let value):
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(saveName)
                let image = UIImage(contentsOfFile: localLocation.path)
                print("下载完毕！保存地址：\(localLocation)")
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
