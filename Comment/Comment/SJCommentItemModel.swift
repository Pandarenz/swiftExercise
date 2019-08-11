//
//  SJCommentItemModel.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

// 每一个评论详情

struct SJCommentItemModel:Codable {
    // 评论的内容
    var content:String?
    // 评论的 id
    var cid:String?
    
}
