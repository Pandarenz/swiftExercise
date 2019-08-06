//
//  SJTabbarManager.swift
//  TabbarNav
//
//  Created by JiWuChao on 2019/8/5.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

class SJTabbarManager :NSObject {
    
    
    public static let `default` = SJTabbarManager.init()
    
    lazy var tabbarVC: SJTabbarVC = {
        let vc = SJTabbarVC()
        vc.delegate = self
        vc.tabBar.shadowImage = UIImage(named: "transparent")
        vc.tabBar.backgroundImage = UIImage(named: "background_dark")
        
        vc.shouldHijackHandler = { tabbarVC,viewController, idx in
            if idx == 2 {
                return true
            }
            return false
        }
        vc.didHijackHandler = { [weak self] tabbarController, viewController, index in
            print(index)
            
        }
        return vc
    }()
    lazy var navHome: SJNavVC = {
        let h = SJHomeVC()
        h.tabBarItem = SJTabBarItem.init(SJNormalTabbarItem(), title: "主页", image: UIImage.init(named: "home"), selectedImage: UIImage.init(named: "home_1"), tag: 101)
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    lazy var navPK: SJNavVC = {
        let h = SJPKVC()
        h.tabBarItem = SJTabBarItem.init(SJNormalTabbarItem(), title: "PK", image: UIImage.init(named: "shop"), selectedImage: UIImage.init(named: "shop_1"), tag: 102)
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    
    lazy var navTemp: SJNavVC = {//SJTabbarItemBig
        let h = SJTempVC()
        h.tabBarItem = UITabBarItem.init(title: "", image: UIImage.init(named: ""), selectedImage: UIImage.init(named: ""))
        h.tabBarItem = SJTabBarItem.init(SJTabbarItemBig(), title: nil, image: UIImage.init(named: "photo_verybig"), selectedImage: UIImage.init(named: "photo_verybig"), tag: 103)
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    
    
    lazy var navGuanzhu: SJNavVC = {
        let h = SJGuanzhuVC()
         h.tabBarItem = SJTabBarItem.init(SJNormalTabbarItem(), title: "关注", image: UIImage.init(named: "favor"), selectedImage: UIImage.init(named: "favor_1"), tag: 104)
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    
    lazy var navMine: SJNavVC = {
        let h = SJMineVC()
        h.tabBarItem = SJTabBarItem.init(SJNormalTabbarItem(), title: "我的", image: UIImage.init(named: "me"), selectedImage: UIImage.init(named: "me_1"), tag: 105)
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    
    
    override init() {
        super.init()
        tabbarVC.viewControllers = [navHome,navPK,navTemp,navGuanzhu,navMine]
//        tabbarVC.delegate = self
    }
    
    func getTabbar() -> UITabBarController {
        return tabbarVC
    }
    
}

extension SJTabbarManager: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("shouldSelect -> ",viewController)
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        print("didSelect",viewController)
        
    }
    
}
