//
//  LZPageControl.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol LZPageControlDelegate {
    func pageControl(control:LZPageControl,scrolToIndex:Int)
    func pageControl(control:LZPageControl) -> [LZPageNavBarProtocol]
}


protocol LZPageControlDataSource  {
    func pageControlTitles(control:LZPageControl) -> [String]
    func pageControlContentViews(control:LZPageControl) -> [UIView]
}



class LZPageControl: UIView {
   lazy var config:LZPageNavBarConfig = {
    let config = LZPageNavBarConfig()
        config.isShowTrackLine = true
        config.canScrollEnable = true
        config.trackLineColor = UIColor.blue
        config.isNeedScale = false
        config.isShowCover = false
        config.coverBgColor = UIColor.orange
        config.titleMargin = 30
    
    return config
    }()
    
   lazy var navBar : LZPageNavBar = {
        let bar = LZPageNavBar(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 44), config: config)
        bar.backgroundColor = UIColor.red
        bar.delegate = self as? LZPageNavBarDelegate
        bar.reloadData()
        return bar
    }()
    
    lazy var container :LZPageContainer = {
        let container = LZPageContainer(frame: CGRect(x: 0, y: navBar.frame.maxY, width: self.bounds.size.width, height: self.bounds.size.height - navBar.frame.maxY))
        container.delegate = self
        container.dataSource = self
       return container
    }()
    
    var delegate:LZPageControlDelegate?
    var dataSource:LZPageControlDataSource?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        addSubview(navBar)
        addSubview(container)
        container.reloadData()
    }
    
   
    
    
}

extension LZPageControl :LZPageNavBarDelegate {
  
    
    func pageNavBar(pageNavBar: LZPageNavBar, oldIndex oIndex: Int, didSelectedIndex index: Int) {
        container.scrollToIndexToIndex(fromIndex: oIndex, toIndex: index)
    }
    
    func pageNavBarDidSelectedLeftBar(pageNavBar: LZPageNavBar) {
        
    }
    
    func pageNavBarDidSelectedRightBar(pageNavBar: LZPageNavBar) {
        
    }
    
    func pageNavBarTitles(pageNavBar: LZPageNavBar) -> [String] {
        return ["第一个","第2个","第3个","第4个","第5个","第6个"]
    }
    
}





extension LZPageControl:LZPageContainerDelegate {
    func pageContainer(pageContainer: LZPageContainer, didShowViewAtIndex index: Int) {
        
    }
    
    func pageContainer(pageContainer: LZPageContainer, scrolFromIndex fIndex: Int, toIndex tIndex: Int, progress: CGFloat) {
        navBar.scrollFromIndexToIndex(fromIndex: fIndex, toIndex: tIndex, withProgress: progress)
    }
    func pageContainerDidStop() {
        navBar.currentViewDidEndScroll()
    }
    
}

extension LZPageControl :LZPageContainerDataSource {
    func pageContainerChildrenCount(pageContainer: LZPageContainer) -> Int {
        return 6
    }
    
    func pageContainerChildren(pageContainer: LZPageContainer, viewAtIndex atIndex: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let lbl = UILabel(frame: view.bounds)
        lbl.text = "第\(atIndex + 1)个"
        lbl.textAlignment = .center
        view.addSubview(lbl)
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
         view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return view
    }
    
    
}






