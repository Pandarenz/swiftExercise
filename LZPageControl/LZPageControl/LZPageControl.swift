//
//  LZPageControl.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol LZPageControlDelegate:class {
    //点击了左边的bar
    func pageControlDidselectedLeftBar(control:LZPageControl)
    //点击了右边的bar
    func pageControlDidselectedRightBar(control:LZPageControl)
    //当前展示的第几页
    func pageControl(control:LZPageControl,showIndex sIndex:Int )
    
}


protocol LZPageControlDataSource:class  {
    //titles
    func pageControlTitles(control:LZPageControl) -> [String]
    //views
    func pageControlChildren(pageControl: LZPageControl, viewAtIndex atIndex: Int) -> UIView
    
}


class LZPageControl: UIView {
    
   weak var delegate : LZPageControlDelegate?
   weak var dataSource : LZPageControlDataSource?
   fileprivate var config:LZPageNavBarConfig = LZPageNavBarConfig()
   var navBar : LZPageNavBar?
   var container :LZPageContainer?
 
    init(frame: CGRect,config : LZPageNavBarConfig) {
        self.config = config
        super.init(frame: frame)
        self.backgroundColor = self.config.navBarBackgroundColor
        setupUI()
     }
   
    func reloadData() {
        self.navBar?.reloadData()
        self.container?.reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   fileprivate func setupUI()  {
        navBar = LZPageNavBar(frame: config.navFrame, config: config)
        navBar!.delegate = self
        navBar!.dataSource = self
        addSubview(navBar!)
        navBar?.setNeedsLayout()
        container = LZPageContainer(frame: CGRect(x: 0, y: navBar!.frame.maxY, width: self.bounds.size.width, height: self.bounds.size.height - navBar!.frame.maxY))
        container!.delegate = self
        container!.dataSource = self
        addSubview(container!)
        container?.defaultSelect = config.defaultSelectedIndex
        container?.setNeedsLayout()
    }
    
   fileprivate func titlesArray() -> [String]? {
        let titles = dataSource?.pageControlTitles(control: self)
        return titles
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        config.navFrame = CGRect.init(x: config.navFrame.origin.x, y: config.navFrame.origin.y, width: self.bounds.width, height: config.navFrame.height)
        navBar?.frame = config.navFrame
        container?.frame = CGRect(x: 0, y: navBar?.frame.maxY ?? 0, width: self.bounds.size.width, height: self.bounds.size.height - (navBar?.frame.maxY ?? 0))
    }
    
}


//对外方法
extension LZPageControl {
    func updateIndex(scrollToIndex tIndex:Int) {
        container?.scrollToIndexToIndex(fromIndex: 0, toIndex: tIndex, withAnimated: false)
        navBar?.scrollToIndex(toIndex: tIndex)
        delegate?.pageControl(control: self, showIndex: tIndex)
    }
}


extension LZPageControl :LZPageNavBarDelegate {
    func pageNavBarDidSelected(pageNavBar: LZPageNavBar, oldIndex oIndex: Int, oldObj: UILabel, newIndex nIndex: Int, newObj: UILabel) {
        let ani = abs(nIndex - oIndex) > 1
        //内部联动
        container?.scrollToIndexToIndex(fromIndex: oIndex, toIndex: nIndex, withAnimated: !ani)
        //告诉外界当前展示的是第几个页面
        delegate?.pageControl(control: self, showIndex: nIndex)
    }
  
    func pageNavBarDidSelectedLeftBar(pageNavBar: LZPageNavBar) {
        delegate?.pageControlDidselectedLeftBar(control: self)
    }
    func pageNavBarDidSelectedRightBar(pageNavBar: LZPageNavBar) {
        delegate?.pageControlDidselectedRightBar(control: self)
    }
}

extension LZPageControl :LZPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: LZPageNavBar) -> [String] {
        if titlesArray() == nil {
            return [String]()
        }
        return titlesArray()!
    }
}




extension LZPageControl:LZPageContainerDelegate {
  
    
    func pageContainer(pageContainer: LZPageContainer, showIndex sIdx: Int) {
//        navBar?.scrollToIndex(toIndex: sIdx)
         delegate?.pageControl(control: self, showIndex: sIdx)
    }
    
    func pageContainer(pageContainer: LZPageContainer, switchFromIndex fIndex: Int, toIndex tIndex: Int, progress: CGFloat) {
        navBar!.scrollFromIndexToIndex(fromIndex: fIndex, toIndex: tIndex, withProgress: progress)
    }
    func pageContainerDidStop() {
        navBar!.currentViewDidEndScroll()
    }
    
}

extension LZPageControl :LZPageContainerDataSource {
    
    func pageContainerChildren(pageContainer: LZPageContainer, viewAtIndex atIndex: Int) -> UIView {
        
        if let view = dataSource?.pageControlChildren(pageControl: self, viewAtIndex: atIndex) {
            return view
        }
        return UIView.init()
    }
    
    func pageContainerChildrenCount(pageContainer: LZPageContainer) -> Int {
        return (titlesArray()?.count)!
    }
}







