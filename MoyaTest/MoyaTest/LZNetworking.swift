//
//  LZNetworking.swift
//  MoyaTest
//
//  Created by JiWuChao on 2019/7/10.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation

import Moya

import Alamofire

let configuration: URLSessionConfiguration = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    configuration.timeoutIntervalForRequest = 15
    configuration.timeoutIntervalForResource = 15
    return configuration
    
}()


let delegate: SessionDelegate = {
    let delegate = SessionDelegate()
    delegate.sessionDidReceiveChallenge = { session, challenge in
        //认证服务器证书
        if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodServerTrust {
            print("服务端证书认证！")
            let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
            let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
            let remoteCertificateData
                = CFBridgingRetain(SecCertificateCopyData(certificate))!
            let cerPath = Bundle.main.path(forResource: "tomcat", ofType: "cer")!
            let cerUrl = URL(fileURLWithPath:cerPath)
            let localCertificateData = try! Data(contentsOf: cerUrl)
            
            if (remoteCertificateData.isEqual(localCertificateData) == true) {
                
                let credential = URLCredential(trust: serverTrust)
                challenge.sender?.use(credential, for: challenge)
                return (URLSession.AuthChallengeDisposition.useCredential,
                        URLCredential(trust: challenge.protectionSpace.serverTrust!))
                
            } else {
                return (.cancelAuthenticationChallenge, nil)
            }
        }
            //认证客户端证书
        else if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodClientCertificate {
            print("客户端证书认证！")
            //获取客户端证书相关信息
            let identityAndTrust:IdentityAndTrust = extractIdentity();
            
            let urlCredential:URLCredential = URLCredential(
                identity: identityAndTrust.identityRef,
                certificates: identityAndTrust.certArray as? [AnyObject],
                persistence: URLCredential.Persistence.forSession);
            
            return (.useCredential, urlCredential);
        }
            // 其它情况（不接受认证）
        else {
            print("其它情况（不接受认证）")
            return (.cancelAuthenticationChallenge, nil)
        }
    }
    
    return delegate
    
}()


//获取客户端证书相关信息
func extractIdentity() -> IdentityAndTrust {
    var identityAndTrust:IdentityAndTrust!
    var securityError:OSStatus = errSecSuccess
    
    let path: String = Bundle.main.path(forResource: "mykey", ofType: "p12")!
    let PKCS12Data = NSData(contentsOfFile:path)!
    let key : NSString = kSecImportExportPassphrase as NSString
    let options : NSDictionary = [key : "123456"] //客户端证书密码
    //create variable for holding security information
    //var privateKeyRef: SecKeyRef? = nil
    
    var items : CFArray?
    
    securityError = SecPKCS12Import(PKCS12Data, options, &items)
    
    if securityError == errSecSuccess {
        let certItems:CFArray = (items as CFArray?)!;
        let certItemsArray:Array = certItems as Array
        let dict:AnyObject? = certItemsArray.first;
        if let certEntry:Dictionary = dict as? Dictionary<String, AnyObject> {
            // grab the identity
            let identityPointer:AnyObject? = certEntry["identity"];
            let secIdentityRef:SecIdentity = (identityPointer as! SecIdentity?)!
            print("\(String(describing: identityPointer))  :::: \(secIdentityRef)")
            // grab the trust
            let trustPointer:AnyObject? = certEntry["trust"]
            let trustRef:SecTrust = trustPointer as! SecTrust
            print("\(String(describing: trustPointer))  :::: \(trustRef)")
            // grab the cert
            let chainPointer:AnyObject? = certEntry["chain"]
            identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef,
                                                trust: trustRef, certArray:  chainPointer!)
        }
    }
    return identityAndTrust;
}

//定义一个结构体，存储认证相关信息
struct IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:AnyObject
}

let serverTrustPolicies: [String: ServerTrustPolicy] = [
    
    "172.16.88.106": .pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain: true, validateHost: true),
    "insecure.expired-apis.com": .disableEvaluation
    
]




//let myManager = Manager(configuration)



let network = MoyaProvider<MultiTarget>.init(plugins: [RequestHandlingPlugin]())

class LZNetworking<T:TargetType> {
    
//    public static let `default` = LZNetworking<T>()
//    public let manager = MoyaProvider<LZSearch>.init(endpointClosure: myEndpointClosure, requestClosure: timeoutClosure)
//    public let manager = MoyaProvider<LZSearch>.init(plugins: [RequestHandlingPlugin()])
    
//    let manager = Manager(configuration: configuration, delegate:delegate, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    
   public lazy var manager: Manager = {
        let m = MoyaProvider<T>.defaultAlamofireManager()
        return m
    }()
    
    init() {
        manager.delegate.sessionDidReceiveChallenge = { (session,challenge) in
            var disposition = URLSession.AuthChallengeDisposition.performDefaultHandling;
//            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//                var host = challenge.protectionSpace.host;
//                if let reqSerializer = manager?.requestSerializer {
//                    let oriHost = reqSerializer.value(forHTTPHeaderField: "HOST");
//                    if let oH = oriHost {
//                        host = oH;
//                    }
//                }
            return    (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!))
            
        }
    }
    
    
    
 
}

extension MoyaProvider {
    @discardableResult
    open func request<T: Codable>(_ target: Target,
                                    model: T.Type,
                                    completed: ((_ returnData: T?,_ error:Error?) -> Void)?) -> Cancellable? {
        return request(target, completion: { (resut) in
            guard let completion = completed else {return}
            switch resut {
                case .success(let resultValue):
                    guard let returnData = try? resultValue.map(model.self) else {
                        completion(nil, resut.error)
                        return
                    }
                    completion(returnData,resut.error)
                break
                
            case .failure(let error):
                    completion(nil,error)
                break
            }
        })
        
        
    }

//    open func request<T: Codable>(_ target: MultiTarget,
//                                  model: T.Type,
//                                  completed: ((_ returnData: T?,_ error:Error?) -> Void)?) -> Cancellable? {
//        
//    }
}



