//
//  LZPageControl.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/14.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol LZPageControlDelegate {
    func pageControl(control:LZPageControl,scrolToIndex:Int)
    func pageControl(control:LZPageControl) -> [LZPageNavBarProtocol]
}


class LZPageControl: UIView {

    lazy var scrollView :UIScrollView = {
        let scroll = UIScrollView(frame: self.bounds)
        scroll.delegate = self
        scroll.alwaysBounceHorizontal = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        addSubview(scroll)
        return scroll
    }()
    
    var delegate:LZPageControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LZPageControl :UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    
}









