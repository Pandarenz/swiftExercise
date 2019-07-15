//
//  LZSearchVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation
import Moya

class LZSearchVM {
    
    func getRelativeData()  {

//        LZNetworking.default.request(MultiTarget(LZSearch.searchRelative(inputText: "龙珠")), model: LZSearchRelative.self) { (result, error) in
//            print(result?.data?.returnData?.first?.comic_id)
//            print(result?.data?.returnData?.first?.name)
//        }
        
//        LZNetworking().request(LZSearch.searchRelative(inputText: "龙珠"), model: LZSearchRelative.self, success: { (result) in
//            if let relative = result as? LZSearchRelative {
//                print(relative.data?.returnData?.first?.comic_id)
//                print(relative.data?.returnData?.first?.name)
//            } else {
//                print("搜索失误")
//            }
//        }) { (error) in
//            print(error.debugDescription)
//        }
        
        LZSearch.searchRelative(inputText: "龙珠").request(model: LZSearchRelative.self, success: { (result) in
            if let relative = result as? LZSearchRelative {
                print("search \n")
                print(relative.data?.returnData?.first?.comic_id)
                print(relative.data?.returnData?.first?.name)
            } else {
                print("search \n")
                print("搜索失误")
            }
        }) { (error) in
            print("search \n")
            print(error.debugDescription)
        }
        
        
    }
 
}
