//
//  Father.swift
//  构造
//
//  Created by JiWuChao on 2017/10/26.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit

class Father: NSObject {
    var text : String
    var response :String?
    init(text:String) {
        self.text = text
    }
    
    func ask () {
        print(self.text)
    }
}
