//
//  ViewController.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    lazy var commentView: SJCommentView = {
        let commt = SJCommentView.init(frame: UIScreen.main.bounds)
        return commt
    }()
    
    let commentVM = SJCommentVM.init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        commentView.dataSource = commentVM.getFrameData(data: commentVM.getDatas())
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            self.commentView.dataSource = self.commentVM.change(frames: self.commentVM.getFrameData(data: self.commentVM.getDatas()))
        }
    }


}

