//
//  PhotoListCell.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/17.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

import SnapKit

import SDWebImage


class PhotoListCell: UITableViewCell {
    
    var mainImg :UIImageView?
    var backGView :UIView?
    var titleLbl :UILabel?
    var detailLbl :UILabel?
    var dateLbl :UILabel?
//    let dateFormate = DateFormatter()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func updateCellWithModel(cellModel:Photo) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.mainImg?.sd_setImage(with: URL.init(string: cellModel.image_url), completed:nil)
        self.titleLbl?.text = cellModel.name
        self.detailLbl?.text = cellModel.description
        self.dateLbl?.text = dateFormatter.string(for: cellModel.created_at)
        
    }
    
    
    private func setupUI() {
        mainImg = UIImageView()
        self.contentView.addSubview(mainImg!)
        mainImg?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        backGView = UIView()
        mainImg?.addSubview(backGView!)
        backGView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        backGView?.snp.makeConstraints({ (make) in
            make.trailing.leading.bottom.equalTo(self)
            make.height.equalTo(60)
        })
        titleLbl = UILabel()
        titleLbl?.font = UIFont.systemFont(ofSize: 14)
        titleLbl?.textAlignment = .left
        titleLbl?.textColor = UIColor.white
        backGView?.addSubview(titleLbl!)
        titleLbl?.snp.makeConstraints({ (make) in
            make.leading.equalTo(backGView!).offset(10)
            make.top.equalTo(backGView!).offset(3)
            make.height.equalTo(25)
           make.trailing.equalTo(backGView!.snp.centerX)
        })
        
        detailLbl = UILabel()
        detailLbl?.font = UIFont.systemFont(ofSize: 14)
        detailLbl?.textColor = UIColor.white
        detailLbl?.textAlignment = .left
        backGView!.addSubview(detailLbl!)
        detailLbl?.snp.makeConstraints({ (make) in
            make.bottom.trailing.equalTo(self)
            make.leading.equalTo(titleLbl!)
            make.top.equalTo((titleLbl?.snp.bottom)!)
        })
        
        dateLbl = UILabel()
        dateLbl?.font = UIFont.systemFont(ofSize: 14)
        dateLbl?.textColor = UIColor.white
        dateLbl?.textAlignment = .right
        backGView!.addSubview(dateLbl!)
        dateLbl?.snp.makeConstraints({ (make) in
        make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.leading.equalTo(self.snp.centerX)
            make.height.top.equalTo(titleLbl!)
            
        })
//        dateFormate.date(from: "yyyy-MM-dd")
    }
}
