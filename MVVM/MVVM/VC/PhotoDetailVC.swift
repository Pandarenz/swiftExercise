//
//  PhotoDetailVC.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/18.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class PhotoDetailVC: UIViewController {
    var imageUrl :String?
    
    var imageView :UIImageView?
    
    var tapGesture :UITapGestureRecognizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView.init(frame: UIScreen.main.bounds)
        view.addSubview(imageView!)
        
        if let imageUrl = imageUrl {
            imageView?.sd_setImage(with: URL(string: imageUrl)) { (image, error, type, url) in
                
            }
        }
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tapGesture?.numberOfTapsRequired = 2;
        view.addGestureRecognizer(tapGesture!)
    }

    @objc func tapAction()  {
        self.dismiss(animated: true) {
            
        }
    }

}
