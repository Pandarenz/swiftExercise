//
//  CoverView.swift
//  CollectionView
//
//  Created by JiWuChao on 2017/11/22.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class CoverView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {

    override convenience init(frame: CGRect) {
        setupUI()
        self.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        let layout :UICollectionViewFlowLayout
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = vertical
        
       let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self(UICollectionViewCell), forCellWithReuseIdentifier: "reuseID")
        collectionView.dataSource = self as UICollectionViewDataSource;
        collectionView.delegate = self as UICollectionViewDelegate;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionView.dequeueReusableCell(UICollectionViewCell)
        cell.backgroundColor.redColor
        
    }
    
    
}












