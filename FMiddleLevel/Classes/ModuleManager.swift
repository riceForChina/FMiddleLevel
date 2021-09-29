//  FMiddleLevelManager.swift
//  FMiddleLevel
//
//  Created by FanQiLe on 2021/7/2.
//

import Foundation
let ModuleKit_ProtocolSuffix = "Protocol"
let ModuleKit_ModuleSuffix = "Module"
let ModuleKit_ImplementSuffix = "Implement"

@objc public class ModuleManager: NSObject {
    public static let shared = ModuleManager()
    
    
    /// 默认map规范：
    /// key: 协议名，在ModuleKit中定义一个模块的协议。eg -> XXXProtocol
    /// value: 实现名，在XXXModule模块中对XXXModule协议的实现。eg -> XXXModule.XXXImplement
    var map: Dictionary = Dictionary<String, Any>()
    
    private override init() {
    }
    
    
    //MARK: internal
    
    /// Objc使用
    ///
    /// - Parameter key: 协议名。ModuleName的静态变量
    /// - Returns: 协议实现。
    static func get(key:String) -> Any?{
        return synchronized(self, { () -> Any? in
            if getObj(by: key) == nil {
                let protocolName = key
                let xxx = protocolName.replacingOccurrences(of: ModuleKit_ProtocolSuffix, with: "")
                let moduleName = xxx + ModuleKit_ModuleSuffix
                let implementClassName = xxx + ModuleKit_ImplementSuffix
                let implamentFullName = moduleName + "." + implementClassName
                register(classFullName: implamentFullName, forKey: key)
            }
            if let obj = getObj(by: key) {
                return obj
            }
            
            debugPrint("Not Register module of \(key)")
            return nil
        })
    }
    
    private static func getObj(by Key:String) -> Any? {
        return shared.map[Key]
    }
    
    public static func register(obj: Any, forKey key: String) {
        shared.map[key] = obj
        debugPrint("Register module of \(key)")
    }
    
    public static func register(classFullName:String, forProtocol moduleProtocol:ModuleProtocol.Type){
        let key = String(describing: type(of: moduleProtocol).self)
        register(classFullName: classFullName, forKey: key)
    }
    
    public static func register(classFullName:String, forKey key:String){
        let classType = NSClassFromString(classFullName) as? NSObject.Type
        if let type = classType {
            let obj = type.init()
            register(obj: obj, forKey: key)
        }
    }
    
    public static func register(obj: Any, forProtocol moduleProtocol:ModuleProtocol.Type) {
        let key = String(describing: moduleProtocol.self)
        register(obj: obj, forKey: key)
    }
    
    static func registerAll(serviceMap: Dictionary<String, String>) {
        for (key, classFullName) in serviceMap {
            register(classFullName: classFullName, forKey: key)
        }
    }
    
    //MARK: utils
    @objc public static var tabbarTopVC: UIViewController? {
        guard let tabVC = UIApplication.shared.delegate?.window??.rootViewController as? UITabBarController,
            (tabVC.viewControllers?.count ?? 0) > tabVC.selectedIndex else {
                return nil
        }
        
        let vc = (tabVC.viewControllers?[tabVC.selectedIndex] as? UINavigationController)?.topViewController
        return vc
    }
    @objc public static var topViewController: UIViewController? {
        var resultVC = getTopVC(UIApplication.shared.delegate?.window??.rootViewController)
        while let presentedVC = resultVC?.presentedViewController {
            resultVC = getTopVC(presentedVC)
        }
        return resultVC
    }
    
    private static func getTopVC(_ vc: UIViewController?) -> UIViewController? {
        if let navc = vc as? UINavigationController {
            return getTopVC(navc.topViewController)
        } else if let tabvc = vc as? UITabBarController {
            return getTopVC(tabvc.selectedViewController)
        } else {
            return vc
        }
    }
    
    private static func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
        objc_sync_enter(lock)
        defer { objc_sync_exit(lock) }
        return try body()
    }
    
}

public protocol ModuleProtocol{
}


