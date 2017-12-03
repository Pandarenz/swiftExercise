//
//  AppDelegate.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/11/13.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        loadAppInfo()
        return true
    }

    
 

}


extension AppDelegate {
    
    private func loadAppInfo() {
        DispatchQueue.global().async {
            let url  = Bundle.main.path(forResource: "main.json", ofType: nil)
            let data = NSData(contentsOfFile: url!)
            
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString ).appendingPathComponent("main.json")
            
            data?.write(toFile: jsonPath, atomically: true)
            print("程序加载完成\(jsonPath)")
            
        }
    }
    
}

