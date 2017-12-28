//
//  BottomView.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/24.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

protocol BottomViewDelegate {
    
    func BottomViewLikeBtnClikced(bottom:BottomView)
    func BottomViewPassBtnClicke(bottom:BottomView)
    func BottomViewSuperLikeBtnClicke(bottom:BottomView)
}

class BottomView: UIView {
    
    var delegate : BottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

    lazy var likeButton: UIButton = {
 
        let bt = UIButton()
        bt.addTarget(self, action: #selector(like), for: .touchUpInside)
        bt.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        bt.setImage(#imageLiteral(resourceName: "like"), for: .highlighted)
        bt.layer.masksToBounds = true
        return bt;
    }()
    
    lazy var passButton: UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(pass), for: .touchUpInside)
        bt.setImage(#imageLiteral(resourceName: "pass"), for: .normal)
        bt.setImage(#imageLiteral(resourceName: "pass"), for: .highlighted)
        bt.layer.masksToBounds = true
        return bt;
    }()
    
    lazy var superLikeButton: UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(superLike), for: .touchUpInside)
        bt.setImage(#imageLiteral(resourceName: "superlike"), for: .normal)
        bt.setImage(#imageLiteral(resourceName: "superlike"), for: .highlighted)
        return bt;
    }()
    
    
    func setupUI()  {
        
        addSubview(self.passButton)
        self.passButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(55)
            make.center.equalTo(self)
        }
        addSubview(self.likeButton)
        self.likeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(passButton)
            make.trailing.equalTo(passButton.snp.leading).offset(-30)
            
        }
        
        addSubview(self.superLikeButton)
        self.superLikeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(passButton)
            make.leading.equalTo(passButton.snp.trailing).offset(30)
        }
        
    }
}



extension BottomView {
    
    @objc func like() {
         delegate?.BottomViewLikeBtnClikced(bottom: self)
    }
    
    @objc func pass() {
        delegate?.BottomViewPassBtnClicke(bottom: self)
    }
    
    @objc func superLike() {
        delegate?.BottomViewSuperLikeBtnClicke(bottom: self)
    }
}






