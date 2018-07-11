//
//  LZPageNavBar.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit


//protocol LZPageNavBarDelegate : class {
//    //选中了某一个title Select
//    func pageNavBarDidSelected(pageNavBar:LZPageNavBar ,oldIndex oIndex:Int ,oldObj:UILabel,newIndex nIndex:Int ,newObj:UILabel)
//
//    //选中了左边的bar
//    func pageNavBarDidSelectedLeftBar(pageNavBar:LZPageNavBar)
//    //选中了右边的bar
//    func pageNavBarDidSelectedRightBar(pageNavBar:LZPageNavBar)
//
//}
//默认实现 ：swift的可选方法
//extension LZPageNavBarDelegate {
//   func pageNavBarDidSelectedLeftBar(pageNavBar:LZPageNavBar) {
//    
//    }
//    
//    func pageNavBarDidSelectedRightBar(pageNavBar:LZPageNavBar) {
//        
//    }
//    
//}


protocol LZPageNavDataSource :class {
    //返回title数组
    func pageNavBarTitles(pageNavBar:LZPageNavBar) -> [String]
    
}


class LZPageNavBar: UIView,LZPageNavProtocol {

    weak var delegate : LZPageNavBarDelegate?
    weak var dataSource :LZPageNavDataSource?
    fileprivate var titles :[String]?
    fileprivate var config : LZPageNavBarConfig
    
    var currentIndex :Int = 0
    fileprivate var oldIndex :Int = 0
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = config.navBarBackgroundColor
        return scrollView
    }()
    
    fileprivate lazy var splitLine:UIView = {
        let splitLine = UIView()
            splitLine.backgroundColor = config.bottomLineColor
            let h : CGFloat = 1.0
            splitLine.frame = CGRect(x: config.titleMargin, y: self.frame.height - h, width: self.frame.width, height: h)
        return splitLine;
    }()
    
    
    fileprivate lazy var trackLine : UIView = {
       let trackLine = UIView()
        trackLine.backgroundColor = self.config.trackLineColor;
        trackLine.isHidden = !self.config.isShowTrackLine
        return trackLine
    }()
    
    fileprivate lazy var coverView :UIView = {
       let coverView = UIView()
        coverView.backgroundColor = self.config.coverBgColor
        coverView.alpha = self.config.coverAlpha
        return coverView
    }()
    
    
    init(frame: CGRect,config : LZPageNavBarConfig) {
        self.config = config
        super.init(frame: frame)
        self.backgroundColor = self.config.navBarBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupTitleLblPosition()
        setupTrackLineLayout(animation: false)
    }
    
}

// MARK: 设置UI界面内容
extension LZPageNavBar {
    
  fileprivate  func setupUI() {
    currentIndex = config.defaultSelectedIndex
        //1 滚动视图
//    if let leftBar = config.leftBarItem {
        addSubview(config.leftBarItem)
//    }
        addSubview(scrollView)
//    if let rightBar = config.rightBarItem {
        addSubview(config.rightBarItem)
//    }
    
    let leftTap = UITapGestureRecognizer(target: self, action: #selector(leftBarItemClick(tap:)))
        config.leftBarItem.addGestureRecognizer(leftTap)
    let rightTap = UITapGestureRecognizer(target: self, action: #selector(rightBarItemClick(tap:)))
        config.rightBarItem.addGestureRecognizer(rightTap)
    
    setupLayout()
        // 添加底部分割线
        addSubview(splitLine)
        // 添加所有标题的label
        setupTitleLbls()
        // 设置Lbl的位置
        setupTitleLblPosition()
        // 设置底部的滚动条
    
        if config.isShowTrackLine {
            scrollView.addSubview(trackLine)
            setupTrackLineLayout(animation: false)
        }
        if config.isShowCover {
            setupCoverView()
        }
 
    }
        
    fileprivate func setupTitleLbls()  {
        if titleLabels.count > 0 {
            for (_,lbl) in (titleLabels.enumerated()) {
                lbl.removeFromSuperview()
            }
            titleLabels.removeAll()
        }
        for (index,title) in (titles?.enumerated())! {
            let lbl = UILabel()
            lbl.tag = index
            lbl.text = title
            lbl.font = config.font
            lbl.textColor = index == config.defaultSelectedIndex ? config.selectedColor : config.normalColor
            lbl.textAlignment = .center
            lbl.isUserInteractionEnabled = true
            lbl.backgroundColor = index == config.defaultSelectedIndex ? config.titleSelectedBgColor : config.titleNorBgColor
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLblClick(_:)))
            lbl.addGestureRecognizer(tap)
            titleLabels.append(lbl)
            scrollView.addSubview(lbl)
            
        }
    }
    
