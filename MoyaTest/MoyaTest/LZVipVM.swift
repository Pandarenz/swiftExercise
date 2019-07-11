//
//  LZVipVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

class LZVipVM {
    
    
    func getVipData() {
        LZVipProvider.request(LZVip.vipList, model: LZVipModel.self) { (model,error) in
            print(model?.data?.message)
            print(error)
        }
    }
    
}
