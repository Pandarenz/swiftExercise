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
    
    //MARK:字体
    
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的间距
    var titleMargin : CGFloat = 0
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
    
    
    //MARK: bottomLine
    
    var bottomLineColor : UIColor = UIColor.lightGray
    
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
    
    
//    config.isShowTrackLine = true
//    config.isShowCover = false
//    //            config.isNeedScale = true
//    config.scaleRange = 1.1
//    config.canScrollEnable = true
//    config.titleMargin = 20
//    config.firstTitleLeftMargin = 10
//    config.lastTitleFightMargin = 0
//    //            config.leftBarItem = leftBtn
//    config.rightBarItem = rightBtn
//    config.selectedColor = UIColor.red
//    config.normalColor = UIColor.black
//    config.defaultSelectedIndex = 0
//    config.coverRadius = 8
    
    /// 普通的样式
    ///
    /// - Parameters:
    ///   - navFrame: <#navFrame description#>
    ///   - isShowTrckLine: <#isShowTrckLine description#>
    ///   - canScrollEnable: <#canScrollEnable description#>
    ///   - titleMargin: <#titleMargin description#>
    ///   - firstTitleLeftMargin: <#firstTitleLeftMargin description#>
    ///   - lastTitleRightMargin: <#lastTitleRightMargin description#>
    ///   - selectedCorlor: <#selectedCorlor description#>
    ///   - normalColor: <#normalColor description#>
    ///   - defaultSelectedIndex: <#defaultSelectedIndex description#>
    ///   - font: <#font description#>
    convenience init(navFrame: CGRect,isShowTrckLine:Bool,
                     canScrollEnable:Bool,
                     titleMargin:CGFloat,
                     firstTitleLeftMargin:CGFloat,
                     lastTitleRightMargin:CGFloat,
                     selectedCorlor:UIColor,
                     normalColor:UIColor,
                     defaultSelectedIndex:Int = 0,font:UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.navFrame = navFrame
        self.isShowTrackLine = isShowTrckLine
        self.canScrollEnable = canScrollEnable
        self.titleMargin = titleMargin
        self.firstTitleLeftMargin = firstTitleLeftMargin
        self.selectedColor = selectedCorlor
        self.normalColor = normalColor
        self.isShowCover = false
        self.font = font
    }
    
    ///遮罩样式
    convenience init(navFrame: CGRect,coverBgColor :UIColor,coverAlpha:CGFloat ,coverMargin:CGFloat,coverH:CGFloat,coverRadius:CGFloat,canScrollEnable:Bool, titleMargin:CGFloat, firstTitleLeftMargin:CGFloat, lastTitleRightMargin:CGFloat, selectedColor:UIColor, normalColor:UIColor, defaultSelectedIndex:Int = 0,font:UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.isShowCover = true
        self.navFrame = navFrame
        self.coverBgColor = coverBgColor
        self.coverAlpha = coverAlpha
        self.coverMargin = coverMargin
        self.coverH = coverH
        self.coverRadius = coverRadius
        self.canScrollEnable = canScrollEnable
        self.titleMargin = titleMargin
        self.firstTitleLeftMargin = firstTitleLeftMargin
        self.lastTitleFightMargin = lastTitleRightMargin
        self.selectedColor = selectedColor
        self.normalColor = normalColor
        self.defaultSelectedIndex = defaultSelectedIndex
        self.font = font
    }
    

}
