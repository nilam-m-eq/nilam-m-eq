//
//  HomeSidePopupVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 24/06/21.
//

import UIKit
import SDWebImage

class HomeSidePopupVC: CommonViewController
{
    @IBOutlet weak var ViewBackPop: UIView!
    @IBOutlet var imgSideMenu: UIImageView!
    var btnSidePopup: UIButton!
    var sideMenuArry = NSDictionary()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        print(sideMenuArry)
        
        imgSideMenu.sd_setImage(with: URL(string: "\(sideMenuArry["server_popup_image"] as! String)"), placeholderImage: UIImage(named: ""))
        /*
         left_popups_latlong = dicHomeData["left_popups_latlong"] as! NSArray
         self.btnSidePopup.isHidden = false
         /*
          "left_popups_latlong" =     {
              "server_popup_Latitude" = "";
              "server_popup_Longitude" = "";
              "server_popup_Radius" = "";
              "server_popup_image" = "https://staging.ma.greenpedia.in/img/popupimages/_eventimage(1)_1638269746.png";
              "server_popup_isAllLocations" = 1;
              "server_popup_text" = "";
              "server_popup_url" = "https://bit.ly/3xkVMYt";
          };
          */
         */
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3)
        { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - UIScreen.main.bounds.height + 99
          //  self?.view.frame = CGRect(x: 20, y: yComponent, width: frame!.width - 40, height: 136)
            self?.view.frame = CGRect(x: 20, y: yComponent, width: frame!.width - 40, height: 50)
        }
    }
    
    // ********** All Button Actions ********** //
    @IBAction func btnSideMenuTapClciked(_ sender: Any)
    {
        if let url = URL(string: sideMenuArry["server_popup_url"] as! String) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func ActionClose(_ sender: UIButton)
    {
        UIView.animate(withDuration: 0.5)
        {
            self.view.frame.origin.x = -self.view.frame.width
            
        } completion:
        { status in
            self.view.removeFromSuperview()
            
            UIView.animate(withDuration: 0.3)
            {
                self.btnSidePopup.isHidden = false
            }
        }
        
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension HomeSidePopupVC {
    
    func setUIOnScreen() {
        
      //  ViewBackPop.layer.cornerRadius = 10.0
       // ViewBackPop.clipsToBounds = true
        
        imgSideMenu.layer.cornerRadius = 10.0
        imgSideMenu.clipsToBounds = true
        
//        ViewBackPop.roundConers(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8.0)
        self.view.alpha = 1.0
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
    }
}


