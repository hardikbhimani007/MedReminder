//
//  AppDelegate.swift
//  Medreminder
//
//  Created by MacOS on 27/07/2023.
//

import UIKit
import UserNotifications
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var appNavigation: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        let defults = UserDefaults.standard
        if let selectedLanguge = defults.string(forKey: "AppleLanguage") {
            Bundle.setLanguage(selectedLanguge)
        } else {
            Bundle.setLanguage("en")
        }
        setUpAppNavigation()
        getPermission(application: application)
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification = \(response.notification.request.content.userInfo)")
        let name = response.notification.request.content.userInfo["MedName"] as? String
        let type = response.notification.request.content.userInfo["MedType"] as? String
        let dose = response.notification.request.content.userInfo["FirstDose"] as? String
        let hr = response.notification.request.content.userInfo["hr"] as? Int
        let min = response.notification.request.content.userInfo["Min"] as? Int
        let sec = response.notification.request.content.userInfo["Sec"] as? Int
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        if let takeVC = storyBoard.instantiateViewController(withIdentifier: "TakeMedicineVC") as? TakeMedicineVC {
            takeVC.medName = name ?? ""
            takeVC.medType = type ?? ""
            takeVC.firstDose = dose ?? ""
            takeVC.hr = hr ?? 0
            takeVC.min = min ?? 0
            takeVC.sec = sec ?? 0
            APP_DELEGATE.window?.rootViewController = takeVC
        }
        completionHandler()
    }
    
    func getPermission(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
                print("User gave permissions for local notifications.")
            }
        }
    }
    
    func setUpAppNavigation() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        APP_DELEGATE.appNavigation = UINavigationController(rootViewController: nextViewController) // set RootViewController
        APP_DELEGATE.appNavigation?.isNavigationBarHidden = false
        APP_DELEGATE.window?.makeKeyAndVisible()
        APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
    }
}

