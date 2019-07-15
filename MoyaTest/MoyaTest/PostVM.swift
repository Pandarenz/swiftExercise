
//
//  PostVM.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


class PostVM {
    
    func getPost() {
        LZNetworking().request(PostAPI.post, model: [PostModel].self, success: { (model) in
            if let m = model as? [PostModel] {
                print(m)
            }
        }) { (error) in
            print(error.debugDescription)
        }
    }
}