    fileprivate func setupTitleLblPosition() {
        
        var titleX : CGFloat = 0.0
        var titleW : CGFloat = 0.0
        let titleY : CGFloat = 0.0
        let titleH : CGFloat = frame.height
        
        let count = titles?.count
        
        for (index,lbl) in titleLabels.enumerated() {
            
            if config.canScrollEnable {
                let rect =  getTitleLblFrame(title: lbl.text ?? "", font: config.font)
                titleW = rect.width
                if index == 0 {
                    titleX = config.titleMargin * 0.5
                } else {
                    let preLbl = titleLabels[index - 1 ]
                    titleX = preLbl.frame.maxX + config.titleMargin
                }
            } else {
                titleW = (scrollView.bounds.width - CGFloat(count! - 1) * config.titleMargin) / CGFloat(count!)
                titleX = titleW * CGFloat(index) + config.titleMargin * CGFloat(index)
            }
            
            titleW = CGFloat(ceil(Double(titleW)))
            lbl.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            if index == config.defaultSelectedIndex {
//                let scale = config.isNeedScale ? config.scaleRange : 1.0
//                lbl.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        if config.canScrollEnable {
            if titleLabels.count > 0 {
                scrollView.contentSize = CGSize(width: (titleLabels.last?.frame.maxX)! + config.titleMargin * 0.5, height: 0)
                if scrollView.contentSize.width < scrollView.bounds.width {
                    scrollView.contentSize = scrollView.bounds.size
                }
            }
        }
    }
    
   /// 设置左右barItem的位置
   fileprivate func setupLayout() {
        config.leftBarItem.frame = CGRect(x: 0, y: self.bounds.origin.y, width: config.leftBarItem.frame.width, height: config.leftBarItem.frame.height)
        addSubview(config.leftBarItem)
        scrollView.frame = CGRect(x: config.leftBarItem.frame.maxX + config.firstTitleLeftMargin, y: self.bounds.origin.y, width: self.bounds.width - config.leftBarItem.frame.width - config.rightBarItem.frame.width - config.firstTitleLeftMargin - config.lastTitleRightMargin, height: self.bounds.height)
        config.rightBarItem.frame = CGRect(x:scrollView.frame.maxX + config.lastTitleRightMargin  , y: self.bounds.origin.y, width: config.rightBarItem.frame.width, height: config.rightBarItem.frame.height)
    }
    
    fileprivate func setupTrackLineLayout(animation ani :Bool) {
        if currentIndex >= titleLabels.count {
            return
        }
        let currentLbl = titleLabels[currentIndex]
        trackLine.frame.origin.x = (currentLbl.frame.minX)
        trackLine.frame.origin.y = currentLbl.frame.maxY - config.trackLineH
        trackLine.frame.size.height = config.trackLineH
        if !config.canScrollEnable {
            if config.isTrackDivide {
                trackLine.frame.size.width = currentLbl.frame.width
            } else {
                trackLine.frame.size.width = getTitleLblFrame(title: currentLbl.text ?? "", font: config.font).width
            }
        } else {
            trackLine.frame.size.width = currentLbl.frame.width
        }
        if ani {
            UIView.animate(withDuration: 0.15, animations: {
                self.trackLine.center.x = currentLbl.center.x
            })
        } else {
            self.trackLine.center.x = currentLbl.center.x
        }
        
    }
    
    fileprivate func setupCoverView() {
        scrollView.insertSubview(coverView, at: 0)
        
        if config.defaultSelectedIndex >= titleLabels.count {
            config.defaultSelectedIndex = titleLabels.count - 1
        }
        
        let firstLbl = titleLabels[config.defaultSelectedIndex]
        var coverW = getTitleLblFrame(title: titleLabels[config.defaultSelectedIndex].text!, font: config.font).width
        let coverH = config.coverH
        var coverX = firstLbl.frame.origin.x
        let coverY = (scrollView.frame.height - coverH) * 0.5
        
        if config.canScrollEnable {
            coverX -= config.coverMargin
            coverW += config.coverMargin * 2
        }
        coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        coverView.layer.cornerRadius = config.coverRadius
        coverView.layer.masksToBounds = true
        coverView.center.x = firstLbl.center.x
    }
    
    fileprivate  func getTitleLblFrame(title:String ,font:UIFont) -> CGRect {
        let rect = (title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options:.truncatesLastVisibleLine, attributes: [NSAttributedStringKey.font:font], context: nil)
        return rect
    }
    
}


// MARK:私有
extension LZPageNavBar {
    
