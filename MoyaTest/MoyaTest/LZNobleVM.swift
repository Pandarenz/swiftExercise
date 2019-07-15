//
//  LZNobleVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

class LZNobleVM {
    
    lazy var noble: LZNobleAPI = {
        let  n = LZNobleAPI()
        return n
    }()
    
    func getNobleList(roomid:String,pageIdx:Int = 1) {
//        LZNetworking.default.request(MultiTarget(LZNoble.list(roomid: roomid, pageIdx: pageIdx)), model: Root.self) { (rootModel, error) in
//            print("守护失败：\(error.debugDescription)")
//            print("守护请求成功: \(rootModel?.items?.first?.userName ?? "failure")")
//        }
//        noble.provider.request(LZNoble.list(roomid: roomid, pageIdx: pageIdx), model: Root.self, success: { (rootModel) in
//            if let root = rootModel as? Root {
//                print("守护请求成功: \(root.items?.first?.userName ?? "failure")")
//            }
//
//        }) { (error) in
//             print("守护失败：\(error.debugDescription)")
//        }
        
        LZNoble.list(roomid: roomid, pageIdx: pageIdx).request(model: Root.self, success: { (rootModel) in
            if let root = rootModel as? Root {
                print("守护请求成功: \(root.items?.first?.userName ?? "failure")")
            }
        }) { (error) in
            print("守护失败：\(error.debugDescription)")
        }
        
    }
    
    
}
