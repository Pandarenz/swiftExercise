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
            sleep(2)
            let path = Bundle.main.path(forResource: "content", ofType: "json")
            let data = try! Data(contentsOf: URL.init(fileURLWithPath: path!))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos =  try!decoder.decode(Photos.self, from: data)
                complate(true, photos.photos, nil)
            
        }
    }
    
   
}














