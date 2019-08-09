//
//  LZURLRouter.swift
//  Router
//
//  Created by JiWuChao on 2019/8/9.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation


import Foundation

/// Context:[String:Any] 注册时可以填写默认参数
/// error: 注册失败的话 会有返回值
/// complate: 当在register 处理完 open 方法传过来的参数或者事件需要 告诉open方法调用方时 处理此complate
public typealias RegisterHandle = ( _ Context:[String:Any]?, _ error:Error?, _ complate:OpenComplate?)-> Void
// open 打开成功 或者打开失败
public typealias OpenComplate = (_ success:Bool,_ failure:Error?) -> Void

public typealias Parameters = [String:Any]


//TODO:线程安全问题
public class LZURLRouter {
    
    // [url除参数外:Operation]
    typealias LZOperationDic = [String:LZURLOperation]
    //[scheme:oper] 建议一个模块一个scheme
    typealias LZRouterDic = [String:LZOperationDic]
    
    public static let `default` = LZURLRouter.init()
    
    private var ops = LZOperationDic()
    
    private var routers = LZRouterDic()
    
    //MARK: register 方法
    public func register(URL url:LZURLConvertible,Handle handle: @escaping RegisterHandle)  {
        
        let compenent = LZURLComponent.init(url: url)
        
        switch compenent.isValidURLString() {
        case .Failure( let error):
            // 出错
            handle(nil, error, nil)
            break
        default:
             addRouter(component: compenent, handle: handle)
        }
        
    }
    
    //MARK: open 方法
    public func openUrl(fromURL url:LZURLConvertible,parameters:Parameters?,complete:@escaping OpenComplate) {
    
        let compenent = LZURLComponent.init(url: url)
        
        switch compenent.isValidURLString() {
            case .Failure(let error):
                complete(false,error)
            default:
                openURL(component: compenent, parameters: parameters, complete: complete)
        }
        
    }
    
     //MARK: 能否打开一个url
    public func isCanOpen(url:LZURLConvertible) -> Bool {
        
        let component = LZURLComponent.init(url: url)
        
        guard component.isValidUrl() else { return false }
        
        guard let _ = getOperation(component: component) else { return false }
        
        return true
    }
    
    // MARK: 删除以 scheme:// 开始的路由 如果一个模块一个scheme的话 此方法可以删除一个模块的路由
    public func removeScheme(scheme:String) {
        let ops = self.routers[scheme]
        if let _ = ops {
            self.routers[scheme] = nil
        }
    }
    
    public func removeScheme(schm:String) -> Bool {
        let ops = self.routers[schm]
        if let _ = ops {
            self.routers[schm] = nil
            return true
        } else {
            return false
        }
    }
    
    
    // MARK: 删除某一个路由
    public func removeUrl(url:LZURLConvertible) -> Bool {
        let result = removeURL(url: url)
        
        switch result {
        case .Failure(_):
            return false
        default:
            return true
        }
        
    }
    
    
    public func removeURL(url:LZURLConvertible) -> LZURLRouter.RemoveResult {
        
        let comonent = LZURLComponent.init(url: url)
        
        guard comonent.isValidUrl() else {
//            assert(false, "LZURLRouter:删除URL:\(url)失败。\n 详情: \(#line) \(#function) \n 原因: URL 不合法")
            return LZURLRouter.RemoveResult.Failure(LZURLRouter.RemoveError.URLIllegality)
        }
        
        guard var operations = self.routers[comonent.scheme] else {
//            assert(false, "LZURLRouter:删除URL:\(url) 失败。\n详情: 第 \(#line) 行 函数名: \(#function) \n 原因: 当前scheme未注册")
            return LZURLRouter.RemoveResult.Failure(LZURLRouter.RemoveError.SchemeNoRegister)
        }
        
        guard let _ = operations[comonent.keyPath] else {
//            assert(false, "LZURLRouter:删除URL:\(url)失败。\n详情: \(#line) \(#function) \n 原因: 当前keypath未注册")
            return LZURLRouter.RemoveResult.Failure(LZURLRouter.RemoveError.KeyPathNoRegister)
        }
        
        operations[comonent.keyPath] = nil
        
        self.routers[comonent.scheme] = operations
        
        if self.routers[comonent.scheme]?.count == 0 {
            self.routers[comonent.scheme] = nil
        }
        
        return LZURLRouter.RemoveResult.Success(key: url.stringValue)
        
    }
    
    
    
   
    private func addRouter(component:LZURLComponent,handle: @escaping RegisterHandle) {
         let operation = LZURLOperation.init(parameters: nil, component: component, handle: handle, complate: nil)
        
         addRouter(operation: operation)
    }
    
