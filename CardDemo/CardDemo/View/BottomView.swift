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
//        let b = ButtonFactory.buttonWithImage(image: #imageLiteral(resourceName: "like"), cornerRadius: 0, target: self, selector: #selector(like), sizeToFit: true).new
//        return b
        let bt = UIButton()
        return bt;
    }()
    
    lazy var passButton: UIButton = {
//        let b = ButtonFactory.buttonWithImage(image: #imageLiteral(resourceName: "pass"), cornerRadius: 0, target: self, selector: #selector(pass), sizeToFit: true).new
//        return b
        let bt = UIButton()
        return bt;
    }()
    
    lazy var superLikeButton: UIButton = {
//        let b = ButtonFactory.buttonWithImage(image: #imageLiteral(resourceName: "superlike"), cornerRadius: 0, target: self, selector: #selector(superLike), sizeToFit: true).new
//        return b
        let bt = UIButton()
        return bt;
    }()
    
    lazy var container: UIStackView = {
        let c = UIStackView(arrangedSubviews: [
            self.likeButton, self.passButton, self.superLikeButton
            ])
//        c.translatesAutoresizingMaskIntoConstraints = false
        c.spacing = 20
        c.distribution = .fillEqually
        return c
    }()
    
    func setupUI()  {
        addSubview(self.likeButton)
        addSubview(self.passButton)
        addSubview(self.superLikeButton)
        
        likeButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
        }
    }
    
    
    
}


extension BottomView {
    
    @objc func like() {
        print("like print")
         delegate?.BottomViewLikeBtnClikced(bottom: self)
    }
    
    @objc func pass() {
        
        print("pass print")
        delegate?.BottomViewPassBtnClicke(bottom: self)
    }
    
    @objc func superLike() {
        print("super like print")
        delegate?.BottomViewSuperLikeBtnClicke(bottom: self)
    }
}






