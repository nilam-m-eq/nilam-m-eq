//
//  CommonClass.swift
//  Mybyk
//
//  Created by Parth Kapadia on 16/09/21.
//

import UIKit
import Lottie
import SystemConfiguration

class CommonClass: NSObject {
    static var view = UIView()
    static var animationView : AnimationView?
    
    // MARK:- Load Cycling progress
    class func loadProgressHudCycling(viewController: UIViewController)
    {
        
        let window = UIApplication.shared.keyWindow!
      //  let window = UIWindow(frame: UIScreen.main.bounds)
        for view in window.subviews {
            
            if view.tag == 1000000 {
                
                view.removeFromSuperview()
            }
        }
        
        view = UIView(frame: UIApplication.shared.keyWindow!.frame)
     //   view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
        view.tag = 1000000
        
        animationView = .init(name: "cycling")
        animationView!.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
     //   animationView?.backgroundColor = .red
        
        animationView?.center = CGPoint(x: UIApplication.shared.keyWindow!.frame.width / 2, y: UIApplication.shared.keyWindow!.frame.height / 2)
      //  animationView?.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        view.addSubview(animationView!)
        animationView?.play()
        window.addSubview(view)
        
    }
    
    // MARK:- Load Cycling progress
    class func loadConfirmation(viewController: UIViewController) {
        
        let window = UIApplication.shared.keyWindow!
        for view in window.subviews {
            
            if view.tag == 1000000 {
                
                view.removeFromSuperview()
            }
        }
        
        view = UIView(frame: UIApplication.shared.keyWindow!.frame)
        view.backgroundColor = UIColor.white
        //UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
        view.tag = 1000000
        
        animationView = .init(name: "confirmation_tick")
        animationView!.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 0.5
        animationView?.center = CGPoint(x: UIApplication.shared.keyWindow!.frame.width / 2, y: UIApplication.shared.keyWindow!.frame.height / 2)
        view.addSubview(animationView!)
        animationView?.play()
        window.addSubview(view)
        
    }
    
    // MARK:- Remove Cycling progress
    class func removeProgressHudCycling(viewController : UIViewController)
    {
        
        let window =  UIApplication.shared.keyWindow!
        for view in window.subviews {
            
            if view.tag == 1000000 {
                view.removeFromSuperview()
            }
        }
        
    }
    
    
    
    // MARK:- Logout Move to first screen
    class func moveToLogOut(viewController: UIViewController)
    {
        //SidePopup
        UserDefaults.standard.setValue(nil, forKey: "SidePopup")
        UserDefaults.standard.set("", forKey: "deviceToken")
        UserDefaults.standard.setValue(nil, forKey: "authkey")
        UserDefaults.standard.setValue(nil, forKey: "searchHistory")
        UserDefaults.standard.setValue(nil, forKey: "RideStatus")
        UserDefaults.standard.setValue(nil, forKey: "SidePopup")
        UserDefaults.standard.removeObject(forKey: "HomeReload")
        UserDefaults.standard.synchronize()
        
        let signupVC = viewController.storyboard?.instantiateViewController(withIdentifier: "NaviController") as? NaviController
        UIApplication.shared.windows.first?.rootViewController = signupVC
        
    }
    //MARK: - internet connection
    class func isConnectedToNetwork() -> Bool
    {
           var zeroAddress = sockaddr_in()
           zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
           zeroAddress.sin_family = sa_family_t(AF_INET)

           guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                   SCNetworkReachabilityCreateWithAddress(nil, $0)
               }
           }) else {
               return false
           }

           var flags: SCNetworkReachabilityFlags = []
           if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
               return false
           }

           let isReachable = flags.contains(.reachable)
           let needsConnection = flags.contains(.connectionRequired)

           return (isReachable && !needsConnection)
       }
    
    
    
}





