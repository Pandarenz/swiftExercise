//
//  DRMainTabbarController.swift
//  DouguoRecipe
//
//  Created by JiWuChao on 2018/1/12.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

class DRMainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildrenController()
        setComposeBtn()
        
    }
    
    private func setupChildrenController () {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString ).appendingPathComponent("Main.json")
        var data = NSData(contentsOfFile: jsonPath)
        if data == nil {
            let path = Bundle.main.path(forResource: "Main", ofType: "json")
            data = NSData.init(contentsOfFile: path!)
        }
        
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String:Any]]
            else {
                return
        }
        
        
        var arrayVM = [UIViewController]()
        for dic in array! {
            arrayVM.append(controllers(dict: dic))
        }
        viewControllers = arrayVM
    }
    
    private func controllers(dict :[String :Any])->UIViewController {
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls =  NSClassFromString(Bundle.main.infoDictionary!["CFBundleExecutable"] as! String + "." + clsName ) as? DRMainTabbarController.Type
//            , 不符合guard 语句的判断时走这里
//            let visitordInfo = dict["visitordInfo"] as? [String:String]
            else {
                return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
//        vc.visitordInfo = visitordInfo
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_ " + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for: .highlighted)
        //        vc.tabBarItem.setTitleTextAttributes(UIFont.systemFont(ofSize: 23), for: .normal)
        
        let nav = DRNavigationViewController(rootViewController: vc)
        return nav
        
    }
    func setComposeBtn()  {
        
    }
}
