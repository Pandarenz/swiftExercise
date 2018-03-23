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
            config.canScrollEnable = true
            config.isTrackDivide = true
            config.trackLineColor = UIColor.red
            config.coverBgColor = UIColor.orange
            config.titleMargin = 10
            config.firstTitleLeftMargin = 20
            config.coverRadius = 0
            config.leftBarItem = leftBtn
            config.rightBarItem = rightBtn
            config.selectedColor = UIColor.red
            config.normalColor = UIColor.black
        return config
    }()
    var titles:[String] = ["第1个","第2个","第3个","第2个","第3个","第2个","第3个","第2个","第3个","第2个","第3个","第2个","第3个","第2个","第3个","第2个","第3个"]
    
    var pageControl:LZPageControl = LZPageControl(frame: CGRect.zero, config: LZPageNavBarConfig())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageControlView()
    }

    func setPageControlView() {
         pageControl = LZPageControl(frame: self.view.bounds, config: config)
        pageControl.backgroundColor = UIColor.blue
        pageControl.delegate = self
        pageControl.dataSource = self
        view.addSubview(pageControl)
        pageControl.reloadData()
    }
 
    
    override func viewWillLayoutSubviews() {
        pageControl.frame = self.view.bounds
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

