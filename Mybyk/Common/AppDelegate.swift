//
//  AppDelegate.swift
//  Mybyk
//
//  Created by Gaurav on 18/05/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import Lottie
import SystemConfiguration
//import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseMessaging
import FirebaseStorage
import FirebaseFirestore
import FirebaseCrashlytics
import UserNotifications
import Firebase

//import PayUCheckoutProKit
//import PayUCheckoutProBaseKit
//import PayUParamsKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
   
    
    var view: UIView?
    var animationView : AnimationView?
    var navigationController: UINavigationController = UINavigationController()
    
    var versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    var ridelocationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
       // window = UIWindow(frame: UIScreen.main.bounds)
        
        
        //Thread.sleep(forTimeInterval: 1)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        GMSServices.provideAPIKey("AIzaSyAdlQlD4RdlMkMEisCv4GZ2tdJ4zfp1Dd8")
        
        IQKeyboardManager.shared.enable = true
        
       // let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
         //   pushManager.registerForPushNotifications()
        FirebaseApp.configure()
        
        if CLLocationManager.locationServicesEnabled() {
            
            ridelocationManager.delegate = self
            ridelocationManager.requestAlwaysAuthorization()
            ridelocationManager.desiredAccuracy = kCLLocationAccuracyBest
            if #available(iOS 9.0, *) {
                ridelocationManager.allowsBackgroundLocationUpdates = false
            }
            ridelocationManager.startUpdatingLocation()
            
        }
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    //    Messaging.messaging().delegate = self
        
        center.requestAuthorization(options: [UNAuthorizationOptions.alert, UNAuthorizationOptions.badge, UNAuthorizationOptions.sound]) { granted, error in
            if error == nil {
                DispatchQueue.main.async {
                    
                    UIApplication.shared.registerForRemoteNotifications()
                //    self.updateFirestorePushTokenIfNeeded()
                }
            }
        }
        
        if UserDefaults.standard.value(forKey: "RideStatus") != nil
        {
            /*let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
            self.window?.rootViewController = homeVC
            self.window?.makeKeyAndVisible()*/
           // self.goLoginViewController()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
            
            navigationController = UINavigationController(rootViewController: homeVC)
            navigationController.navigationBar.isHidden = true
            self.changeRootViewController(navigationController)
            //self.window!.rootViewController = navigationController
              //  self.window!.makeKeyAndVisible()
            
           /* let viewController = OngoingRideDetails()
                let navViewController = UINavigationController(rootViewController: viewController)
                window?.rootViewController = navViewController*/
            
            //self.window!.makeKeyAndVisible()
            
        }
        else
        {
            if UserDefaults.standard.value(forKey: "authkey")  != nil
                    {
                        
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
                        self.window?.rootViewController = homeVC
                        self.window?.makeKeyAndVisible()
                    }
                    else{
                       // self.GetRide()
                    }
        }
        
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
        
        print("APPLICATION")
        
        /*
         UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
         UserDefaults.standard.synchronize()
         */
      
     
        
       /* if UIApplication.shared.applicationState == .active
        {
//            NotificationCenter.default
//                .post(name:NSNotification.Name("CheckOngoingRide"),
//                      object: nil,
//                      userInfo: nil)
            self.GetRide()
                
        }
        if UIApplication.shared.applicationState == .background
        {
//            NotificationCenter.default
//                .post(name:NSNotification.Name("CheckOngoingRide"),
//                      object: nil,
//                      userInfo: nil)
            self.GetRide()
        }
        if UIApplication.shared.applicationState == .inactive
        {
//            NotificationCenter.default
//                .post(name:NSNotification.Name("CheckOngoingRide"),
//                      object: nil,
//                      userInfo: nil)
            self.GetRide()
        }*/
       
        
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        application.applicationIconBadgeNumber = 0
       // self.GetRide()
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
       // self.GetRide()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        //self.GetRide()
    }
    func applicationWillTerminate(_ application: UIApplication) {
       
        print("TERMINATE APPDELEGATE")
    }
    //MARK: - Ride Ongoing/Completed
    func goLoginViewController()
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        changeRootViewController(loginPageView)
       
               
    }
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = vc
        if(animated) {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft],
                              animations: nil,
                              completion: nil)
        }
    }
     func GetRide() -> Void
    {
        //print(notification.name)
       // CommonClass.loadProgressHudCycling(viewController: self)
         window = UIWindow(frame: UIScreen.main.bounds)
        //UIApplication.shared.keyWindow!
        for view in window!.subviews {
            
            if view.tag == 1000000 {
                
                view.removeFromSuperview()
            }
        }
        
        view = UIView(frame: UIScreen.main.bounds)
        view!.backgroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
        view!.tag = 1000000
        
        animationView = .init(name: "cycling")
        animationView!.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        animationView?.center = CGPoint(x:UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        view!.addSubview(animationView!)
        animationView?.play()
        window!.addSubview(view!)
        
        APIService.sharedInstance.getCurrentRideAPICall(dictionary: ["action": "currentRide"]) { response in
        //  CommonClass.removeProgressHudCycling(viewController: self)
           
            for view in self.window!.subviews {
                
                if view.tag == 1000000 {
                    view.removeFromSuperview()
                }
            }
            print(response)
            
            //  "ride_status" = Ongoing;
            if response["is_error"] as! String == "false"
            {
                
                let dicCurrentData = response["data"] as! [String: Any]
                if dicCurrentData["ride_status"] as! String == "Ongoing"
                {
                    print("ONGOING")
                    
                     /*   self.window = UIWindow(frame: UIScreen.main.bounds)
                       let nav1 = UINavigationController()
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                       nav1.pushViewController(vc, animated: true)
                       self.window!.rootViewController = nav1
                       self.window?.makeKeyAndVisible()*/
                    
                    
                   // guard let winScene = (scene as? UIWindowScene) else { return }
                      // window = UIWindow(windowScene: winScene)
                   /* self.window?.rootViewController = OngoingRideDetails()
                    self.window?.makeKeyAndVisible()*/
                    
                 /*   let outgoing = OngoingRideDetails()
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    self.navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                    self.navigationController.viewControllers = [outgoing]
                    self.window?.rootViewController = self.navigationController*/
                    
                  /*  let story = UIStoryboard(name: "Main", bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()*/
                    
                  //  self.window?.makeKeyAndVisible()
                    
                    
                   // self.goLoginViewController()
//                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                    let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
//                    self.window?.rootViewController = homeVC
//                    self.window?.makeKeyAndVisible()
                    
                  /*  let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                    ongoing.isHome = true
                    self.navigationController?.pushViewController(ongoing, animated: true)*/

                 /*   let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                    loginPageView.isHome = true
                    self.window?.rootViewController = loginPageView
                    self.window?.makeKeyAndVisible()*/
                    
                   
                   /* let navigationController = self.window?.rootViewController as! UINavigationController
                    print(navigationController.viewControllers)
                    print(navigationController.topViewController!)
                    print(navigationController.visibleViewController!)
                    let firstVC = navigationController.viewControllers[0] as! OngoingRideDetails*/
                    
                   // let rootViewController = self.window!.rootViewController as! UINavigationController
                   // rootViewController.pushViewController(loginPageView, animated: true)
                    
//                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                   // let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
//                    if let navController = self.navigationController, let viewController = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as? OngoingRideDetails{
//                        navController.pushViewController(viewController, animated: true)
//                    }
                    
                   
                }
                else
                {
                    if UserDefaults.standard.value(forKey: "authkey")  != nil
                    {
                        
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
                        self.window?.rootViewController = homeVC
                        self.window?.makeKeyAndVisible()
                    }
                    else {
                        
                        print("Login Fail")
                    }
                    print("Completed")
                }
            }
            else
            {
                
                if response["error_code"] as! String == "404" {
                    
                  //  self.RemoveAnimtion()
                }
                else {
                    
                 //   let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                 //   toast.show()
                }
                
            }
            
        } blockError: { error in
         //   CommonClass.removeProgressHudCycling(viewController: self)
          //  self.RemoveAnimtion()
        }
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
    
    func startLocationUpdates() {
        
        ridelocationManager.delegate = self
        ridelocationManager.activityType = .fitness
        ridelocationManager.distanceFilter = 5
        ridelocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        ridelocationManager.allowsBackgroundLocationUpdates = true
        ridelocationManager.pausesLocationUpdatesAutomatically = false
        if #available(iOS 11.0, *) {
            ridelocationManager.showsBackgroundLocationIndicator = false
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
}


// MARK:- Push Notification Delegate Methods
extension AppDelegate: UNUserNotificationCenterDelegate
{
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingDelegate)
//    {
//        print(remoteMessage)
//    }
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print(messaging.fcmToken!)
//        UserDefaults.standard.set(messaging.fcmToken!, forKey: "deviceToken")
//        UserDefaults.standard.synchronize()
//        //  updateFirestorePushTokenIfNeeded()
//      }
//    func updateFirestorePushTokenIfNeeded()
//    {
////           if let token = Messaging.messaging().fcmToken {
////
////               print(token)
////               let usersRef = Firestore.firestore().collection("users_table").document("")
////               usersRef.setData(["fcmToken": token], merge: true)
////           }
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        print("User Info === \(notification.request.content.userInfo)")
        // Handle code here.
        
        print("willPresent called")
        NotificationCenter.default.post(name: Notification.Name("increaseNotificationCountNotification"), object: nil, userInfo: nil)
        
        completionHandler([UNNotificationPresentationOptions.sound, UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info === \(response.notification.request.content.userInfo)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("deviceToken: \(tokenString)")
        if tokenString != "" {
            UserDefaults.standard.set(tokenString, forKey: "deviceToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification called",userInfo)
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
        UserDefaults.standard.set("", forKey: "deviceToken")
        UserDefaults.standard.synchronize()
    }
    
    
}

// MARK:- Location Manager Delegate Methods
extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            ridelocationManager.startUpdatingLocation()
        }
        else if status == .denied {
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        ridelocationManager.stopUpdatingLocation()
    }
    
    
}

