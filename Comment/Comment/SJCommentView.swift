//
//  SJCommentView.swift
//  Comment
//
//  Created by JiWuChao on 2019/8/11.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import UIKit

import SnapKit

class SJCommentView: UIView {

    var dataSource:[SJCommentTopicFrame]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    lazy var tableView: UITableView = {
        let tbv = UITableView.init(frame: self.bounds, style: UITableView.Style.grouped)
            tbv.register(SJCommentCell.self, forCellReuseIdentifier: "cell")
            tbv.register(SJCommentFooter.self, forHeaderFooterViewReuseIdentifier: "footer")
            tbv.register(SJCommentHeader.self, forHeaderFooterViewReuseIdentifier: "header")
            tbv.delegate = self
            tbv.dataSource = self
            tbv.backgroundColor = UIColor.purple
        return tbv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        tableView.reloadData()
    }
}

extension SJCommentView :UITableViewDelegate {
    
}

extension SJCommentView:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionItem = self.dataSource?[section]
        if let sectionM = sectionItem , let items = sectionM.commentItemFrames{
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cel = cell as? SJCommentCell {
            let item = self.dataSource?[indexPath.section]
            if let it = item?.commentItemFrames?[indexPath.row] {
                cel.item = it
            }
            return cel
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        if let headView = header as? SJCommentHeader {
            let model = self.dataSource?[section]
            headView.topicModel = model
            return headView
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        if let footerView = footer as? SJCommentFooter {
            return footerView
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionF = self.dataSource?[section]
        if let sec = sectionF {
            return sec.topicH
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sections = self.dataSource?[indexPath.section]
        if let sec = sections?.commentItemFrames {
            let item = sec[indexPath.row]
            
            return item.height
            
        }
        return 0
    }
    
    
}
