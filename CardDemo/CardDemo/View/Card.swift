//
//  Card.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/24.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class Card: UIView ,BottomViewDelegate{
   
    
    lazy var cardView : CardView = {
      let card = CardView()
//        card.backgroundColor = UIColor.red;
    card.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeCard(sender:))))
        return card
    }()
    
    let buttonsContainer: BottomView = {
        let c = BottomView()
//        c.delegate = (self as! BottomViewDelegate)
        return c
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(cardView)
        addSubview(buttonsContainer)
        cardView.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).multipliedBy(0.85)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.top.equalTo(self.snp.top).offset(20)
            make.centerX.equalTo(self)
        }
        buttonsContainer.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-50)
            make.width.equalTo(self)
            make.height.equalTo(60)
        }
    }
    
    @objc func swipeCard(sender: UIPanGestureRecognizer) {
//        sender.swipeView(tinderCard)
    }
    
}

extension Card {
    func BottomViewLikeBtnClikced(bottom: BottomView) {
        print("代理点击了 喜欢")
    }
    
    func BottomViewPassBtnClicke(bottom: BottomView) {
        print("代理点击了 过")
    }
    
    func BottomViewSuperLikeBtnClicke(bottom: BottomView) {
        print("代理点击了 喜欢上一个")
    }
}

