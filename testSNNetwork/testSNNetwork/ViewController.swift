//
//  ViewController.swift
//  testSNNetwork
//
//  Created by JiWuChao on 2019/7/22.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let nobleVM = LZNobleVM.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let client = LZNetClient.default
         nobleVM.getNobleList(roomid: "2241427", pageIdx: 1)
        
        NetworkReachability.default.startListening()
        
        switch NetworkReachability.default.status {
        case .ethernetOrWiFi:
            print("1")
            break
        case .notReachable:
             print("2")
            break
        case .unknown:
             print("3")
            break
        case .wwan:
             print("4")
            break
        }
        
    }


}

