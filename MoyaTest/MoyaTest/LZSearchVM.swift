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

        networking.request(MultiTarget(LZSearch.searchRelative(inputText: "龙珠")), model: LZSearchRelative.self) { (result, error) in
            print(result?.data?.returnData?.first?.comic_id)
            print(result?.data?.returnData?.first?.name)
        }
        
    }
 
}
