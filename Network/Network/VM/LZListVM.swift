//
//  LZListVM.swift
//  Network
//
//  Created by JiWuChao on 2019/7/4.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Alamofire

import SwiftyJSON

import CodableAlamofire

struct LZListVM {
    
    var items:[Item]?
    
    func getListData(completion:@escaping (_ response: [Item]?, _ error: String?)->Void) {

//        AF.request(Request.list).responseDecodable { (response:DataResponse<Root>) in
//            switch response.result {
//            case .success:
//                completion(response.value?.items,nil)
//            case .failure(let error):
//                completion(nil,error.localizedDescription)
//            }
//        }
//
        // codeAble
        
//        Alamofire.request(Request.list).responseJSON { (resopnse) in
//            switch resopnse.result {
//            case .success(let json):
//                let jsonDecoder = JSONDecoder()
//                do {
//                    guard let data = resopnse.data else {
//                        return
//                    }
//
//                    let bMovie = try jsonDecoder.decode(Root.self, from: data)
//                    print(bMovie)
//                    print("Name : " + "\(bMovie.items?.first?.userName)")
//                    print("avator :" + "\(bMovie.items?.first?.avatar)")
////                    print(bMovie.moviesGenere)
////                    print(json)
//                    completion(bMovie.items,nil)
//                } catch {
//                    print("Some Errors")
//                }
//                break
//            case .failure( let error):
//                print(error)
//                completion(nil,error.localizedDescription)
//                break
//            }
//        }
        // swiftJson
        
//        Alamofire.request(Request.list).responseJSON { (resopnse) in
//            switch resopnse.result {
//                    case .success(let json):
//                        do {
//                            if let data = resopnse.data {
//                                let models = try JSON(data: data)
//                                if let model = models as? Root {
//                                    print("Name : " + "\(model.items?.first?.userName)")
//                                    print("avator :" + "\(model.items?.first?.avatar)")
//                                } else {
//                                     print("error")
//                                }
//
//                            } else {
//                                print("error")
//                            }
//
//                        } catch {
//                            print("error")
//                        }
//                        break
//                    case .failure( let error):
//                         print(error)
//                        break
//                    }
//                }
        
        SessionManager.default.request(Request.list).responseDecodableObject(queue: nil, keyPath: nil, decoder: JSONDecoder()) { (response:DataResponse<Root>) in
            switch response.result {
            case .success(let value):
                completion(response.value?.items,nil)
                break
            case .failure(let error):
                completion(nil,error.localizedDescription)
                break
            }
        }
    }
}



