//
//  LZPageNavBar.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit


protocol LZPageNavBarDelegate : class {
    //选中了某一个title
    func pageNavBar(pageNavBar:LZPageNavBar ,oldIndex oIndex:Int ,didSelectedIndex index:Int)
    //选中了左边的bar
    func pageNavBarDidSelectedLeftBar(pageNavBar:LZPageNavBar)
    //选中了右边的bar
    func pageNavBarDidSelectedRightBar(pageNavBar:LZPageNavBar)
    
    func pageNavBarTitles(pageNavBar:LZPageNavBar) -> [String]
    
}




class LZPageNavBar: UIView {

    weak var delegate : LZPageNavBarDelegate?
    
    fileprivate var titles :[String]?
    fileprivate var config : LZPageNavBarConfig
    fileprivate var currentIndex :Int = 0
    
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = UIColor.lightGray
        return scrollView
    }()
    
    fileprivate lazy var splitLine:UIView = {
        let splitLine = UIView()
            splitLine.backgroundColor = UIColor.lightGray
            let h : CGFloat = 0.5
            splitLine.frame = CGRect(x: 0, y: self.frame.height - h, width: self.frame.width, height: h)
        return splitLine;
    }()
    
    
    fileprivate lazy var trackLine : UIView = {
       let trackLine = UIView()
        trackLine.backgroundColor = self.config.trackLineColor;
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

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 设置UI界面内容
extension LZPageNavBar {
    
  fileprivate  func setupUI() {
        //1 滚动视图
    
    if (config.leftBarItem != nil ) && (config.rightBarItem != nil) {
        
        config.leftBarItem?.frame = CGRect(x: 0, y: self.bounds.origin.y, width: (config.leftBarItem?.frame.width)!, height: (config.leftBarItem?.frame.height)!)
        addSubview(config.leftBarItem!)
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(leftBarItemClick(tap:)))
        config.leftBarItem?.addGestureRecognizer(leftTap)
        
        scrollView.frame = CGRect(x: (config.leftBarItem?.frame.width)! + (config.leftBarItem?.frame.origin.x)!, y: self.bounds.origin.y, width: self.bounds.width - config.leftBarItem!.frame.width - config.rightBarItem!.frame.width, height: self.bounds.height)
        
        addSubview(scrollView)
        
        config.rightBarItem?.frame = CGRect(x:scrollView.frame.maxX , y: self.bounds.origin.y, width: (config.rightBarItem?.frame.width)!, height: (config.rightBarItem?.frame.height)!)
        addSubview(config.rightBarItem!)
        
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(rightBarItemClick(tap:)))
        config.rightBarItem?.addGestureRecognizer(rightTap)

    }
    
    if (config.leftBarItem != nil) && (config.rightBarItem == nil) {
        
        config.leftBarItem?.frame = CGRect(x: 0, y: self.bounds.origin.y, width: (config.leftBarItem?.frame.width)!, height: (config.leftBarItem?.frame.height)!)
        addSubview(config.leftBarItem!)
        
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(leftBarItemClick(tap:)))
        config.leftBarItem?.addGestureRecognizer(leftTap)
        
        
        
        scrollView.frame = CGRect(x: (config.leftBarItem?.frame.width)! + (config.leftBarItem?.frame.origin.x)!, y: self.bounds.origin.y, width: self.bounds.width - config.leftBarItem!.frame.width , height: self.bounds.height)
        addSubview(scrollView)
        
    }
    
    if (config.leftBarItem == nil) && (config.rightBarItem != nil) {
 
        scrollView.frame = CGRect(x: 0, y: self.bounds.origin.y, width: self.bounds.width - config.rightBarItem!.frame.width, height: self.bounds.height)
        
        addSubview(scrollView)
        
        config.rightBarItem?.frame = CGRect(x:scrollView.frame.maxX , y: self.bounds.origin.y, width: (config.rightBarItem?.frame.width)!, height: (config.rightBarItem?.frame.height)!)
        addSubview(config.rightBarItem!)
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(rightBarItemClick(tap:)))
        config.rightBarItem?.addGestureRecognizer(rightTap)
    }
    
    if (config.leftBarItem == nil) && (config.rightBarItem == nil)  {
        scrollView.frame = CGRect(x: 0, y: self.bounds.origin.y, width: self.bounds.width , height: self.bounds.height)
        
        addSubview(scrollView)
    }
    
        //2 添加底部分割线
        addSubview(splitLine)
        //3 添加所有标题的label
        setupTitleLbls()
        //4 设置Lbl的位置
         setupTitleLblPosition()
        // 5 设置底部的滚动条
    if config.isShowTrackLine {
            setupTrackLine()
        }
    
        if config.isShowCover {
            setupCoverView()
        }
    
    
    }
    
    
    fileprivate func setupTitleLbls()  {
        for (index,title) in (titles?.enumerated())! {
            let lbl = UILabel()
            lbl.tag = index
            lbl.text = title
            lbl.font = config.font
            lbl.textColor = index == 0 ? config.selectedColor : config.normalColor
            lbl.textAlignment = .center
            lbl.isUserInteractionEnabled = true
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
                let rect = (lbl.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:config.font ], context: nil)
                titleW = rect.width
                
                if index == 0 {
                    titleX = config.titleMargin * 0.5
                } else {
                    let preLbl = titleLabels[index - 1 ]
                    titleX = preLbl.frame.maxX + config.titleMargin
                }
            } else {
                titleW = frame.width / CGFloat(count!)
                titleX = titleW * CGFloat(index)
            }
            
            lbl.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            
            if index == 0 {
                let scale = config.isNeedScale ? config.scaleRange : 1.0
                lbl.transform = CGAffineTransform(scaleX: scale, y: scale)
                
            }
            
            
        }
        
        if config.canScrollEnable {
            scrollView.contentSize = CGSize(width: (titleLabels.last?.frame.maxX)! + config.titleMargin * 0.5, height: 0)
        }
        
    }
    
    
    fileprivate func setupTrackLine() {
        scrollView.addSubview(trackLine)
        trackLine.frame = titleLabels.first!.frame
        trackLine.frame.size.height = config.trackLineH
        trackLine.frame.origin.y = bounds.height - config.trackLineH
    }
    
    fileprivate func setupCoverView() {
        scrollView.insertSubview(coverView, at: 0)
        let firstLbl = titleLabels[0]
        var coverW = firstLbl.frame.width
        let coverH = config.coverH
        var coverX = firstLbl.frame.origin.x
        let coverY = (bounds.height - coverH) * 0.5
        
        if config.canScrollEnable {
            coverX -= config.coverMargin
            coverW += config.coverMargin * 2
        }
        coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        coverView.layer.cornerRadius = config.coverRadius
        coverView.layer.masksToBounds = true
        
    }
    
    
}



