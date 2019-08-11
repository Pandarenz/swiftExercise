//
//  SJCommentItemFrame.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation
import UIKit
// 包含内容和内容的 frame 的 model
struct SJCommentItemFrame:Codable {
    //当前评论的高度
    var height:CGFloat = 0
    
    var item:SJCommentItemModel?
    
     
}
