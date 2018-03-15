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
    fileprivate var config : LZPageNavBarConfig?
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
        trackLine.backgroundColor = self.config?.trackLineColor;
        return trackLine
    }()
    
//    fileprivate 
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









