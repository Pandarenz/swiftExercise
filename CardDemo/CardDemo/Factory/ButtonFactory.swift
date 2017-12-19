//
//  ButtonFactory.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/19.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation
import UIKit

enum ButtonFactory {
    
    case buttonWithImage(image:UIImage,cornerRadius:CGFloat,target:Any,selector:(Selector),sizeToFit:Bool)
    
    var new:UIButton  {
        
        switch self {
        case .buttonWithImage(let image,let cornerRadius ,let target, let selector, let sizeToFit):
            return createButton(image: image, cornerRadius: cornerRadius, target: target, selector: selector, sizeToFit: sizeToFit)
        }
    }
    func createButton(image:UIImage,cornerRadius:CGFloat,target:Any,selector:(Selector),sizeToFit:Bool) -> UIButton {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.addTarget(target, action: selector, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = cornerRadius
        btn.clipsToBounds = true
        if sizeToFit {
            btn.sizeToFit()
        }
        return btn
    }
}
