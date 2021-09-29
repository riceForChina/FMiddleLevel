//
//  KCHomePageProtocol.swift
//  KCHomePageModule
//
//  Created by 范其乐 on 2018/12/11.
//

import Foundation

public extension ModuleManager{
    static func getHomePageModule() -> KCHomePageProtocol?{
        let keyName = String(describing: KCHomePageProtocol.self)
        return ModuleManager.get(key: keyName) as? KCHomePageProtocol
    }
}

public protocol KCHomePageProtocol:ModuleProtocol{
    
    func goHomeVc()

}

