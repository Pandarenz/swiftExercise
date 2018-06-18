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
    
    var navFrame:CGRect = CGRect.zero
    
    var navBarBackgroundColor:UIColor = UIColor.white
    //默认选中第几个
    var defaultSelectedIndex :Int = 0
    
    //title的view是否可以左右滚动 一般情况下当title的个数固定的时候才需要设置为false
    var canScrollEnable :Bool = false
    //MARK:颜色
    
    //普通的Title 颜色
    var normalColor :UIColor = UIColor.white
    //选中的Title的颜色
    var selectedColor : UIColor = UIColor.black
    // Title的view的背景色
    var titleNorBgColor :UIColor?
    var titleSelectedBgColor :UIColor?
    
    
    //MARK: bottomLine
    
    var bottomLineColor : UIColor = UIColor.lightGray
    var bottomLineH :CGFloat = 0.5
    
    //MARK:字体
    
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的间距
    var titleMargin : CGFloat = 20
    /// titleView的高度
    var titleHeight : CGFloat = 44
    //第一个title 距离左边的距离
    var firstTitleLeftMargin : CGFloat = 0
    //最后一个title 距离右边的距离
    var lastTitleFightMargin : CGFloat = 0
    
    //MARK:底部滚动条
    
    /// 是否显示底部滚动条
    var isShowTrackLine : Bool = false
    /// 底部滚动条颜色
    var trackLineColor : UIColor = UIColor.orange
    /// 底部滚动条高度
    var trackLineH : CGFloat = 2
    /// 底部滚动条的宽度是否等宽 canScrollEnable 为 false 时有效isTrackDivide 表示宽度跟title的宽度一样
    var isTrackDivide: Bool = false
    
    //MARK:缩进
    
    /// 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2
    
    //MARK:遮盖
    
    /// 是否显示遮盖
    var isShowCover : Bool = false
    /// 遮盖背景颜色
    var coverBgColor : UIColor = UIColor.lightGray
    //遮盖的alpha值
    var coverAlpha : CGFloat = 0.7
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    /// 遮盖的高度
    var coverH : CGFloat = 25
    
    /// 设置圆角大小
    var coverRadius : CGFloat = 0
    
    //MARK:左右BarItem
    
    var leftBarItem : UIView?
    var rightBarItem : UIView?
    
    

}
