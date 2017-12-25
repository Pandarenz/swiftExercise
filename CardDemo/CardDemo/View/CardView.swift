//
//  CardView.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/23.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

import SnapKit

class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        let photoImageView = ImageViewFactory.standardImageView(image: UIImage.init(named: "jynerso")!, cornerRadius: 0, interactionEnabled: true, contentMode: .scaleAspectFill, sizeToFit: false).new
            photoImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        let friendsIcon = ImageViewFactory.standardImageView(image: #imageLiteral(resourceName: "tinderIcon"), cornerRadius: 0, interactionEnabled: false, contentMode: .scaleAspectFill, sizeToFit: false).new
        
        let containView: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 10.0
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.gray.cgColor
            view.clipsToBounds = true
            
            return view
            
        }()
        
        
        let infoView :UIView = {
            let info = UIView()
            return info;
        }()
        
        let nameLabel = LableFactory.standardLbl(text: "Jyn Erso", textColor: .gray, fontStyle: .headline, textAlignment: .left, sizeToFit: true, adjustToFit: true).new
            nameLabel.numberOfLines = 0
        let workLabel = LableFactory.standardLbl(text: "Member of the Alliance to Restore the Republic", textColor: .gray, fontStyle: .subheadline, textAlignment: .left, sizeToFit: true, adjustToFit: true).new
        
        containView.addSubview(photoImageView)
        containView.addSubview(infoView)
        
        infoView.addSubview(nameLabel)
        infoView.addSubview(workLabel)
        infoView.addSubview(friendsIcon)
        
        addSubview(containView)
        
        containView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        photoImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-60)
        }
        
        infoView.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.equalTo(self)
            make.top.equalTo(photoImageView.snp.bottom)
        }
        friendsIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(35)
            make.centerY.equalTo(infoView)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.top.equalTo(photoImageView.snp.bottom).offset(2)
            make.height.equalTo(16)
        }
        workLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.trailing.equalTo(friendsIcon.snp.leading)
        }
    }
}
