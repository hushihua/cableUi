//
//  AppDelegate.swift
//  Demo
//
//  Created by adam on 2020/8/10.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iPush
import iChat
import cableUi

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IMuiApi.getInstance().DEBUG = 2                                                      //true:连接测试服务
        IMuiApi.getInstance().initSdk()
        PushApi.getInstance().registerNotification(application: application, delegate: self)    //审请获取 deviceToken
        PushApi.getInstance().registerUID { (response:PHResponse<String>) in                    //生成register_id
            print("*** [SDK] \(response.data ?? "")")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushApi.getInstance().pushToken(data:deviceToken) { (response:PHResponse<Bool>) in
        }
    }
    
    @available(iOS 10.0, *)
    //程序处于前台【收到】推送消息，设置提示模式 不存在content-available字段时候 调用
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        PushApi.getInstance().userNotificationCenter(center, willPresent:notification, completionHandler:completionHandler)
        completionHandler([.alert, .sound])
    }
    
    @available(iOS 10.0, *)
    //【点击】收到的apns消息推送
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        PushApi.getInstance().userNotificationCenter(center, didReceive:response)
        completionHandler()
    }
    
    //app在收到带content-available字段的时候 回调调用 (静默推送)
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushApi.getInstance().application(application, didReceiveRemoteNotification:userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

