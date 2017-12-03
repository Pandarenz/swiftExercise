//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/11/24.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience public init(title:String, font:Int = 16,target:Any,action:Selector ,isBack:Bool = false) {
        let  btn:UIButton = UIButton.cz_textButton(title, fontSize: CGFloat(font), normalColor: UIColor.darkGray, highlightedColor: UIColor.yellow)
        btn.addTarget(target, action: action, for: .touchUpInside)
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: "navigationbar_back_withtext_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        
        
        
        self.init(customView: btn)
    }
    
}
