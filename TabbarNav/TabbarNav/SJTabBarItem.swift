//
//  SJTabBarItem.swift
//  TabbarNav
//
//  Created by JiWuChao on 2019/8/5.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

open class SJTabBarItem: UITabBarItem {
    
    open var contentView:SJTabbarItemContent?
    
    override open var title: String? {
        didSet {
            self.contentView?.title = title
        }
    }
    open override var image: UIImage? // default is nil
        {
        didSet {
            self.contentView?.image = image
        }
    }
    
    // MARK: UITabBarItem properties
    open override var selectedImage: UIImage? // default is nil
        {
        didSet {
            self.contentView?.selectedImage = selectedImage
        }
    }
  
    open override var tag: Int // default is 0
        {
        didSet { self.contentView?.tag = tag }
    }
    
    public init(_ contentView: SJTabbarItemContent = SJTabbarItemContent(), title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        super.init()
        self.contentView = contentView
        self.setTitle(title, image: image, selectedImage: selectedImage, tag: tag)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func setTitle(_ title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.tag = tag
    }
}