    @objc fileprivate func titleLblClick(_ tap :UITapGestureRecognizer) {
        // 当前的Lbl
        guard let currentLbl = tap.view as? UILabel else {
            return
        }
        // 如果点击同一个title 直接返回
        if currentLbl.tag == currentIndex {
            return
        }
        // 获取之前的lbl
        let oldLbl = titleLabels[currentIndex]

        // 切换文字颜色
        oldLbl.textColor = config.normalColor
        oldLbl.backgroundColor = config.titleNorBgColor
        currentLbl.textColor = config.selectedColor
        currentLbl.backgroundColor = config.titleSelectedBgColor
        // 保存最新的lbl下标
        currentIndex = currentLbl.tag
        oldIndex = currentIndex
        // 代理通知
        delegate?.pageNavBarDidSelected(pageNavBar: self, oldIndex: oldLbl.tag, oldObj: oldLbl, newIndex: currentLbl.tag, newObj: currentLbl)
        // 居中显示
        currentViewDidEndScroll()
        // 调整缩放比例
        
        if config.isNeedScale {
            oldLbl.transform = CGAffineTransform.identity
            currentLbl.transform = CGAffineTransform(scaleX: config.scaleRange, y: config.scaleRange)
        }
        // 调整trackLine
        setupTrackLineLayout(animation: true)
        // 遮盖位置移动
        if config.isShowCover {
            self.coverView.frame.size.width = currentLbl.frame.width + config.coverMargin * 2
            UIView.animate(withDuration: 0.1, animations: {
                self.coverView.center.x = currentLbl.center.x
            })
        }
    }
    
    @objc func leftBarItemClick(tap:UITapGestureRecognizer) {
        delegate?.pageNavBarDidSelectedLeftBar(pageNavBar: self)
    }
    
    @objc func rightBarItemClick(tap:UITapGestureRecognizer) {
        delegate?.pageNavBarDidSelectedRightBar(pageNavBar: self)
    }
    
