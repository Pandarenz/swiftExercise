//
//  LZPageNavBarConfig.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/15.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

import Foundation

class LZPageNavBarConfig {
    //title的view是否可以左右滚动
    var canScrollEnable :Bool = false
    //MARK:颜色
    
    //普通的Title 颜色
    var normalColor :UIColor = UIColor.white
    //选中的Title的颜色
    var selectedColor : UIColor = UIColor.black
    // Title的view的背景色
    var titleBgColor :UIColor = UIColor.white
    
    //MARK:字体
    
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的字体间距
    var titleMargin : CGFloat = 20
    /// titleView的高度
    var titleHeight : CGFloat = 44
    
    //MARK:底部滚动条
    
    /// 是否显示底部滚动条
    var isShowTrackLine : Bool = false
    /// 底部滚动条颜色
    var trackLineColor : UIColor = UIColor.orange
    /// 底部滚动条高度
    var trackLineH : CGFloat = 2
    
    //MARK:缩进
    
    /// 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2
    
    //MARK:遮盖
    
    /// 是否显示遮盖
    var isShowCover : Bool = false
    /// 遮盖背景颜色
    var coverBgColor : UIColor = UIColor.lightGray
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    /// 遮盖的高度
    var coverH : CGFloat = 25
    
    /// 设置圆角大小
    var coverRadius : CGFloat = 12
    
    //MARK:左右BarItem
    
    // 是否有左边的bar
    var hasLeftBarItem : Bool = false
    //是否有右边的bar
    var hasRigtBarItem :Bool = false
    

}
