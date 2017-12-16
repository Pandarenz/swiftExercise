//
//  Photo.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/17.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

struct Photos:Codable {
    let photos:[Photo]
}

struct Photo:Codable {
    let id: Int
    let name: String
    let description: String?
    let created_at: Date
    let image_url: String
    let for_sale: Bool
    let camera: String?
}