    fileprivate func switchFromIndexToIndex(fromIndex fIndex:Int ,toIndex tIndex:Int, withProgress progress:CGFloat ,hasAnimation anmi:Bool) {
        
        // 1 取出from / to
        if fIndex >= titleLabels.count {
            return
        }
        let fromLbl = titleLabels[fIndex]
        
        if tIndex >= titleLabels.count {
            return
        }
        let toLbl = titleLabels[tIndex]
        
        // 2 渐变
        
        if anmi {
            fromLbl.textColor = UIColor.getMiddleColor(percent: progress, currentColor: config.normalColor, endColor: config.selectedColor)
            toLbl.textColor = UIColor.getMiddleColor(percent: progress, currentColor: config.selectedColor, endColor: config.normalColor)
            
            if let norBg = config.titleNorBgColor,let selectedBgColor = config.titleSelectedBgColor {
                fromLbl.backgroundColor =  UIColor.getMiddleColor(percent: progress, currentColor: norBg, endColor: config.titleSelectedBgColor!)
                toLbl.backgroundColor =  UIColor.getMiddleColor(percent: progress, currentColor: selectedBgColor, endColor: config.titleNorBgColor!)
            }
        } else {
            fromLbl.textColor = config.normalColor
            toLbl.textColor = config.selectedColor
            if let norBg = config.titleNorBgColor,let selectedBgColor = config.titleSelectedBgColor {
                fromLbl.backgroundColor =  norBg
                toLbl.backgroundColor =  selectedBgColor
            }
        }
        
        
        // 3 更新当前的index
        currentIndex = tIndex
        oldIndex = tIndex
        let moveTotalX = toLbl.frame.origin.x - fromLbl.frame.origin.x
        let moveTotalW = toLbl.frame.width - fromLbl.frame.width

        // 4 计算滚动的范围差值
        
        if config.isShowTrackLine {
            if !config.canScrollEnable {
                if config.isTrackDivide {
                        trackLine.frame.size.width = fromLbl.frame.width + moveTotalW * progress
                } else {
                    trackLine.frame.size.width = getTitleLblFrame(title: fromLbl.text ?? "", font: config.font).width  + moveTotalW * progress
                }
            } else {
                trackLine.frame.size.width = fromLbl.frame.width  + moveTotalW * progress
                
            }
            UIView.animate(withDuration: 0.1, animations: {
                 self.trackLine.frame.origin.x = fromLbl.frame.origin.x + moveTotalX * progress
            })
            
        }
        
        // 5 放大的比例
        
        if config.isNeedScale {
            let scaleData = (config.scaleRange - 1.0) * progress
            fromLbl.transform = CGAffineTransform(scaleX: config.scaleRange - scaleData, y: config.scaleRange - scaleData)
            toLbl.transform = CGAffineTransform(scaleX: 1.0 + scaleData, y: 1.0 + scaleData)
        }
        
        //6 计算cover的滚动
        
        if config.isShowCover {
            coverView.frame.size.width = config.canScrollEnable ? (fromLbl.frame.width + 2 * config.coverMargin + moveTotalW * progress) :(fromLbl.frame.width + moveTotalW * progress)
            coverView.frame.origin.x = config.canScrollEnable ? (fromLbl.frame.origin.x - config.coverMargin + moveTotalX * progress) : (fromLbl.frame.origin.x + moveTotalX * progress)
        }
    }
    
    
    
}

//MARK:对外方法
extension LZPageNavBar {

    func reloadData()  {
        self.titles = dataSource?.pageNavBarTitles(pageNavBar: self)
        self.setupUI()
        oldIndex = config.defaultSelectedIndex
    }
    
    func scrollFromIndexToIndex(fromIndex fIndex :Int , toIndex tIndex:Int , withProgress progress:CGFloat) {
        oldIndex = fIndex
        switchFromIndexToIndex(fromIndex: oldIndex, toIndex: tIndex, withProgress: progress, hasAnimation: true)
    }

    func scrollToIndex(toIndex tIdx:Int)  {
        switchFromIndexToIndex(fromIndex: currentIndex, toIndex: tIdx, withProgress: 1, hasAnimation: false)
        print("currentIndex:\(currentIndex),toIndex:\(tIdx)")
    }
    
    func currentViewDidEndScroll()  {
        // 1 不需要滚动的情况下 则不需要调整中间的位置
        guard config.canScrollEnable else {
            return
        }
        // 2 获取目标Label
        let toLbl = titleLabels[currentIndex]
        // 3 计算和中间位置的偏移量
        var offsetX = toLbl.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffset = scrollView.contentSize.width - scrollView.bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        //4 滚动scrollerView
        scrollView.setContentOffset(CGPoint(x:offsetX,y:0), animated:true)
        
    }
 
}







