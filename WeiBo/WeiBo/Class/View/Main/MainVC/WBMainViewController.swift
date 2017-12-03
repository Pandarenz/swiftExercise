//
//  WBMainViewController.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/11/14.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildrenController()
        setComposeBtn()
    }
    
    
    
    // private 能够保证方法私有 仅在当前对象访问
    // objc 允许这个函数在运行时 通过oc 的消息机制被掉用
    @objc private func composeBtnAction() {
        print("呵呵")
    }
    
    private lazy var composeBtn :UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add_highlighted", backgroundImageName: "tabbar_compose_button_highlighted")
    
    // 设置锁定横竖屏
    private var _orientations = UIInterfaceOrientationMask.portrait
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        get {
            return self._orientations
        }
        set {
            self._orientations = newValue
        }
    }
}

/*
 extension 类似于 oc 中的分类 在 swift 中还可以用来切分代码块
 把相近功能的函数放在一个extension中便于代码维护
 注意:不能定义属性
 */

// MARK: - 哈哈哈
extension WBMainViewController {
    
    private func setComposeBtn() {
        tabBar.addSubview(composeBtn)
        // 设置按钮的位置
        let count = CGFloat(childViewControllers.count)
        let weight = tabBar.bounds.width / count - 1
        //insetBy oc 是 CGRectInset
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * weight, dy: 0)
        composeBtn.addTarget(self, action: #selector(composeBtnAction) , for: .touchUpInside)
    }
    
    private func setupChildrenController () {
        let array :[[String:Any]] = [
            ["clsName":"WBHomeVC","title":"首页","imageName":"home","visitordInfo":["imageName":"","message":"关注一些人回这里看看有什么惊喜"]],
            ["clsName":"WBMessageVC","title":"消息","imageName":"message_center","visitordInfo":["imageName":"visitordiscover_image_message","message":"登录后别人评论你的微博,发给你消息,你可以从这收到"]],
            ["clsName":"xx","title":"xx","imageName":"xx" ],
            
            ["clsName":"WBDiscoverVC","title":"发现","imageName":"discover","visitordInfo":["imageName":"visitordiscover_image_message","message":"登录之后最新最热的微博都在这里展示"]],

            ["clsName":"WBHomeVC","title":"我","imageName":"profile","visitordInfo":["imageName":"visitordiscover_image_profile","message":"登录之后,个人信息都会展示咋这里哦"]]
        ]
//        (array as NSArray).write(toFile: "/Users/JiWuChao/Desktop/plist/demo.plist", atomically: true)
//
        let data = try!JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
        (data as NSData).write(toFile: "/Users/JiWuChao/Desktop/plist/demo.json", atomically: true)
        
        var arrayVM = [UIViewController]()
        for dic in array {
            arrayVM.append(controllers(dict: dic))
        }
        viewControllers = arrayVM
    }
    private func controllers(dict :[String :Any])->UIViewController {
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls =  NSClassFromString(Bundle.main.namespace + "." + clsName ) as? WBBaseViewController.Type,
        let visitordInfo = dict["visitordInfo"] as? [String:String]
            
            
            else {
                return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        vc.visitordInfo = visitordInfo
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_ " + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for: .highlighted)
//        vc.tabBarItem.setTitleTextAttributes(UIFont.systemFont(ofSize: 23), for: .normal)
        
        let nav = WBNavigationViewController(rootViewController: vc)
        return nav
        
    }
}

