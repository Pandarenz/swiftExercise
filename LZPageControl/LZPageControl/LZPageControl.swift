//
//  LZPageControl.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol LZPageControlDelegate:class {
    func pageControl(control:LZPageControl,scrolToIndex:Int)
    func pageControlDidselectedLeftBar(control:LZPageControl)
    func pageControlDidselectedRightBar(control:LZPageControl)
    
    func pageControl(control:LZPageControl,showViewFromIndex fIndex:Int, toIndex tIndex:Int )
    
}


protocol LZPageControlDataSource:class  {
    //titles
    func pageControlTitles(control:LZPageControl) -> [String]
    
    
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
        container = LZPageContainer(frame: CGRect(x: 0, y: navBar!.frame.maxY, width: self.bounds.size.width, height: self.bounds.size.height - navBar!.frame.maxY))
        container!.delegate = self
        container!.dataSource = self
        addSubview(container!)

    }
    
   fileprivate func titlesArray() -> [String]? {
        let titles = dataSource?.pageControlTitles(control: self)
        return titles
    }
    
}

extension LZPageControl :LZPageNavBarDelegate {
    func pageNavBar(pageNavBar: LZPageNavBar, oldIndex oIndex: Int, didSelectedIndex index: Int) {
         container!.scrollToIndexToIndex(fromIndex: oIndex, toIndex: index)
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
    
    func pageContainer(pageContainer: LZPageContainer, didShowViewAtIndex index: Int) {
//        delegate?.pageControl(control: self, showViewFromIndex: fIndex, toIndex: tIndex)
    }
    
    func pageContainer(pageContainer: LZPageContainer, scrolFromIndex fIndex: Int, toIndex tIndex: Int, progress: CGFloat) {
        navBar!.scrollFromIndexToIndex(fromIndex: fIndex, toIndex: tIndex, withProgress: progress)
    }
    func pageContainerDidStop() {
        navBar!.currentViewDidEndScroll()
    }
    
}

extension LZPageControl :LZPageContainerDataSource {
    func pageContainerChildrenCount(pageContainer: LZPageContainer) -> Int {
        return (titlesArray()?.count)!
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






