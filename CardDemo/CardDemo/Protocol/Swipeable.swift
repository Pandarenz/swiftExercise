//
//  Swipeable.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/29.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

protocol Swipeable {
    
}


extension Swipeable where Self :UIPanGestureRecognizer {
    
    func swipeView(view:UIView) {
        switch state {
        case .changed:
            let translation = self.translation(in: view.superview)
            view.transform = transform(view: view, for: translation)
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: [], animations: {
                view.transform = .identity
            }, completion: nil)
            
        default:
            break
        }
    }
    
    func transform(view:UIView,for translation:CGPoint) -> CGAffineTransform {
        let moveBy = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotation = -sin(translation.x / (view.frame.width * 4.0))
        return moveBy.rotated(by: rotation)
    }
    
    
}


extension UIPanGestureRecognizer :Swipeable {
    
}


