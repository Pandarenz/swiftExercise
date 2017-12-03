//
//  ViewController.swift
//  懒加载
//
//  Created by JiWuChao on 2017/11/1.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var lbl = DemoLbl() //普通写法
    //懒加载
//    lazy var lbl :DemoLbl = DemoLbl()
    // 懒加载的本质是一个闭包,完整实现如下
    // 仅供参考 原因
    /*
     1 闭包中智能提示不好
     2 闭包中如果出现 self 还需要注意循环引用
     */
    lazy var lbl = { ()->DemoLbl in
        let l = DemoLbl()
        return l
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        view.addSubview(lbl)
        lbl.text = "hehe";
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor.red
        lbl.sizeToFit()
        lbl.backgroundColor = UIColor.lightGray
        lbl.center = view.center
    }

}

