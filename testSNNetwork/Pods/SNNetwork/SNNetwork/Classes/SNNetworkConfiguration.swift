//
//  SNNetworkConfiguration.swift
//  Alamofire
//
//  Created by JiWuChao on 2019/7/23.
//

import Foundation

import Moya

public class SNNetworkConfiguration {
    
    public static var `default`: SNNetworkConfiguration = SNNetworkConfiguration()
    
    /// 默认请求头 默认为空
    public var commonHeaders: (TargetType) -> [String: String] = { _ in [:] }
    /// 默认公共参数 默认为空
    public var commonParams:[String:Any] = [:]
    /// 修改task
    public var replacingTask: (TargetType) -> Task = { $0.task }
    
    /// 请求超时时间 默认15秒
    public var timeoutInterval: TimeInterval = 15
    /// 请求的缓存策略 默认reloadIgnoringCacheData
    public var requestCachePolicy:URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
    
    
    /*
     
     此功能比较强大
     
     Moya 提供的插件
     AccessTokenPlugin 管理AccessToken的插件
     CredentialsPlugin 管理认证的插件
     NetworkActivityPlugin 管理网络状态的插件
     NetworkLoggerPlugin 管理网络log的插件
     自定义插件：
        实现 PluginType 协议
     */
    public var plugins: [PluginType] = []
    
    public init() {}
}


