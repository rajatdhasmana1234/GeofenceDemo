//
//  GeoAppDelegate.swift
//  GeofencingDemo
//
//  Created by RAJAT DHASMANA on 07/02/22.
//

import Foundation
import UIKit


class GeoAppDelegate : NSObject , UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = GeoSceneDelegate.self
        return sceneConfig

    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current()
          .requestAuthorization(options: options) { _, error in
            if let error = error {
              print("Error: \(error)")
            }
          }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
      application.applicationIconBadgeNumber = 0
      UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
      UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

}
