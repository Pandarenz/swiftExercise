//
//  LZNobleVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


class LZNobleVM {
    
    lazy var network: LZNobleAPI = {
        let api = LZNobleAPI.init()
        return api
    }()
    
    func getNobleList(roomid:String,pageIdx:Int = 1) {
        
        network.provider.request(LZNobleAPI.LZNoble.list(roomid: roomid, pageIdx: pageIdx), model: Root.self) { (rootModel, error) in
            print("守护失败：\(error.debugDescription)")
            print("守护请求成功: \(rootModel?.items?.first?.userName ?? "failure")")
        }
    }
    
    
}
