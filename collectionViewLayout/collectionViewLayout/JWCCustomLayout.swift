//
//  JWCCustomLayout.swift
//  collectionViewLayout
//
//  Created by JiWuChao on 2019/8/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

protocol JWCCustomLayoutDelegate:NSObjectProtocol {
    
    // cell height
    func collectionView(collectionView:UICollectionView,collectionViewLayout:JWCCustomLayout,heightForRowAtIndexPath:NSIndexPath, itemWidth:CGFloat) -> CGFloat
    // headerSize
    func collectionView(collectionView:UICollectionView,collectionViewLayout:JWCCustomLayout,referenceSizeForHeaderInSection:Int) -> CGSize;
}


class JWCCustomLayout: UICollectionViewLayout {

    
    
    
    
}
