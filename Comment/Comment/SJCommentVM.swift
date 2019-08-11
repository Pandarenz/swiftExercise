//
//  SJCommentVM.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

struct SJCommentVM {

    var datas = [SJCommentTopicModel]()
    
    func getDatas() -> [SJCommentTopicModel] {
        var topic = [SJCommentTopicModel]()
        for i in 0..<10 {
            var topicModel = SJCommentTopicModel.init()
            topicModel.content = "我第\(i)个评论的"
            topicModel.topicID = "1000\(i)"
            var items = [SJCommentItemModel]()
            for j in 0..<3 {
                var item = SJCommentItemModel()
                 item.content = "我是第\(j+1)个评论第\(i)个评论的我是第\(j+1)个评论第\(i)个评论的我是第\(j+1)个评论第\(i)个评论的我是第\(j+1)个评论第\(i)个评论的我是第\(j+1)个评论第\(i)个评论的我是第\(j+1)个评论第\(i)个评论的"
                items.append(item)
            }
            topicModel.items = items
            
            topic.append(topicModel)
        }
        return topic
    }
    
    func getFrameData(data:[SJCommentTopicModel]) -> [SJCommentTopicFrame] {
        //
        
        var frameDatas = [SJCommentTopicFrame]()
        
        for topic in data {
           var topicF = SJCommentTopicFrame()
           topicF.topicH = topic.content?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 30, font: UIFont.systemFont(ofSize: 13)) ?? 0 + 50
           topicF.topicM = topic
            var commentFrames = [SJCommentItemFrame]()
            if let items = topic.items {
                for item in items {
                    var itemF = SJCommentItemFrame()
                    itemF.height = item.content?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 80, font: UIFont.systemFont(ofSize: 13)) ?? 0 + 50
                    itemF.item = item
                    commentFrames.append(itemF)
                }
            }
            topicF.commentItemFrames = commentFrames
            
            frameDatas.append(topicF)
        }
        return frameDatas
    }
    
    func change(frames:[SJCommentTopicFrame]) -> [SJCommentTopicFrame] {
    
//        var frames = frames
////        frames.first?.commentItemFrames?.first?.item?.content = "hhahahahahahahahahahah"
//        var topicFrame = frames.first
//         <#name#> = <#value#>
//
        var tempframe = frames
        
        var itemF = tempframe[0]
        var items = SJCommentItemFrame()
        var item = SJCommentItemModel()
        item.content = "@我是第一个恢复的:我是测试而已,不要紧张哈哈哈哈哈哈哈哈"
        
        items.item = item
        items.height = item.content?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 80, font: UIFont.systemFont(ofSize: 13)) ?? 0 + 50
        itemF.commentItemFrames?.append(items)
        tempframe[0] = itemF
//        for i in 0..<frames.count {
//            if i == 3 {
//                var itemF = frames[i]
//                var items = SJCommentItemFrame()
//                var item = SJCommentItemModel()
//                item.content = "@我是第一个恢复的:我是测试而已,不要紧张哈哈哈哈哈哈哈哈"
//                items.item = item
//                itemF.commentItemFrames?[1] = items
//            }
//
//        }
    
        return tempframe
    }
    
}
