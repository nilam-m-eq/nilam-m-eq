//
//  MenuVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit
import Toaster
import SDWebImage

class MenuVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var tblViewMenu: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgViewProPic: UIImageView!
    @IBOutlet var viewFooter: UIView!
    
    @IBOutlet var lbVersion: UILabel!
    
   // @IBOutlet var lbCalories: UILabel!
  //  @IBOutlet var lbCarbon: UILabel!
  //  @IBOutlet var lbKms: UILabel!
  //  @IBOutlet var lbPosition: UILabel!
    let menuViewModel = MenuViewModel()
    let menuModel = MenuModel()
    
    @IBOutlet var viewTableHeader: UIView!
    
    var dicStore = [String : Any]()
    var StrVersion = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // tblViewMenu.tableFooterView = UIView()
      //  self.hideTableViewLastSeparator()
        tblViewMenu.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tblViewMenu.frame.size.width, height: 1))
        tblViewMenu.tableHeaderView = viewTableHeader
        
       let buildNumberString =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        as! String
        StrVersion = String(format: "Version %@", buildNumberString)
        //Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
        //    as! String
    //    lbVersion.text = String(format: "Version %@", buildNumberString)
        
        /*
        
                 let buildNumber = Bundle.main.infoDictionary?[IdentifierConstants.InfoPlist.buildNumber] as? String
         */
        
     //   self.tabBarController?.tabBar.isHidden = false
        
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(ReloadMyMenu(_:)),
                         name: NSNotification.Name("ReloadMyMenu"),object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        menuModel.dataArr.removeAll()
        self.setUIOnScreen()
    }
    @objc func ReloadMyMenu(_ notification: Notification)
    {
        self.viewDidLoad()
        self.viewWillAppear(true)
      //  self.view.layoutIfNeeded()
    }
    // ********** All Button Actions ********** //
    @IBAction func ActionEdit(_ sender: UIButton)
    {
        
       /* let profile = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
        profile.dicProfileData = dicStore
        self.navigationController?.pushViewController(profile, animated: true)*/
        
        let profile = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileEditVC") as! MyProfileEditVC
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension MenuVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        imgViewProPic.layer.cornerRadius = imgViewProPic.frame.size.width / 2
        
        self.getMenuListAPICall()
        
     /*
      let buildNumberString =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
       as! String
       //Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
       //    as! String
       lbVersion.text = String(format: "Version %@", buildNumberString)
      */
       
        tblViewMenu.delegate = menuViewModel
        tblViewMenu.dataSource = menuViewModel
       // tblViewMenu.tableFooterView = viewFooter
        lbVersion.text = StrVersion
        menuViewModel.sectionCount = 1
        weak var weakSelf = self
        
        menuViewModel.cellRender = { indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuTblCell
            
        //   count = 7
            
            cell.lblName.text = weakSelf?.menuModel.dataArr[indexPath.row].strMenuTitle
            if indexPath.row == (weakSelf?.menuModel.dataArr.count)! - 1
            {
                cell.lblName.textColor = UIColor(named: Color_N_Dark200)
            }
            else
            {
                cell.lblName.textColor = UIColor(named: Color_N_Dark900)
            }
           /* if indexPath.row == (weakSelf?.menuModel.dataArr.count)! - 1
            {
               // let buildNumberString =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                cell.lblName.textColor = UIColor(named: Color_N_Dark200)
                cell.imgForwardArrow.isHidden = true
              //  cell.lblName.text = self.StrVersion
                cell.lblName.font = UIFont(name: "Rubik Regular", size: 12.0)
               // self.tblViewMenu.separatorStyle = .none
                //Rubik Regular 16.0
                //String(format: "Version %@", buildNumberString)
            }*/
            
            cell.selectionStyle = .none
            return cell
        }
        
        menuViewModel.cellSelect = { indexPath, tableView in
            
//            if indexPath.row == 0 {
//
//                let subscription = self.storyboard?.instantiateViewController(withIdentifier: "MySubscriptionVC") as! MySubscriptionVC
//                self.navigationController?.pushViewController(subscription, animated: true)
//
//            }
            print(indexPath.row)
            if indexPath.row == 0 {
                
                let requestHub = self.storyboard?.instantiateViewController(withIdentifier: "RequestHUBPinVC") as! RequestHUBPinVC
                requestHub.fromDic = self.dicStore
                requestHub.strCheckForCurrentLocation = "Menu"
                //fromDic
                UserDefaults.standard.removeObject(forKey: "ValueRequest")
                UserDefaults.standard.synchronize()
                
                self.navigationController?.pushViewController(requestHub, animated: true)
                
            }
            else if indexPath.row == 1 {
                
                let event = self.storyboard?.instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
                self.navigationController?.pushViewController(event, animated: true)
                
            }
            else if indexPath.row == 2 {
                
                let help = self.storyboard?.instantiateViewController(withIdentifier: "HelpAnfFaqVC") as! HelpAnfFaqVC
                self.navigationController?.pushViewController(help, animated: true)
                
            }
            else if indexPath.row == 3 {
                
                let help = self.storyboard?.instantiateViewController(withIdentifier: "ReferFriendMenuVC") as! ReferFriendMenuVC
                self.navigationController?.pushViewController(help, animated: true)
            }
            else if indexPath.row == 4 {
                
                let help = self.storyboard?.instantiateViewController(withIdentifier: "AboutMyBykVC") as! AboutMyBykVC
                self.navigationController?.pushViewController(help, animated: true)
                
            }
            else if indexPath.row == 5 {
                
             //   self.hideTableViewLastSeparator()
                
                CommonClass.moveToLogOut(viewController: self)
            }
            else if indexPath.row == 6 {
                
                //self.hideTableViewLastSeparator()
               // CommonClass.moveToLogOut(viewController: self)
            }
            
        }
        
        menuModel.getMenuData { status, success in
            weakSelf?.menuViewModel.rawCount = (weakSelf?.menuModel.dataArr.count)!
            weakSelf?.tblViewMenu.reloadData()
        }
        
    }
    func hideTableViewLastSeparator() {
        let footerView = UIView()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
      
        tblViewMenu.tableFooterView = footerView
    }
    func setMenuData(dicMenu: [String: Any]) {
        
       // print(dicMenu)
        self.lblName.text = "\(dicMenu["first_name"] as? String ?? "") \(dicMenu["last_name"] as? String ?? "")"
     //   lbKms.text = dicMenu["total_ride_distance"] as? String ?? ""
      //  lbCalories.text = dicMenu["total_calories"] as? String ?? ""
        
        if dicMenu["profile_image"] as! String == ""
        {
            let lblNameInitialize = UILabel()
            lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
            lblNameInitialize.textColor = UIColor.white
            lblNameInitialize.text = String((dicMenu["first_name"] as! String).first!) + String((dicMenu["last_name"] as! String).first!)
            lblNameInitialize.textAlignment = NSTextAlignment.center
            lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
            lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
            UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
            lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
            self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        else
        {
            let strImg = dicMenu["profile_image"] as? String
            self.imgViewProPic.sd_setImage(with: URL(string: strImg!), placeholderImage: UIImage(named: ""))
        }
        
      /*  if let strImg = dicMenu["profile_image"] as? String {
            
            self.imgViewProPic.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: ""))
        }
        else {
            
            let lblNameInitialize = UILabel()
            lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
            lblNameInitialize.textColor = UIColor.white
            lblNameInitialize.text = String((dicMenu["first_name"] as! String).first!) + String((dicMenu["last_name"] as! String).first!)
            lblNameInitialize.textAlignment = NSTextAlignment.center
            lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
            lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
            UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
            lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
            self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext() */
            
           /* if dicMenu["first_name"] as? String == "Logout"
            {
                lblNameInitialize.backgroundColor = UIColor(named: Color_N_Dark200)
            }
            else
            {
                lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
            }*/
           
        }
        
    }
    

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension MenuVC {
    
    func getMenuListAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getMenuListAPICall(dictionary: ["action": "getMenuList"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicMenuData = response["data"] as! [String: Any]
                dicStore = dicMenuData
                self.setMenuData(dicMenu: dicMenuData)
                
            }
            else {
                
                if response["error_code"] as! String == "404" {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else {
                    
                    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
}





