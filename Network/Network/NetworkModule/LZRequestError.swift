//
//  LZRequestError.swift
//  Network
//
//  Created by JiWuChao on 2019/7/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

@objc public enum LZRequestErrorCode: Int{
    case unknown = -100000;//未知错误
    case network = -100001//网络错误
    case json2model = -100002//json错误
    case requestOnGoing = -100003//有请求正在进行
    case server = -100004//请求成功，但服务器返回了错误码
    case networkNotReachable = -100005//无网络，网络已断开
}

public class LZRequestError: Error{
    var code: LZRequestErrorCode?;
    var userInfo: [String: Any]?;
    var nsError: NSError?;
    
    //业务错误码
    var bizErrorCode: Int = 0;
    var displayMessage: String?;
    var message: String?;
    
    init(code: LZRequestErrorCode, msg: String) {
        self.code = code;
        self.userInfo = ["msg": msg];
    }
    
    init(nsError: NSError) {
        self.nsError = nsError;
        self.code = LZRequestErrorCode.network;
        self.userInfo = ["msg": "网络底层错误"];
    }
}
