//
//  SceneDelegate.swift
//  Mybyk
//
//  Created by Gaurav on 18/05/21.
//

import UIKit
import Lottie
import SystemConfiguration

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var view: UIView?
    var animationView : AnimationView?
    var navigationController: UINavigationController = UINavigationController()
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
       // window = UIWindow(frame: UIScreen.main.bounds)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
      /*  if UserDefaults.standard.value(forKey: "authkey")  != nil {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
            window?.rootViewController = homeVC
            window?.makeKeyAndVisible()
        }
        else {
            
            print("Login Fail")
        }
        */
        if UserDefaults.standard.value(forKey: "RideStatus") != nil
        {
           /* print("sdsdsD")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
            self.window?.rootViewController = homeVC
            self.window?.makeKeyAndVisible()*/
           // self.goLoginViewController()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
            
            navigationController = UINavigationController(rootViewController: homeVC)
            navigationController.navigationBar.isHidden = true
            self.changeRootViewController(navigationController)
            
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
//            self.window?.rootViewController = homeVC
//            self.window?.makeKeyAndVisible()
           /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "OngoingRideDetails")
            let navigationController = UINavigationController(rootViewController: homeVC)
            self.window!.rootViewController = navigationController
                self.window!.makeKeyAndVisible()*/
            
           // self.window!.makeKeyAndVisible()
            
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
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    @available(iOS 13.0, *)
    func goLoginViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainNavController = storyboard.instantiateViewController(identifier: "OngoingRideDetails")
                changeRootViewController(mainNavController)
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
    //MARK: - Ride Ongoing/Completed
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
                    if #available(iOS 13.0, *) {
                        self.goLoginViewController()
                    } else {
                        // Fallback on earlier versions
                    }
                  /*  self.window = UIWindow(frame: UIScreen.main.bounds)
                   let nav1 = UINavigationController()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                   nav1.viewControllers = [vc]
                   self.window!.rootViewController = nav1
                   self.window?.makeKeyAndVisible()*/
                    
                  /*  let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
                    self.window?.rootViewController = homeVC
                    self.window?.makeKeyAndVisible()*/
                    
                  /*  let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                    ongoing.isHome = true
                    self.navigationController?.pushViewController(ongoing, animated: true)*/
//
//                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
//                    loginPageView.isHome = true
//                    let rootViewController = self.window!.rootViewController as! UINavigationController
//                    rootViewController.pushViewController(loginPageView, animated: true)
                    
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
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene)
    {
        UIApplication.shared.applicationIconBadgeNumber = 0
//        if UserDefaults.standard.value(forKey: "RideStatus") != nil
//        {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
//            self.window?.rootViewController = homeVC
//            self.window?.makeKeyAndVisible()
//
//        }
//        else
//        {
//            if UserDefaults.standard.value(forKey: "authkey")  != nil
//                    {
//
//                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                        let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
//                        self.window?.rootViewController = homeVC
//                        self.window?.makeKeyAndVisible()
//                    }
//                    else{
//                       // self.GetRide()
//                    }
//        }
//        self.GetRide()
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene)
    {
//        if UserDefaults.standard.value(forKey: "RideStatus") != nil
//        {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
//            self.window?.rootViewController = homeVC
//            self.window?.makeKeyAndVisible()
//
//        }
//        else
//        {
//            if UserDefaults.standard.value(forKey: "authkey")  != nil
//                    {
//
//                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                        let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
//                        self.window?.rootViewController = homeVC
//                        self.window?.makeKeyAndVisible()
//                    }
//                    else{
//                       // self.GetRide()
//                    }
//        }
//        self.GetRide()
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene)
    {
//        if UserDefaults.standard.value(forKey: "RideStatus") != nil
//        {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC = storyBoard.instantiateViewController(withIdentifier: "OngoingRideDetails")
//            self.window?.rootViewController = homeVC
//            self.window?.makeKeyAndVisible()
//            
//        }
//        else
//        {
//            if UserDefaults.standard.value(forKey: "authkey")  != nil
//                    {
//                        
//                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                        let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
//                        self.window?.rootViewController = homeVC
//                        self.window?.makeKeyAndVisible()
//                    }
//                    else{
//                       // self.GetRide()
//                    }
//        }
//        self.GetRide()
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene)
    {
//        self.GetRide()
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

