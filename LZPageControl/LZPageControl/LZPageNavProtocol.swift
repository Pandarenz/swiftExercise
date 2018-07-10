//
//  LZPageNavProtocol.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/7/10.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

protocol LZPageNavProtocol:class {
    //刷新的方法
    func reloadData()
    
    /// 从一个index 滑动到另一个 index
    ///
    /// - Parameters:
    ///   - fIndex: 源index
    ///   - tIndex: 目的 index
    ///   - progress: 移动的进度
    func scrollFromIndexToIndex(fromIndex fIndex :Int , toIndex tIndex:Int , withProgress progress:CGFloat)
    
    
    /// 移动到某一个index
    ///
    /// - Parameter tIdx: 目的index
    func scrollToIndex(toIndex tIdx:Int)
    
    /// 移动结束
    func currentViewDidEndScroll()
    
}



protocol LZPageNavBarDelegate:class {
    //选中了某一个title Select
    func pageNavBarDidSelected(pageNavBar:LZPageNavBar ,oldIndex oIndex:Int ,oldObj:UILabel,newIndex nIndex:Int ,newObj:UILabel)
    
    //选中了左边的bar
    func pageNavBarDidSelectedLeftBar(pageNavBar:LZPageNavBar)
    //选中了右边的bar
    func pageNavBarDidSelectedRightBar(pageNavBar:LZPageNavBar)
}

extension LZPageNavBarDelegate {
    
    func pageNavBarDidSelectedLeftBar(pageNavBar:LZPageNavBar) {
        
    }
    
    func pageNavBarDidSelectedRightBar(pageNavBar:LZPageNavBar) {
        
    }
    
}
