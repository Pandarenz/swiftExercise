//
//  ListTableViewController.swift
//  私人通讯录
//
//  Created by JiWuChao on 2017/10/31.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var personList = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData { (list) in
            self.personList += list
            self.tableView .reloadData()
        }
    }

    func loadData(complate: @escaping (_ list:[Person])->()) -> (){
        DispatchQueue.global().async {
        print("加载中")
            Thread.sleep(forTimeInterval: 2)
            var arrayVM = [Person]()
            for i in 1..<20 {
                let p = Person()
                p.name = "zhangsan-\(i)"
                p.phone = "186 " +  String(format:"%06d",arc4random_uniform(1000000))
                p.title = "boss"
                arrayVM.append(p)
            }
            DispatchQueue.main.async {
                complate(arrayVM)
            }
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "listToDetail", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailTableViewController
        if let indexPath = sender as? IndexPath {
            vc.person = personList[indexPath.row]
            vc.complation = {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        } else {
            // 新建个人记录
            vc.complation = {
                // 获取明细控制器的 person 插入数据的顶部 刷新列表
                guard let p = vc.person else {
                    return
                }
                self.personList.insert(p, at: 0)
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func add(_ sender: Any) {
        
        performSegue(withIdentifier: "listToDetail", sender: nil)
        
    }
    
}
