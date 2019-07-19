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
    // 主要为了取消一个request: request?.cancel()
    private var request:Cancellable?
    
    
    func getVipData() {
        
        request = LZVip.vipList.request(model: LZVipModel.self, success: { (model) in
            if let m = model as? LZVipModel {
                    print("vip \n")
                    print(m.data?.returnData?.newVipList?.count as Any)
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