    private func addRouter(operation:LZURLOperation) {
      
        let component = operation.component
        
        // 根据scheme查找是否已经有注册过这个scheme了
        let operations = self.routers[component.scheme]
        
        var keyPath:String = ""
        
        let result = component.extractURLKeyPath()
        
        switch result {
            case .Failure( _):
                print("URL不合法 注册路由失败")
            case .Success(let key):
                keyPath = key
        }
        
        guard keyPath.count > 0 else {
            print("URL不合法 注册路由失败")
            return
        }
        
        // 1. 如果已经注册过了
        if var ops = operations {
            // 不检测同一个keypath是否已经注册 如果已经注册 则覆盖
            ops[keyPath] = operation
            self.routers[component.scheme] = ops
        } else { //2. 如果这个scheme 还没有注册过
            var opes = LZOperationDic()
            opes[keyPath] = operation
            self.routers[component.scheme] = opes
        }
    }
    
    
   private func openURL(component:LZURLComponent,parameters:Parameters?,complete:@escaping OpenComplate) {
    
        let op = getOperation(component: component)
        if var p = op {
           _ = p.addParameters(dic: component.parameters)
           _ = p.addParameters(dic: parameters)
            p.handle?(p.parameters,nil,complete)
//            // TODO:再次是否应该有回调呢
//            // 匹配成功
//            complete(true,nil)//找到了
        } else {
            // 匹配失败当前 url可能没有注册
            complete(false,LZURLRouter.RouterError.URLNoMatch)// 失败
        }
        
    }
    
   // 根据component 获取 LZURLOperation
   private func getOperation(component:LZURLComponent) -> LZURLOperation? {
        
        let scheme = component.scheme
        let operations = self.routers[scheme]
        guard let ops = operations else {
            // 没有取出 当前的scheme 可能没有注册成功
            return nil }
        
        let result = component.extractURLKeyPath()
        
        var keyPath:String = ""
        
        switch result {
        case .Failure( _):
            // URL 不合法 请检查url
            print("URL不合法 注册路由失败")
            return nil
        case .Success(let key):
            keyPath = key
        }
        
        let op = ops[keyPath]
        
       return op
    }
    
}

extension LZURLRouter {
    
    // router 匹配结果
    enum RouterError: Swift.Error {
        case URLNoMatch
        case URLIllegality
        
        var localizedDescription: String {
            switch self {
            case .URLIllegality:
                return "出现错误: URL不合法，请检查URL"
            case .URLNoMatch:
                return "出现错误: URL没有匹配到对应的路由"
            }
        }
    }
    
    enum RouterResult {
        case Failure(LZURLRouter.RouterError)
        case Success(operation:LZURLOperation)
    }
    
}


extension LZURLRouter {
    
   public enum RemoveError:Swift.Error {
        
        case URLIllegality
        
        case SchemeNoRegister
        
        case KeyPathNoRegister
        
        var localizedDescription: String {
            switch self {
            case .URLIllegality:
                return "removeURL出错:URL 非法"
            case .KeyPathNoRegister:
                return "removeURL出错: 当前URL的keyPath 未注册"
            case .SchemeNoRegister:
                return "removeURL出错: Scheme 未注册"
            }
        }
    }
    
   public enum RemoveResult {
        case Failure(LZURLRouter.RemoveError)
        // key 为 scheme 或者是 url
        case Success(key:String)
    }
}
