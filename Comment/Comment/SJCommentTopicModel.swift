//
//  SJCommentTopicModel.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

/// 对内容的评论
struct SJCommentTopicModel:Codable {
    //评论的内容
    var content:String?
    //评论 id
    var topicID:String?
    // 子评论：对内容的评论的评论
    var items:[SJCommentItemModel]?
    
}
