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
      let request = LZVipProvider.request(LZVip.vipList, model: LZVipModel.self) { (model,error) in
            print(model?.data?.message)
            print(error.debugDescription)
        }
        
//        request?.cancel()
        
        
    }
    
}
