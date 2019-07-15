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
        LZNetworking.default.provider.request(MultiTarget(LZVip.vipList), model: LZVipModel.self, success: { (model) in
            if let m = model as? LZVipModel {
                print(m.data?.message)
            }
        }) { (error) in
            print(error.debugDescription)
        }
        
    }
    
}