extension LZPageNavBar {
    
    @objc fileprivate func titleLblClick(_ tap :UITapGestureRecognizer) {
        //1 当前的Lbl
        guard let currentLbl = tap.view as? UILabel else {
            return
        }
        //2 如果点击同一个title 直接返回
        
        if currentLbl.tag == currentIndex {
            return
        }
        
        // 3 获取之前的lbl
        let oldLbl = titleLabels[currentIndex]

        // 4 切换文字颜色
        oldLbl.textColor = config.normalColor
        currentLbl.textColor = config.selectedColor
        
        // 5 保存最新的lbl下标
        currentIndex = currentLbl.tag
        // 6 代理通知
//        delegate?.pageNavBar(pageNavBar: self, didSelectedIndex: currentIndex)
        delegate?.pageNavBar(pageNavBar: self, oldIndex: oldLbl.tag, didSelectedIndex: currentIndex)
        // 7 居中显示
        
        currentViewDidEndScroll()
        
        // 8 调整trackLine
        if config.isShowTrackLine {
            UIView.animate(withDuration: 0.15, animations: {
                self.trackLine.frame.origin.x = currentLbl.frame.origin.x
                self.trackLine.frame.size.width = currentLbl.frame.width
            })
        }
        
        // 9 调整缩放比例
        
        if config.isNeedScale {
            oldLbl.transform = CGAffineTransform.identity
            currentLbl.transform = CGAffineTransform(scaleX: config.scaleRange, y: config.scaleRange)
        }
        
        // 10 遮盖位置移动
        
        if config.isShowCover {
            let coverX = config.canScrollEnable ? (currentLbl.frame.origin.x - config.coverMargin ):currentLbl.frame.origin.x
            
            let coverW = config.canScrollEnable ? (currentLbl.frame.width + config.coverMargin * 2) : currentLbl.frame.width
            UIView.animate(withDuration: 0.15, animations: {
                self.coverView.frame.origin.x = coverX
                self.coverView.frame.size.width = coverW
            })
            
        }
        
    }
    
    @objc func leftBarItemClick(tap:UITapGestureRecognizer) {
        delegate?.pageNavBarDidSelectedLeftBar(pageNavBar: self)
    }
    
    @objc func rightBarItemClick(tap:UITapGestureRecognizer) {
        delegate?.pageNavBarDidSelectedRightBar(pageNavBar: self)
    }
}

//对外方法
extension LZPageNavBar {

    
    func reloadData()  {
        self.titles = delegate?.pageNavBarTitles(pageNavBar: self)
        self.setupUI()
    }
    
    
    func scrollFromIndexToIndex(fromIndex fIndex :Int , toIndex tIndex:Int , withProgress progress:CGFloat) {
        
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
        
        fromLbl.textColor = config.normalColor
        
        toLbl.textColor = config.selectedColor
        
        // 3 更新当前的index
        currentIndex = tIndex
        let moveTotalX = toLbl.frame.origin.x - fromLbl.frame.origin.x
        let moveTotalW = toLbl.frame.width - fromLbl.frame.width
        
        // 4 计算滚动的范围差值
        if config.isShowTrackLine {
            trackLine.frame.size.width = fromLbl.frame.width + moveTotalW * progress
            trackLine.frame.origin.x = fromLbl.frame.origin.x + moveTotalX * progress
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
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        scrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//    }
}







