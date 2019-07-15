//
//  LZVipVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

class LZVipVM {
    
    init() {
        
    }
    
//    var request<T:Cancellable> = T()
    
    
    func getVipData() {
//      let request = LZNetworking.default.provider.request(MultiTarget(LZVip.vipList), model: LZVipModel.self) { (model,error) in
//            print(model?.data?.message)
//            print(error.debugDescription)
//        }
//
//        request?.cancel()
//        vip.request(LZVip.vipList, model: LZVipModel.self, success: { (model) in
//            if let m = model as? LZVipModel {
//                print(m.data?.message)
//            } else {
//                print("数据解析失败")
//            }
//        }) { (error) in
//            print(error.debugDescription)
//        }
        LZVip.vipList.request(model: LZVipModel.self, success: { (model) in
            if let m = model as? LZVipModel {
                    print("vip \n")
                    print(m.data?.message)
                } else {
                print("vip \n")
                print("数据解析失败")
                }
        }) { (error) in
            print("vip \n")
            print(error.debugDescription)
        }
    }
    
}
