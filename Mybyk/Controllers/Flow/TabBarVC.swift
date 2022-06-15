//
//  TabBarVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 24/06/21.
//

import UIKit

protocol CustomTabBarControllerDelegate {
    func onTabSelected(isTheSame: Bool)
}

class TabBarVC: UITabBarController, UITabBarControllerDelegate
{
    var delegateTabbar : CustomTabBarControllerDelegate? = nil
  //  var didTap: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.tabBarController?.delegate = self
      //  delegate = self
        self.delegate = self
        
    }
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
//    {
//           (viewController as? CustomTabBarControllerDelegate)?.onTabSelected(isTheSame: selectedViewController == viewController)
//        //    didTap!()
//           return true
//    }
         func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
         print(selectedIndex!)
        
        if selectedIndex == 0
        {
            //ValueRequest
//            if UserDefaults.standard.value(forKey: "ValueRequest") != nil
//            {
//                UserDefaults.standard.removeObject(forKey: "ValueRequest")
//                UserDefaults.standard.synchronize()
//            }

            UserDefaults.standard.setValue("ReloadData", forKey: "HomeReload")
            UserDefaults.standard.synchronize()
            
            NotificationCenter.default
                .post(name:NSNotification.Name("ReloadHome"),
                      object: nil,
                      userInfo: nil)
        }
        else if selectedIndex == 1
        {
//            if UserDefaults.standard.value(forKey: "ValueRequest") != nil
//            {
//                UserDefaults.standard.removeObject(forKey: "ValueRequest")
//                UserDefaults.standard.synchronize()
//            }
            UserDefaults.standard.setValue("ReloadData", forKey: "HomeReload")
            UserDefaults.standard.synchronize()
            
            NotificationCenter.default
                .post(name:NSNotification.Name("ReloadMyRideVc"),
                      object: nil,
                      userInfo: nil)
        }
        else if selectedIndex == 2
        {
//            if UserDefaults.standard.value(forKey: "ValueRequest") != nil
//            {
//                UserDefaults.standard.removeObject(forKey: "ValueRequest")
//                UserDefaults.standard.synchronize()
//            }
            UserDefaults.standard.setValue("ReloadData", forKey: "HomeReload")
            UserDefaults.standard.synchronize()
            
            NotificationCenter.default
                .post(name:NSNotification.Name("ReloadMyWalletVc"),
                      object: nil,
                      userInfo: nil)
        }
        else if selectedIndex == 3
        {
//            if UserDefaults.standard.value(forKey: "ValueRequest") != nil
//            {
//                UserDefaults.standard.removeObject(forKey: "ValueRequest")
//                UserDefaults.standard.synchronize()
//            }
            UserDefaults.standard.setValue("ReloadData", forKey: "HomeReload")
            UserDefaults.standard.synchronize()
            
            NotificationCenter.default
                .post(name:NSNotification.Name("ReloadNotification"),
                      object: nil,
                      userInfo: nil)
        }
        else if selectedIndex == 4
        {
//            if UserDefaults.standard.value(forKey: "ValueRequest") != nil
//            {
//                UserDefaults.standard.removeObject(forKey: "ValueRequest")
//                UserDefaults.standard.synchronize()
//            }
//
            UserDefaults.standard.setValue("ReloadData", forKey: "HomeReload")
            UserDefaults.standard.synchronize()
            
            NotificationCenter.default
                .post(name:NSNotification.Name("ReloadMyMenu"),
                      object: nil,
                      userInfo: nil)
        }
    }
    
}
