//
//  LZSearchModel.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

//MARK:Search relative

struct LZSearchRelative:Codable {
    var code:Int = 0
    var data:LZSearchData?
 
}

struct LZSearchData:Codable {
    var stateCode:Int = 0
    var message:String?
    var returnData:[LZSearchRetureData]?
    
}

struct LZSearchRetureData:Codable {
    var comic_id:String?
    var name:String?

}


