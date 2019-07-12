//
//  ViewController.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let vipVM = LZVipVM.init()
    
    let searchVM = LZSearchVM.init()
    
    let nobleVM = LZNobleVM.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vipVM.getVipData()
        
        
        searchVM.getRelativeData()
        
        nobleVM.getNobleList(roomid: "2241427", pageIdx: 1)
        
    }


}
