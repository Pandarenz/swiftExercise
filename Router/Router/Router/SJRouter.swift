//
//  SJRouter.swift
//  Router
//
//  Created by JiWuChao on 2019/8/7.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

public typealias Handle = ( _ Context:[String:Any]?, _ comparate:Complate?)-> Void

public typealias Complate = (_ success:Bool,_ failure:Error?) -> Void

public typealias Parameters = [String:Any]


//TODO:线程安全问题
public class SJRouter {
    
    public static let `default` = SJRouter.init()
    
    private var routes:[String:LZURLOperation]
    
    private lazy var urlParser: LZURLParser = {
        let parser = LZURLParser.init()
        return parser
    }()
    
    
    init() {
        self.routes = [String:LZURLOperation]()
    }
    
    public func register(URL url:LZURLConvertible,Handle handle: @escaping Handle)  {
        
        let result = urlParser.parserURL(urlString: url)
        
        switch result {
            
        case .Failure(let error):
            assert(true, error.localizedDescription)
        case .Success(let parameters, let keyValue):
            let operation = LZURLOperation.init(routerUrl: url, parameters: parameters, handle: handle, complate: nil)
            addRouter(keyPath: keyValue, operation: operation)
        }
        
        
    }
 
    
    func openUrl(fromURL url:LZURLConvertible,parameters:Parameters?,compalate:@escaping Complate) {
        
        var operation:LZURLOperation?
        
        let result = urlParser.parserURL(urlString: url)
        
        switch result {
            
        case .Failure(let error):
            compalate(false,error)
        case .Success(let para, let key):
            operation = getOperation(keyPath: key)
            guard var op = operation else {
                return compalate(false,LZURLOperation.Error.noMatch)
            }
            op.addParameters(dic: para)
            op.addParameters(dic: parameters)
            op.handle?(op.parameters,compalate)
        }
    }
    
    private func addRouter(keyPath:String,operation:LZURLOperation) {
        self.routes[keyPath] = operation
    }
    
    
    private func getOperation(keyPath:String) -> LZURLOperation? {
        
        return self.routes[keyPath]
    }
    
}
