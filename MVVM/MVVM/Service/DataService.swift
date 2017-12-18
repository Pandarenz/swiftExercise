//
//  DataService.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/16.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

enum RequestError:String,Error {
    case noNetWork = "No Network"
    case serverOverload = "Server is overload"
    case permissionDenied = "You have no permission"
}


protocol DataServerProtocol {
    func fetchPopularPhoto(complate:@escaping (_ success:Bool,_ photo:[Photo],_ error:RequestError?) -> () )
}


class DataServer: DataServerProtocol {
    func fetchPopularPhoto(complate: @escaping (Bool, [Photo], RequestError?) -> ()) {
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "content", ofType: "json")
            let data = try! Data(contentsOf: URL.init(fileURLWithPath: path!))
            let decoder = JSONDecoder()
            if #available(iOS 10.0, *) {
                decoder.dateDecodingStrategy = .iso8601
            } else {
                // Fallback on earlier versions
            }
            let photos =  try!decoder.decode(Photos.self, from: data)
                complate(true, photos.photos, nil)
            
        }
    }
    
   
}














