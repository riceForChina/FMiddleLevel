//
//  KCHomePageImplement.swift
//  KCHomePageModule
//
//  Created by 范其乐 on 2018/11/2.
//  Copyright © 2018年 范其乐. All rights reserved.
//

import UIKit
import FMiddleLevel

class KCHomeVc: UIViewController {
    
}
public class KCHomePageImplement: NSObject, KCHomePageProtocol,FRouterProtocol {
    public func registerRouter() {
        print("registerRouter")
        FRouter.manager.register(name: "goHome") { (params) in
            print("goHome ---- \(params)")
            let vc = KCHomeVc()
            ModuleManager.topViewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    public func goHomeVc() {
        print("goHome")
    }
}

extension FRouter {
    @objc func newRegister() {
        print("home - text")
    }
}

