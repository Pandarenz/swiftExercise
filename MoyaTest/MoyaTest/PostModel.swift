//
//  PostModel.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/15.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

struct PostModel:Codable {
    var userId:Int = 0
    var id:Int = 0
    var title:String?
    var body:String?
}

struct Posts:Codable {
    
}
