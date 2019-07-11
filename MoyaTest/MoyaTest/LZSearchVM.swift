//
//  LZSearchVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


class LZSearchVM {
    
    func getRelativeData()  {
//        LZSearchProvider.request(LZSearch.searchRelative(inputText: "龙珠"), model: LZSearchRelative.self) { (result,error) in
//            print("\n\n")
//            print(result?.data?.returnData?.first?.comic_id)
//            print(result?.data?.returnData?.first?.name)
//            print(error)
//        }
        
        LZSearchProvider.request(LZSearch.searchRelative(inputText: "龙珠"), model: LZSearchRelative.self) { (result, error) in
            print(result?.data?.returnData?.first?.comic_id)
            print(result?.data?.returnData?.first?.name)
        }
        
    }
 
}
