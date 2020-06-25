//
//  AppDelegate.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 28/08/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift
import FirebaseMessaging
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var sharedData = [String:String]()
    let barButtonAppearance = UIBarButtonItem.appearance()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        // Debug
        IQKeyboardManager.shared.enable = true
        registerForPushNotifications()
        self.authedUser(application: application);
        
        let database = Database.database();
        let dbReference = database.reference()
        
        return true
    }
    
    func authedUser(application: UIApplication) {
        
          if #available(iOS 13.0, *) {
              window?.overrideUserInterfaceStyle = .light
              UNUserNotificationCenter.current().delegate = self
              let authOptions: UNAuthorizationOptions  = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {(isSuccess, error) in
                  if let error = error {
                      print(error.localizedDescription)
                  }
              })
              
          } else {
              let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
          }
          
          application.registerForRemoteNotifications()
          FirebaseApp.configure()
          
          //let myDatabase = Database.database().reference()
          // myDatabase.setValue("We've got data!")
          
          Auth.auth().addStateDidChangeListener {(auth, user) in
              if user != nil && user!.isEmailVerified {
                  let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let nextView : MainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                  self.window?.rootViewController = nextView
              }
          }
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        sharedData["apnsToken"] = token
        print("Registration succeeded! Token: ", token)
        
        InstanceID.instanceID().instanceID(handler: { (result, error) in
            if let error = error {
                print("Error fetching remote instanceID: \(error)")
            } else if let result = result {
                print("InstanceID token: \(result.token)")
            }
        })
        
    }
    
    
    internal func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func updateBadgeCount(){
        var badgeCount = UIApplication.shared.applicationIconBadgeNumber
        if badgeCount > 0 {
            badgeCount = badgeCount - 1
        }
        UIApplication.shared.applicationIconBadgeNumber = badgeCount
    }
    
    //Firebase notification received
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler: @escaping (_ options: UNNotificationPresentationOptions) -> Void) {
        //custom code to handle push while app is in the foreground
        print("Handle push from foreground \(notification.request.content.userInfo)")
        
        //Read message body
        let dict = notification.request.content.userInfo["aps"] as! NSDictionary
        
        var messageBody: String?
        var messageTitle: String  = "Alert"
        
        if let alertDict  = dict["Alert"] as? Dictionary<String, String> {
            messageBody = alertDict["body"]!
            if alertDict["title"] != nil { messageTitle = alertDict["title"]! }
        } else {
            messageBody = dict["alert"] as? String
        }
        
        print("Message body is: \(messageBody!)")
        print("Message title is: \(messageTitle)")
        
        // or display message on iOS device
        //withCompletionHandler([.alert, .badge, .sound])
        self.showAlertAppDelegate(title: messageTitle, message: messageBody!, buttonTitle: "OK", window: self.window!)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration Failed")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // if you set a member variable in didReceiveRemoteNotification, you will know if this is from the background
        print("Handle push from background or closed \(response.notification.request.content.userInfo)")
        updateBadgeCount()
        completionHandler()
    }
    
    // Receive messages
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        //Print message
        print(userInfo)
    }
    
    func showAlertAppDelegate(title: String, message: String, buttonTitle: String, window: UIWindow){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        window.rootViewController?.present(alert, animated: false, completion: nil)
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    // MARK: - Core Data stack

       lazy var persistentContainer: NSPersistentContainer = {
           /*
            The persistent container for the application. This implementation
            creates and returns a container, having loaded the store for the
            application to it. This property is optional since there are legitimate
            error conditions that could cause the creation of the store to fail.
           */
           let container = NSPersistentContainer(name: "Propmapped")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   // Replace this implementation with code to handle the error appropriately.
                   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                   /*
                    Typical reasons for an error here include:
                    * The parent directory does not exist, cannot be created, or disallows writing.
                    * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                    * The device is out of space.
                    * The store could not be migrated to the current model version.
                    Check the error message to determine what the actual problem was.
                    */
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()

       // MARK: - Core Data Saving support

       func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   // Replace this implementation with code to handle the error appropriately.
                   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }

}

