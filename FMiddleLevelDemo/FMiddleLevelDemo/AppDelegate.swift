//
//  AppDelegate.swift
//  FMiddleLevelDemo
//
//  Created by FanQiLe on 2021/7/2.
//

import UIKit
import FMiddleLevel

/**
 
 1，路由层不需要修改modukit协议，只有模块之间跳转才需要
 
 1，url-vc,可以避免load注册，，缺点只能弹出Vc
 2，url-block,必须load注册
 3，url-block,+attribute懒加载注册方案
 */
//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FRouter.openActionUrl(url: "{\"name\":\"goHome\",\"response\":\"response\",\"extra\":{\"orderId\":\"123\"}}")
        FRouter.openActionUrl(url: "{\"name\":\"goHome\",\"response\":\"response\",\"extra\":{\"orderId\":\"123\"}}")
        ModuleManager.getHomePageModule()?.goHomeVc()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

