//
//  LZGameCategoryCell.swift
//  TestUI
//
//  Created by JiWuChao on 2017/12/13.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

import SnapKit

class LZGameCategoryCell: UICollectionViewCell {
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame)
        setupUI()
    }
    
    public var title:String? {
        didSet {
            label?.text = title
        }
    }
    private let label:UILabel?
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        label?.textColor = UIColor.lightGray
        label?.font = UIFont.systemFont(ofSize: 14)
        label?.textAlignment = .center
        self.contentView.addSubview(label!)
        label?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
    }
    
  
}








