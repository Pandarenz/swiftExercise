//
//  SJTabbarVC.swift
//  TabbarNav
//
//  Created by JiWuChao on 2019/8/5.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit
/// 是否需要自定义点击事件回调类型
public typealias ESTabBarControllerShouldHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Bool))
/// 自定义点击事件回调类型
public typealias ESTabBarControllerDidHijackHandler = ((_ tabBarController: UITabBarController, _ viewController: UIViewController, _ index: Int) -> (Void))


class SJTabbarVC: UITabBarController,SJTabBarDelegate {
  
    
    
    
    
     lazy var centerBtn: UIButton = {
        let btn = UIButton.init()
            btn.setImage(UIImage.init(named: "photo_verybig"), for: UIControl.State.normal)
            btn.setImage(UIImage.init(named: "photo_verybig"), for: UIControl.State.selected)
        return btn
    }()
    
    
    lazy var navHome: SJNavVC = {
        let h = SJHomeVC()
        h.tabBarItem = UITabBarItem.init(title: "主页", image: UIImage.init(named: "home"), selectedImage: UIImage.init(named: "home_1"))
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    lazy var navPK: SJNavVC = {
        let h = SJPKVC()
        h.tabBarItem = UITabBarItem.init(title: "PK", image: UIImage.init(named: "shop"), selectedImage: UIImage.init(named: "shop_1"))
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    lazy var navGuanzhu: SJNavVC = {
        let h = SJGuanzhuVC()
        h.tabBarItem = UITabBarItem.init(title: "关注", image: UIImage.init(named: "favor"), selectedImage: UIImage.init(named: "favor_1"))
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    
    lazy var navMine: SJNavVC = {
        let h = SJMineVC()
        h.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "me"), selectedImage: UIImage.init(named: "me_1"))
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    lazy var navTemp: SJNavVC = {
        let h = SJTempVC()
        h.tabBarItem = UITabBarItem.init(title: "", image: UIImage.init(named: ""), selectedImage: UIImage.init(named: ""))
        let nav = SJNavVC.init(rootViewController: h)
        return nav
    }()
    
    
    /// Ignore next selection or not.
    fileprivate var ignoreNextSelection = false
    
    /// Should hijack select action or not.
    open var shouldHijackHandler: ESTabBarControllerShouldHijackHandler?
    /// Hijack select action.
    open var didHijackHandler: ESTabBarControllerDidHijackHandler?
    
    /// Observer tabBarController's selectedViewController. change its selection when it will-set.
    open override var selectedViewController: UIViewController? {
        willSet {
            guard let newValue = newValue else {
                // if newValue == nil ...
                return
            }
            guard !ignoreNextSelection else {
                ignoreNextSelection = false
                return
            }
            guard let tabBar = self.tabBar as? SJTabBar, let items = tabBar.items, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            let value = (index > items.count - 1) ? items.count - 1 : index
            tabBar.select(itemAtIndex: value, animated: false)
        }
    }
    
    
    /// Observer tabBarController's selectedIndex. change its selection when it will-set.
    open override var selectedIndex: Int {
        willSet {
            guard !ignoreNextSelection else {
                ignoreNextSelection = false
                return
            }
            guard let tabBar = self.tabBar as? SJTabBar, let items = tabBar.items else {
                return
            }
            let value = (newValue > items.count - 1) ? items.count - 1 : newValue
            tabBar.select(itemAtIndex: value, animated: false)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = { () -> SJTabBar in
            let tabBar = SJTabBar()
            tabBar.delegate = self
            tabBar.customDelegate = self
            tabBar.tabBarController = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
        
//        self.tabBar.shadowImage = UIImage(named: "transparent")
//        self.tabBar.backgroundImage = UIImage(named: "background_dark")
//
//
//        self.viewControllers = [navHome,navPK,navTemp,navGuanzhu,navMine]
//        self.tabBar.addSubview(centerBtn)
//        let count = CGFloat(children.count)
//        let weight = tabBar.bounds.width / count - 1
//        //insetBy oc 是 CGRectInset
//        centerBtn.frame = tabBar.bounds.insetBy(dx: 2 * weight, dy: 0)
//        centerBtn.addTarget(self, action: #selector(composeBtnAction) , for: .touchUpInside)
    }
    
   @objc func composeBtnAction()  {
        print("center clicked")
    }
    
    // MARK: - UITabBar delegate
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return;
        }
        if idx == tabBar.items!.count - 1 {
            ignoreNextSelection = true
//            selectedViewController = moreNavigationController
            return;
        }
        if let vc = viewControllers?[idx] {
            ignoreNextSelection = true
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: vc)
        }
    }
    
    open override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        if let tabBar = tabBar as? SJTabBar {
            tabBar.updateLayout()
        }
    }
    
    open override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        if let tabBar = tabBar as? SJTabBar {
            tabBar.updateLayout()
        }
    }
    
    // MARK: - ESTabBar delegate
    internal func tabBar(_ tabBar: UITabBar, shouldSelect item: UITabBarItem) -> Bool {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            return delegate?.tabBarController?(self, shouldSelect: vc) ?? true
        }
        return true
    }
    
    internal func tabBar(_ tabBar: UITabBar, shouldHijack item: UITabBarItem) -> Bool {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            return shouldHijackHandler?(self, vc, idx) ?? false
        }
        return false
    }
    
    internal func tabBar(_ tabBar: UITabBar, didHijack item: UITabBarItem) {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            didHijackHandler?(self, vc, idx)
        }
    }

}
