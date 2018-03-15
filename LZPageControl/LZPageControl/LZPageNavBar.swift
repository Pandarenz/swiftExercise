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
    func pageNavBar(pageNavBar:LZPageNavBar ,didSelectedIndex index:Int)
    //选中了左边的bar
    func pageNavBarDidSelectedLeftBar(pageNavBar:LZPageNavBar)
    //选中了右边的bar
    func pageNavBarDidSelectedRightBar(pageNavBar:LZPageNavBar)
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
    
    
    init(frame: CGRect,titles:[String],config : LZPageNavBarConfig) {
        self.titles = titles
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
        addSubview(scrollView)
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
        delegate?.pageNavBar(pageNavBar: self, didSelectedIndex: currentIndex)
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
    
}


extension LZPageNavBar {

    func scrollFromIndexToIndex(fromIndex fIndex :Int , toIndex tIndex:Int , withProgress progress:CGFloat) {
        
        // 1 取出from / to
        let fromLbl = titleLabels[fIndex]
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
        
    }
    
    
    func currentViewDidEndScroll()  {
        
    }
    
}







