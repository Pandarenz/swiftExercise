//
//  ViewController.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI() {
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            leftBtn.backgroundColor = UIColor.lightGray
            leftBtn.setTitle("left", for: .normal)
            leftBtn.setTitleColor(UIColor.white, for: .normal)
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            rightBtn.backgroundColor = UIColor.lightGray
            rightBtn.setTitle("right", for: .normal)
            rightBtn.setTitleColor(UIColor.white, for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let config = LZPageNavBarConfig()
        config.isShowCover = false
        config.isShowTrackLine = true
        config.canScrollEnable = true
        config.trackLineColor = UIColor.blue
        config.isNeedScale = true
        config.isShowCover = true
        config.coverBgColor = UIColor.orange
        config.titleMargin = 30
//        config.leftBarItem = leftBtn
        config.rightBarItem = rightBtn
        let titleFrame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 44)
        let navBar : LZPageNavBar = {
            let bar = LZPageNavBar(frame: titleFrame, titles: ["第1个","第2个","第3个","第4个23easdsadasdasd","第5个","第6个","第7个","第8个","第9个","第10个","第11个","第12个"], config: config)
            bar.backgroundColor = UIColor.red
            bar.delegate = self as LZPageNavBarDelegate
            return bar
        }()
        view.addSubview(navBar)
    }

}


extension ViewController :LZPageNavBarDelegate {
    func pageNavBar(pageNavBar: LZPageNavBar, didSelectedIndex index: Int) {
        print("选中了第\(index + 1)个")
    }
    
    func pageNavBarDidSelectedLeftBar(pageNavBar: LZPageNavBar) {
        print("点击了左边按钮")
    }
    
    
    func pageNavBarDidSelectedRightBar(pageNavBar: LZPageNavBar) {
        print("点击了右边按钮")
    }
    
    
}


