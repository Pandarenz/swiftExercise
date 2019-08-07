//
//  SJRouter.swift
//  Router
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

public typealias Handle = ( _ Context:[String:Any], _ comparate:Complate?)-> Void

public typealias Complate = (_ success:Bool,_ failure:Error?) -> Void

public typealias Parameters = [String:Any]

public class SJRouter {
    
    public static let `default` = SJRouter.init()
    
    private var routes:[String:SJRoute]
    
    init() {
        self.routes = [String:SJRoute]()
    }
    
    public func register(URL url:String,Handle handle: @escaping Handle)  {
        
        let routerURL = SJRouterURL.init(url: url)
        let routeRequest = SJRouterRequest.init(url: routerURL, parameters: nil)
        
        let route = SJRoute.init(url: routerURL, request: routeRequest, handle: handle, complate: nil)
        
        self.routes[url] = route
        
    }
 
    
    func openUrl(fromURL url:String,parameters:Parameters?,compalate:@escaping Complate) {
        let request = SJRouterURL.init(url: url)
        
        let route = self.routes[url]
        
        let handle = route?.handle
        
        handle?(parameters!,compalate)
        
        
    }
    
}
