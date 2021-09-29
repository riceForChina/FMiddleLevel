//
//  FRouter.swift
//  FMiddleLevel
//
//  Created by FanQiLe on 2021/7/2.
//

import UIKit

public class FRouter: NSObject {
    public static let manager:FRouter = FRouter()
    fileprivate var moduleDic:[String:RouterBlock] = [:]
    
    public typealias RouterBlock = (([String:Any]) -> ())
    public func register(name:String,block:RouterBlock?) {
        moduleDic[name] = block
    }
    
    static public func openActionUrl(url:String){
        let tempDic = url.stringToDic()
        let name = tempDic?["name"] as? String ?? ""
        if name.count <= 0 {
            return
        }
        if FRouter.manager.moduleDic.count > 0 {
       
            _ = synchronized(self) { () -> Any? in
                if let block: RouterBlock = FRouter.manager.moduleDic[name] {
                    let extra = tempDic?["extra"] as? [String:Any]
                    block(extra ?? [:])
                } else {
                    let defaultUrl = tempDic?["defaultUrl"] as? String ?? ""
                    //跳转WebView
                }
                return nil
            }
        } else {
            FRegisterHandler.readDataFromMachO { (list) in
                
                for item in list ?? []{
                    if let className = item as? String,
                       let classType = NSClassFromString(className) as? NSObject.Type{
                            let obj = classType.init()
                        if let temp = obj as? FRouterProtocol {
                            temp.registerRouter()
                        }
                    }
                }
                FRouter.openActionUrl(url: url)
            }
        }
    }
    
    private static func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
        objc_sync_enter(lock)
        defer { objc_sync_exit(lock) }
        return try body()
    }
}

public extension String {
    // MARK: 字符串转字典
    func stringToDic() -> [String : Any]?{
        guard let data = self.data(using: String.Encoding.utf8),
        let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] else {
            return nil
        }
        return dict
    }
}
