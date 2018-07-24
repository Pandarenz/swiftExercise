//
//  LZNAVBarVC.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/7/24.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

/*
    此demo只有navbar 没有下面的联动
 
 */



class LZNAVBarVC: UIViewController {
    
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
            //LZPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44), isShowTrckLine: true, canScrollEnable: true, titleMargin: 10, firstTitleLeftMargin: 10, lastTitleRightMargin: 10, selectedCorlor: UIColor.orange, normalColor: UIColor.black)
            //    LZPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44), coverBgColor: UIColor.black, coverAlpha: 0.5, coverMargin: 5, coverH: 25, coverRadius: 8, canScrollEnable: true, titleMargin: 20, firstTitleLeftMargin: 10, lastTitleRightMargin: 10, selectedColor: UIColor.red, normalColor: UIColor.black,isNeedScale:false,scaleRange:1.2)
            let config = LZPageNavBarConfig.init(navFrame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 44), isShowTrckLine: true, canScrollEnable: true, titleMargin: 10, firstTitleLeftMargin: 10, lastTitleRightMargin: 10, selectedCorlor: UIColor.orange, normalColor: UIColor.black)
            //        config.leftBarItem = leftBtn
            config.rightBarItem = rightBtn
            //        config.isTrackDivide = true
            return config
        }()
    
        lazy var nav :LZPageNavBar = {
            let navBar = LZPageNavBar(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44), config: config)
                navBar.dataSource = self
                navBar.delegate = self
            return navBar
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.automaticallyAdjustsScrollViewInsets = false
            self.view.backgroundColor = UIColor.white
            self.view.addSubview(nav)
            nav.reloadData()
        }

   

}


extension LZNAVBarVC:LZPageNavBarDelegate {
    
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


extension LZNAVBarVC:LZPageNavDataSource {
    
    func pageNavBarTitles(pageNavBar: LZPageNavBar) -> [String] {
        return ["第一","第二","第三","第四","第五","第六","第七","第八","第九","第十","第十一"]
    }
}


