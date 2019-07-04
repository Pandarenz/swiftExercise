//
//  LZListVM.swift
//  Network
//
//  Created by JiWuChao on 2019/7/4.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Alamofire

struct LZListVM {
    
    var items:[Item]?
    
    func getListData(completion:@escaping (_ response: [Item]?, _ error: String?)->Void) {
//        Alamofire.request(RequestInfo.baseURL).responseJSON { (response) in
//            print(response)
//        }
//
        
        
        AF.request(Request.list).responseDecodable { (response:DataResponse<Root>) in
            switch response.result {
            case .success:
                completion(response.value?.items,nil)
            case .failure(let error):
                completion(nil,error.localizedDescription)
            }
        }
 
    }
}
