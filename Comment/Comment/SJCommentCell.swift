//
//  SJCommentCell.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

class SJCommentCell: UITableViewCell {
    
    var item:SJCommentItemFrame? {
        didSet {
//            nameLbl.text = item?.item?
            contentLbl.text = item?.item?.content
        }
    }
    
    
    
    lazy var headerImg: UIImageView = {
        let img = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 32, height: 32))
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 16
        img.image = UIImage.init(named: "man")
        return img
    }()
    
    
    lazy var nameLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor.white
        lbl.textAlignment = NSTextAlignment.left
        lbl.text = "小红薯666"
        return lbl
    }()
    
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = UIColor.white
        lbl.textAlignment = NSTextAlignment.left
        lbl.text = "06-08"
        return lbl
    }()
    
    lazy var contentLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = UIColor.white
        lbl.textAlignment = NSTextAlignment.left
        lbl.numberOfLines = 0
        lbl.text = "重庆火锅重麻重辣，二者必须均分，决不能只麻，要辣辣辣辣！！！"
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.lightGray
        addSubview(headerImg)
        headerImg.snp.makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.leading.equalTo(self.snp.leading).offset(40)
            make.top.equalTo(self).offset(8)
        }
        addSubview(nameLbl)
        
        nameLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(headerImg.snp.trailing).offset(4)
            make.top.equalTo(headerImg)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        
        
        addSubview(timeLbl)
        
        timeLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLbl)
            make.top.equalTo(nameLbl.snp.bottom).offset(2)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
        }
        addSubview(contentLbl)
        contentLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLbl)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.top.equalTo(timeLbl.snp.bottom).offset(3)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
