//
//  LZVipModel.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

struct LZVipModel:Codable {
    var code:Int = 0
    var data:LZVipData?
}

struct LZVipData:Codable {
    var stateCode:Int = 0
    var message:String?
    var returnData:LZVipReturenData?
}


struct LZVipReturenData:Codable {
    var newVipList:[LZNewVipList]?
}

struct LZNewVipList:Codable {
    var comics:[LZVipComics]?
    var canMore:Bool = false
    var argName:String?
    var argValue:String?
    var titleIconUrl:String?
    var newTitleIconUrl:String?
    var maxSize:Int = 0
    var description:String?
}

struct LZVipComics:Codable {
    var comicId:Int = 0
    var name:String?
    var cover:String?
    var tags:[String]?
}
