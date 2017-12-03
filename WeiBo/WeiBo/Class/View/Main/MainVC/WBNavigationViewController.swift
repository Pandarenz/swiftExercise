//
//  WBNavigationViewController.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/11/14.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class WBNavigationViewController: UINavigationController {

    // 重写
    //viewController 被 push 的viewController
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //如果不是栈底才需要隐藏 根控制器不需要控制
        var title = "返回"
        //判断控制器的计数如果只有一个子控制器的时候显示栈底控制器的标题
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            title = childViewControllers.first?.title ?? "返回"
            
            
            if let vc = viewController as?WBBaseViewController {
                vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", font: 16, target: self, action: #selector(popToParent) ,isBack :true)
            }
        }       
        
        super.pushViewController(viewController, animated: animated)
        
    }
    
    @objc private func popToParent() {
        popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏默认的 navigationbar
//     navigationBar.isHidden = true
        
    }

    
    

    

}
