//
//  ImageViewFactory.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/19.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

enum ImageViewFactory {
    
    case standardImageView(image:UIImage,cornerRadius:CGFloat,interactionEnabled:Bool,contentMode:UIViewContentMode,sizeToFit:Bool)
    
    var new :UIImageView {
        
        switch self {
        case .standardImageView(let image, let cornerRadius, let interactionEnabled , let contentMode , let sizeToFit):
            return createImageView(image: image, cornerRadius: cornerRadius, interactionEnabled: interactionEnabled, contentMode: contentMode, sizeToFit: sizeToFit)
        }
    }
        private func createImageView(image:UIImage,cornerRadius:CGFloat,interactionEnabled:Bool,contentMode:UIViewContentMode,sizeToFit:Bool) -> UIImageView {
            let imageView = UIImageView()
            imageView.image = image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = cornerRadius
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = interactionEnabled
            imageView.contentMode = contentMode
            if sizeToFit {
                imageView.sizeToFit()
            }
            return imageView
            
        }
    
    
}
