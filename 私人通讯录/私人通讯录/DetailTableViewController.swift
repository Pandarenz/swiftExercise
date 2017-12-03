//
//  DetailTableViewController.swift
//  私人通讯录
//
//  Created by JiWuChao on 2017/10/31.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var person : Person?
    
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var titleField: UITextField!
    // 闭包的返回值是可选的
    //    var complation:()->()?
    // 闭包是可选的
    var complation:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if person != nil  {
            nameTextField.text = person?.name
            phoneTextField.text = person?.phone
            titleField.text = person?.title
        }
        
    }

    @IBAction func savePerson(_ sender: Any) {
        // 判断 person 是否为空如果为空则为新建
        if person == nil {
            person = Person()
        }
        person?.name = nameTextField.text
        person?.phone = phoneTextField.text
        person?.title = titleField.text
        complation?() // 可选解包 如果闭包 为 nil 则什么也不做
      navigationController?.popViewController(animated: true)
    }
    
}
