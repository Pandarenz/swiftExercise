//
//  LZRootModel.swift
//  Network
//
//  Created by JiWuChao on 2019/7/4.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


struct Root:Codable {
    var totalOnline:Int = 0
    var totalItems:Int = 0
    var items:[Item]?
    
}

struct Item:Codable {
    
    var userId:Int = 0
    private var name :String?
    var userName:String? 
    var avatar:String?
    var grade:Int = 0 {
        didSet {
            print("grade")
        }
    }
    var newGrade:Int = 0
    var vipType:Int = 0
    var toUserId:Int = 0
    var toUserName:String?
    var isOnline:Bool = false
    
    var sportVipInfo:LZSportVipInfo?
    
    var type:Int = 0
    var expire:TimeInterval = 0
    var yearExpire:TimeInterval = 0
    var isExpired:Bool = false
    var isYearGuard:Bool = false
    
    var remainingDays:Int = 0
    var yearGuardRemainingDays:Int = 0 {
        didSet {
            print(yearGuardRemainingDays)
        }
    }
    
}

struct LZSportVipInfo:Codable {
    
    var customType:Int = 0
    var expire:TimeInterval = 0
    var sort:Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case customType = "type"
        case expire
        case sort
    }
}


