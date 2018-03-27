//
//  LZPageControl.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol LZPageControlDelegate:class {
    func pageControlDidselectedLeftBar(control:LZPageControl)
    func pageControlDidselectedRightBar(control:LZPageControl)
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
   
    func reloadData()  {
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
        container?.defaultSelect = config.defaultSelectedIndex
        container!.delegate = self
        container!.dataSource = self
        addSubview(container!)
        container?.setNeedsLayout()
    }
    
   fileprivate func titlesArray() -> [String]? {
        let titles = dataSource?.pageControlTitles(control: self)
        return titles
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navBar?.frame = CGRect(x: 0, y: 50, width: self.bounds.width, height: 44)
        container?.frame = CGRect(x: 0, y: navBar!.frame.maxY, width: self.bounds.size.width, height: self.bounds.size.height - navBar!.frame.maxY)
        
    }
    
}

extension LZPageControl :LZPageNavBarDelegate {
    func pageNavBarDidSelected(pageNavBar: LZPageNavBar, oldIndex oIndex: Int, oldObj: UILabel, newIndex nIndex: Int, newObj: UILabel) {
        let ani = abs(nIndex - oIndex) > 1
        container!.scrollToIndexToIndex(fromIndex: oIndex, toIndex: nIndex, withAnimated: !ani)
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
        return (dataSource?.pageControlChildren(pageControl: self, viewAtIndex: atIndex))!
    }
    
    func pageContainerChildrenCount(pageContainer: LZPageContainer) -> Int {
        return (titlesArray()?.count)!
    }
    
    
    
    
}






