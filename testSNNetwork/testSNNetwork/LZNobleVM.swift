//
//  LZNobleVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya
import SNNetwork

class LZNobleVM {
    
    func getNobleList(roomid:String,pageIdx:Int = 1) {
         LZNoble.list(roomid: roomid, pageIdx: pageIdx).requestCleanJson(model: Root.self, success: { (rootModel) in
            if let root = rootModel as? Root {
                print("守护请求成功: \(root.items?.first?.userName ?? "failure")")
            }
        }) { (error) in
            print("守护失败：\(error.debugDescription)")
        }
        
    }
    
    
}
