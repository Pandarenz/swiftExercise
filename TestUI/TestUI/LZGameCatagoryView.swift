//
//  LZGameCatagoryView.swift
//  TestUI
//
//  Created by JiWuChao on 2017/12/13.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

import SnapKit

class LZGameCatagoryView: UIView {
    private var collectionView :UICollectionView?
    private  var layout :UICollectionViewFlowLayout?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension LZGameCatagoryView {
    func setUpUI() {
        layout = UICollectionViewFlowLayout()
        layout?.minimumLineSpacing = 10
        layout?.minimumInteritemSpacing = 10
        layout?.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout?.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: 100)
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout!)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}









