//
//  ViewController.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   lazy var config:LZPageNavBarConfig = {
    
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            leftBtn.backgroundColor = UIColor.red
            leftBtn.setTitle("left", for: .normal)
            leftBtn.setTitleColor(UIColor.white, for: .normal)
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            rightBtn.backgroundColor = UIColor.red
            rightBtn.setTitle("right", for: .normal)
            rightBtn.setTitleColor(UIColor.white, for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    
        let config = LZPageNavBarConfig()
            config.navFrame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44)
            config.navBarBackgroundColor = UIColor.lightGray
            config.isShowTrackLine = true
            config.canScrollEnable = false
            config.isTrackDivide = true
            config.trackLineColor = UIColor.yellow
//            config.coverBgColor = UIColor.orange
//            config.titleNorBgColor = UIColor.blue
//            config.titleSelectedBgColor = UIColor.green
//            config.isShowCover = true
            config.titleMargin = 20
            config.firstTitleLeftMargin = 0
            config.lastTitleFightMargin = 0
//            config.leftBarItem = leftBtn
            config.rightBarItem = rightBtn
            config.selectedColor = UIColor.red
            config.normalColor = UIColor.black
        return config
    }()
    
    
    lazy var nav :LZPageNavBar = {
        let navBar = LZPageNavBar(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 44), config: config)
            navBar.dataSource = self
            navBar.delegate = self
        return navBar
    }()
    
    var titles:[String] = ["第1个","第2个","第3个"]
    
    
    var pageControl:LZPageControl = LZPageControl(frame: CGRect.zero, config: LZPageNavBarConfig())
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setPageControlView()
        setNavbar()
    }

    func setPageControlView() {
         pageControl = LZPageControl(frame: self.view.bounds, config: config)
        pageControl.backgroundColor = UIColor.blue
        pageControl.delegate = self
        pageControl.dataSource = self
        view.addSubview(pageControl)
        pageControl.reloadData()
    }
 
    func setNavbar() {
        nav.reloadData()
        view.addSubview(nav)
    }
    
    
    override func viewWillLayoutSubviews() {
        pageControl.frame = self.view.bounds
        nav.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44)
    }
}





extension ViewController :LZPageControlDelegate {
    func pageControlDidselectedLeftBar(control: LZPageControl) {
          print("点击了左边")
    }
    
    func pageControlDidselectedRightBar(control: LZPageControl) {
        print("点击了右边")
    }
    
    func pageControl(control: LZPageControl, scrolToIndex: Int) {
        print("scrolToIndex: Int:\(scrolToIndex)")
    }
    
    func pageControl(control: LZPageControl, showViewFromIndex fIndex: Int, toIndex tIndex: Int) {
        print("showViewFromIndex:\(fIndex) toIndex :\(tIndex)")
    }
    
}

extension ViewController :LZPageControlDataSource {
    func pageControlTitles(control: LZPageControl) -> [String] {
        return self.titles;
    }
}



extension ViewController:LZPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: LZPageNavBar) -> [String] {
        return titles
    }
    func pageControlChildren(pageControl: LZPageControl, viewAtIndex atIndex: Int) -> UIView {
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

extension ViewController:LZPageNavBarDelegate {
    func pageNavBarDidSelected(pageNavBar: LZPageNavBar, oldIndex oIndex: Int, oldObj: UILabel, newIndex nIndex: Int, newObj: UILabel) {
        print("old : \(oIndex) new :\(nIndex)")
    }
    
    
    func pageNavBarDidSelectedLeftBar(pageNavBar: LZPageNavBar) {
        print("点击了左边")
    }
    
    func pageNavBarDidSelectedRightBar(pageNavBar: LZPageNavBar) {
        print("点击了右边 ")
    }
    
}


