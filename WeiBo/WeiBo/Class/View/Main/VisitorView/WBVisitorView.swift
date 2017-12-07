//
//  WBVisitorView.swift
//  WeiBo
//
//  Created by JiWuChao on 2017/12/1.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit
import SnapKit


class WBVisitorView: UIView {
     lazy var registerBtn :UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName:  "common_button_white_disable")
    
     lazy var loginBtn :UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName:  "common_button_white_disable")
    
    
    
    //访客视图的信息字典
    var visitordInfo:[String:String]?{
        didSet {
            guard let imageName = visitordInfo?["imageName"],let message = visitordInfo?["message"] else {
                return
            }
            tipLbl.text = message
            if imageName == "" {
                startAnimation()
                return
            }
            iconImage.image = UIImage(named: message)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     private  func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
      
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 15
        animation.isRemovedOnCompletion = false
        iconImage.layer.add(animation, forKey: nil)
        
    }
    
    // 懒加载中的属性只有调用 UIKit 空间的指定构造函数,其他都需要使用类型 : 都加上 比较好
    private lazy var iconImage:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var houseImage:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    private lazy var tipLbl:UILabel = UILabel.cz_label(
        withText: "关注一些人,这里有惊喜的",
        fontSize: 14,
        color: UIColor.darkGray)
//        tipLbl as? UILabel .numberOfCount = 0
    
    
    
    
}

extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
        addSubview(iconImage)
        addSubview(houseImage)
        addSubview(tipLbl)
        addSubview(registerBtn)
        addSubview(loginBtn)
        iconImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-100)
        }
        houseImage.snp.makeConstraints { (make) in
            make.center.equalTo(iconImage)
        }
        tipLbl.snp.makeConstraints { (make) in
            make.top.equalTo(houseImage.snp.bottom).offset(35)
            make.centerX.equalTo(self)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLbl.snp.bottom).offset(25)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.trailing.equalTo(self.snp.centerX).offset(-20)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.top.width.height.equalTo(registerBtn)
            make.leading.equalTo(self.snp.centerX).offset(20)
        }
    }
}

