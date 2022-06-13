//
//  OngoingRideDetails.swift
//  Mybyk
//
//  Created by Parth Kapadia on 28/06/21.
//

import UIKit
import Toaster
import SwiftyGif
import OmniBaseTool
import OmniBikeLock
import CoreLocation
import Lottie

class OngoingRideDetails: CommonViewController,CBCentralManagerDelegate {
   
    @IBOutlet var viewUnlockSuccessAnim: AnimationView!
    @IBOutlet var viewUnlockSuccess: UIView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var manager:CBCentralManager!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackEndride: UIView!
    @IBOutlet weak var viewBackBikeDetail: UIView!
    @IBOutlet weak var viewBackLocateMyBikeIcon: UIView!
    @IBOutlet weak var consViewLocationMyBikeH: NSLayoutConstraint!
    
    @IBOutlet weak var viewBackNeedHelpIcon: UIView!
    @IBOutlet weak var consViewNeedHelpH: NSLayoutConstraint!
    @IBOutlet weak var viewBackFindNearestIcon: UIView!
    @IBOutlet weak var consViewFindNearestH: NSLayoutConstraint!
    
    @IBOutlet var lbLockNumber: UILabel!
    @IBOutlet weak var btnEndRide: UIButton!
    @IBOutlet weak var viewBackDetails: UIView!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var lblLockNumber: UILabel!
    @IBOutlet var lblBikeNumber: UILabel!
    @IBOutlet var lblBikeType: UILabel!
    @IBOutlet var lblRideID: UILabel!
    @IBOutlet var imgViewCycleCategory: UIImageView!
    @IBOutlet var lblBikeBattery: UILabel!
    @IBOutlet var imgViewBikeBatteryIcon: UIImageView!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var viewSwipeToUnlock: SwipeButtonView!
    @IBOutlet var btnLocateMyBike: UIButton!
    @IBOutlet var btnNeedHelp: UIButton!
    @IBOutlet var btnFindNearestHub: UIButton!
    
    // Unlock Reconfirm Popop
    @IBOutlet var viewUnlockReconfirm: UIView!
    @IBOutlet var viewUnlockReconfirmSubview: UIView!
    @IBOutlet var imgViewUnlockReconfirmGIF: UIImageView!
    @IBOutlet var btnUnlockReconfirm: UIButton!
    @IBOutlet var btnUnlockCancel: UIButton!
    
    // End Ride Confirm Popup
    @IBOutlet var viewEndRideReconfirm: UIView!
    @IBOutlet var viewEndRideReconfirmSubView: UIView!
    @IBOutlet var imgViewEndRideReconfirmGIF: UIImageView!
    @IBOutlet var btnEndRideReconfrim: UIButton!
    @IBOutlet var btnEndRideCancel: UIButton!
    
    @IBOutlet var lblTimer: UILabel!
    
    // ***** Cancel Ride Details ***** //
    @IBOutlet weak var viewBackCancelMain: UIView!
    @IBOutlet weak var lblCanLockNumber: UILabel!
    @IBOutlet weak var lblCanRideID: UILabel!
    @IBOutlet weak var imgViewCanCycleCategory: UIImageView!
    @IBOutlet weak var lblCanCycleCategoryName: UILabel!
    @IBOutlet weak var lblCanTicketID: UILabel!
    @IBOutlet weak var lblCanDate: UILabel!
    @IBOutlet weak var lblCanDuration: UILabel!
    @IBOutlet weak var btnCancelRequest: UIButton!
    @IBOutlet weak var btnCanOkay: UIButton!
    @IBOutlet weak var lblCanRequestMessage: UILabel!
    
    
    @IBOutlet weak var consViewBackCancelRequestWidth: NSLayoutConstraint!
    
    
    var isHome = Bool()
    
    
    var dicCurrentRideData = [String: Any]()
    
    var locationManager = CLLocationManager()
    
    var bleManager: OmniBleManager?
    var bleClient: BikeLockClient?
    var listBleArray = [LockDetailsItem]()
    var lockDetails = BikeLockDetailsModel()
    var macAddress = String()
    
    var timerCounter = Timer()
    var timerCount = Int()
    
    var isUnlock : Bool = false
    

    @IBOutlet var btnStuckOkay: UIButton!
    @IBOutlet var imgStucLock: UIImageView!
    @IBOutlet var viewStuckLockInner: UIView!
    @IBOutlet var viewStuckLockMain: UIView!
    
    var isConnect = false
    var checkDeviceAvaibility = Bool()
    
    var strNearestMAcAddress : String!
    var aryScanMacAddress = [String]()
    
    var timer : Timer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
          manager = CBCentralManager()
          manager.delegate = self
       // self.tabBarController?.tabBar.isHidden = true
        
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state
        {
           case .poweredOn:
           
           // self.isUnlock = false
            self.bleManager?.stopScan()
            self.bleManager?.cancelCurrentConnect()
            
            BlutoothConnectivityIssue.instance.hidePopup()
            UnlockAlert.instance.hide()
            
            // UnlockAlert.instance.showAlert
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print("Bluetooth is On.")
               break
           case .poweredOff:
            
            self.bleManager?.stopScan()
            self.bleManager?.cancelCurrentConnect()
        
            CommonClass.removeProgressHudCycling(viewController: self)
            BlutoothConnectivityIssue.instance.hidePopup()
            UnlockAlert.instance.hide()
            
         /*   UnlockAlert.instance.hide()
            BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
            
            BlutoothConnectivityIssue.instance.ActionTryAgain =
            {
               /* self.bleManager = OmniBleManager()
                self.bleManager?.delegate = self
                self.bleClient = BikeLockClient()
                self.bleClient?.delegate = self
                self.bleManager?.scanDevices()*/
                BlutoothConnectivityIssue.instance.hidePopup()
            }*/
         //   CommonClass.removeProgressHudCycling(viewController: self)
               print("Bluetooth is Off.")
               break
           case .resetting:
            print("Bluetooth is Resetting.")
               break
           case .unauthorized:
            print("Bluetooth is Unauthorised.")
               break
           case .unsupported:
            print("Bluetooth is Not supported.")
               break
           case .unknown:
               break
           default:
               break
           }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setUIOnScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.viewBackCancelMain.layer.cornerRadius = 8.0
        self.viewBackCancelMain.shadowSecondaryView(frame: self.viewBackCancelMain.frame)
        
        self.consViewBackCancelRequestWidth.constant = self.view.frame.width - 40
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.scrollView.isHidden = true
        self.viewBackEndride.isHidden = true
        self.viewBackCancelMain.isHidden = true
    }
    
    // ********** All Button Actions ********** //
    @IBAction func btnStuckOkayClicked(_ sender: Any)
    {
        viewStuckLockMain.removeFromSuperview()
    }
    @IBAction func ActionBack(_ sender: UIButton) {
        
        if isHome == true
        {
            self.navigationController?.popToRootViewController(animated: true)
        }
        else if isHome == false
        {
            
             /*let storyBoard = UIStoryboard(name: "Main", bundle: nil)
             let homeVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
             appDelegate.window?.rootViewController = homeVC
             appDelegate.window?.makeKeyAndVisible()*/
            
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
             
          /*  if let viewControllers = self.navigationController?.viewControllers {
                   for vc in viewControllers
                {
                      /*  if vc.isKind(of: YourViewController.classForCoder())
                       {
                             print("It is in stack")
                             //Your Process
                        }*/
                       print(vc)
                   }
             }*/
            
            /*let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(tabVC, animated: true)*/
            
        }
        else
        {
           // self.navigationController?.popViewController(animated: true)
            let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(tabVC, animated: true)
        }
    }
    
    @IBAction func ActionLocateMyBike(_ sender: UIButton)
    {
        
    }
    
    @IBAction func ActionNeedHelp(_ sender: UIButton)
    {
        let faq = self.storyboard?.instantiateViewController(withIdentifier: "HelpAnfFaqVC") as! HelpAnfFaqVC
        self.navigationController?.pushViewController(faq, animated: true)
        
       /* for controller in self.navigationController!.viewControllers as Array
        {
            print(controller)
            if controller.isKind(of: fa)
            {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }*/
    }
    
    @IBAction func ActionFindNearestHub(_ sender: UIButton) {
        
        let homVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homVC.strFromOngoingRide = "OngoingRide"
        self.navigationController?.pushViewController(homVC, animated: true)
        
    }
    
    @IBAction func ActionEndRide(_ sender: UIButton) {
        
//        self.addEndrideTimerView()
        
//        self.endRideCycleBLE(strIsUnlock: "false", strVoltage: "99", strTimeStamp: "\(self.getCurrentTimeStamp())")
        
        
        viewEndRideReconfirmSubView.layer.cornerRadius = 8.0
        btnEndRideReconfrim.layer.cornerRadius = 8.0
        btnEndRideCancel.layer.cornerRadius = 8.0

        self.btnEndRideReconfrim.shadowSecondaryView(frame: self.btnEndRideReconfrim.frame)
     //   self.btnEndRideCancel.shadowSecondaryView(frame: self.btnEndRideCancel.frame)

        self.view.layoutIfNeeded()

        self.viewEndRideReconfirm.frame = (self.view.window?.bounds)!
        self.view.window?.addSubview(viewEndRideReconfirm)

        do {
            let gif = try UIImage(gifName: "lock_cycle_gif")
            self.imgViewEndRideReconfirmGIF.setGifImage(gif, loopCount: -1)

        } catch {

        }
        
    }
    
    @IBAction func ActionUnlockReconfrim(_ sender: UIButton)
    {
        
        self.viewUnlockReconfirm.removeFromSuperview()
        
     //   CommonClass.loadProgressHudCycling(viewController: self)
     
        self.timer?.invalidate()
        
        self.isUnlock = true
        
        self.bleManager = OmniBleManager()
        self.bleManager?.delegate = self
        self.bleClient = BikeLockClient()
        self.bleClient?.delegate = self
        self.bleManager?.scanDevices()
        
        print(manager.state)
        if manager.state == .poweredOn
        {
            print("Bluetooth is connected")
          //  self.bleManager?.stopScan()
         //   self.bleManager?.cancelCurrentConnect()
            
         }
         else if manager.state == .poweredOff
        {
            
          
//
            print("Bluetooth is not Connected.")
         }
       
        
        
        print("MANAGER STATE",manager.state.rawValue)
        print("MANAGER STATE HASH",manager.state.hashValue)
        
      /*  if manager.state.rawValue == 5
        {
            CommonClass.removeProgressHudCycling(viewController: self)
            
            BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
            
            BlutoothConnectivityIssue.instance.ActionTryAgain =
            {
                self.bleManager = OmniBleManager()
                self.bleManager?.delegate = self
                self.bleClient = BikeLockClient()
                self.bleClient?.delegate = self
                self.bleManager?.scanDevices()
            }
        }*/
    
    }
    
    @IBAction func ActionUnlockCancel(_ sender: UIButton) {
        
        CommonClass.removeProgressHudCycling(viewController: self)
        self.viewUnlockReconfirm.removeFromSuperview()
        
    }
    
    
    @IBAction func ActionEdnRideReconfirm(_ sender: UIButton) {
        
        self.viewEndRideReconfirm.removeFromSuperview()
        
        if CLLocationManager.locationServicesEnabled()
        {
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways
            {
                
                print("Access")
                
                self.isUnlock = false
    
                self.bleManager = OmniBleManager()
                self.bleManager?.delegate = self
                self.bleClient = BikeLockClient()
                self.bleClient?.delegate = self
                self.bleManager?.scanDevices()
                
            }
            else {
                print("No Access")
                AlertView.instance.showAlert(message: strLocationPrivacy, image: "IC_ErrorIcon", alertType: .success)
            }
            
        }
        else {
            
            print("Location services are not enabled")
            AlertView.instance.showAlert(message: strLocationEnable, image: "IC_ErrorIcon", alertType: .success)
        }
        
        
    }
    
    @IBAction func ActionEndRideCancel(_ sender: UIButton) {
        
        self.viewEndRideReconfirm.removeFromSuperview()
    }
    
    @IBAction func ActionCancelRequest(_ sender: UIButton)
    {
        OngoingRideCancelRequestAlert.instance.showMsg(txtmsg: "You are trying to cancel your end ride request.")
        
        OngoingRideCancelRequestAlert.instance.ActionYes =
        {
            self.cancelVideoRequestAPICall()
        }
        OngoingRideCancelRequestAlert.instance.ActionNo =
        {
            OngoingRideCancelRequestAlert.instance.HidePopup()
        }
     //   self.cancelVideoRequestAPICall()
    }
    
    @IBAction func ActionOkReq(_ sender: UIButton)
    {
        //TabBarVC
        
       /*
        if let destVC = segue.destination as? YourTabBarController {
                       destVC.selectedIndex = 0
                   }
        */
        
       /* let homVC = self.storyboard?.instantiateViewController(withIdentifier: "MyRidesVC") as! MyRidesVC
         self.navigationController?.pushViewController(homVC, animated: true)*/
        
       /* let homVC = self.storyboard?.instantiateViewController(withIdentifier: "MyRidesVC") as! MyRidesVC
        self.navigationController?.pushViewController(homVC, animated: true)*/
        
        /*
         let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
         self.navigationController?.pushViewController(homeVC, animated: true)
         
         */
       /* if let viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                if controller == TabBarVC
                    
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                self.navigationController?.pushViewController(homeVC, animated: true)
                print(controller)
            }
        }*/
       /* guard let vc = self.navigationController?.viewControllers else {return }
        for controller in vc
        {
            print("CONTROLLER",controller)
            if controller.isKind(of: TabBarVC.self)
            {
                
                let tabVC = controller as! TabBarVC
                tabVC.selectedIndex = 1
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
            
            
        }*/
        self.tabBarController?.selectedIndex = 1
     //   self.tabBarController!.setIndex(3, animated: true)
     //   let dNav = self.tabBarController?.viewControllers?[1] as! UINavigationController
        
        let homVC = self.storyboard?.instantiateViewController(withIdentifier: "MyRidesVC") as! MyRidesVC
        //self.currentTabBar!.viewControllers[3] as! UINavigationController
        self.navigationController!.pushViewController(homVC, animated: true)
    }
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension OngoingRideDetails {
    
    func setUIOnScreen()
    {
        imgViewEndRideReconfirmGIF.layer.borderWidth = 1.0
        imgViewEndRideReconfirmGIF.layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        imgViewEndRideReconfirmGIF.layer.cornerRadius = 10.0
        
        imgViewEndRideReconfirmGIF.clipsToBounds = true
        imgViewUnlockReconfirmGIF.layer.cornerRadius = 15.0
        
        btnUnlockReconfirm.layer.cornerRadius = 10.0
        btnUnlockCancel.layer.cornerRadius = 10.0
        
      //  self.btnLocateMyBike.setTitle("", for: .normal)
        self.btnNeedHelp.setTitle("", for: .normal)
        self.btnFindNearestHub.setTitle("", for: .normal)
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        
        
        btnStuckOkay.layer.cornerRadius = 10.0
        viewStuckLockInner.layer.cornerRadius = 8.0
        
        imgStucLock.layer.borderWidth = 1.0
        imgStucLock.layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        imgStucLock.layer.cornerRadius = 10.0
        
        imgStucLock.clipsToBounds = true
        imgStucLock.layer.cornerRadius = 15.0
        
        
        self.btnEndRide.layer.cornerRadius = 8.0
        self.viewBackEndride.layer.cornerRadius = 8.0
      //  self.viewBackEndride.shadowSecondaryView(frame: self.viewBackEndride.frame)
        self.viewBackBikeDetail.layer.cornerRadius = 8.0
       // self.viewBackBikeDetail.shadowSecondaryView(frame: self.viewBackBikeDetail.frame)
        
         self.viewBackEndride.viewTextFieldShadowBorderViewForOngoing()
         self.viewBackBikeDetail.viewTextFieldShadowBorderViewForOngoing()
        
        self.consViewBackDetailWidth.constant = self.view.frame.width
        
       // self.consViewLocationMyBikeH.constant = self.viewBackLocateMyBikeIcon.frame.size.width
        
      //  self.consViewNeedHelpH.constant = self.viewBackNeedHelpIcon.frame.size.width
        
       // self.consViewFindNearestH.constant = self.viewBackFindNearestIcon.frame.size.width
        
      //  self.viewBackLocateMyBikeIcon.layer.cornerRadius = self.viewBackLocateMyBikeIcon.frame.height / 2
      //  self.viewBackLocateMyBikeIcon.shadowRoundView(frame: self.viewBackLocateMyBikeIcon.frame)
        
       
        
        self.viewBackNeedHelpIcon.layer.cornerRadius = 30.0 //self.viewBackNeedHelpIcon.frame.height / 2
        
        self.viewBackNeedHelpIcon.shadowRoundView(frame: self.viewBackNeedHelpIcon.frame)
        
        self.viewBackFindNearestIcon.layer.cornerRadius = 30.0 //self.viewBackFindNearestIcon.frame.height / 2
        
       self.viewBackFindNearestIcon.shadowRoundView(frame: self.viewBackFindNearestIcon.frame)
        
        viewSwipeToUnlock.handleAction { [self] status in
            if status == "Finish" {
                print("success")
                
                viewUnlockReconfirmSubview.layer.cornerRadius = 8.0
                btnUnlockReconfirm.layer.cornerRadius = 8.0
                btnUnlockCancel.layer.cornerRadius = 8.0
                
                self.btnUnlockReconfirm.shadowSecondaryView(frame: self.btnUnlockReconfirm.frame)
               // self.btnUnlockCancel.shadowSecondaryView(frame: self.btnUnlockCancel.frame)
                
                self.view.layoutIfNeeded()
                
                self.viewUnlockReconfirm.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(viewUnlockReconfirm)
                
                do {
                    let gif = try UIImage(gifName: "Unlock-MYBYK")
                    self.imgViewUnlockReconfirmGIF.setGifImage(gif, loopCount: -1)
                    
                } catch {
                    
                }
                
            }
            else if status == "Fail" {
                print("fail")
            }
            else if status == "TouchCancelled" {
                print("Cancelled")
                self.scrollView.isScrollEnabled = true
            }
            else if status == "TouchEnded" {
                print("Ended")
                self.scrollView.isScrollEnabled = true
            }
            else if status == "TouchBegan" {
                print("Began")
                self.scrollView.isScrollEnabled = false
            }
        }
        
        self.btnCancelRequest.layer.cornerRadius = 8.0
        self.btnCanOkay.layer.cornerRadius = 8.0
        
        if let tabItems = tabBarController?.tabBar.items
        {
            let tabItemRide = tabItems[1]
            tabItemRide.badgeValue = "1"
        }
        
        self.getCurrentRideAPICall()
    }
    
    func addEndrideTimerView() {
        
        let endRide = self.storyboard?.instantiateViewController(withIdentifier: "EndRideCountDownTimerVC") as! EndRideCountDownTimerVC
        self.addChild(endRide)
        self.view.addSubview(endRide.view)
        endRide.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        endRide.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    @objc func counterRideTime() {
        
        timerCount += 1
        
        let hours = timerCount / 3600
        let minutes = (timerCount / 60) % 60
        let seconds = timerCount % 60
        
        self.lblTimer.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension OngoingRideDetails {
    
    func getCurrentRideAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getCurrentRideAPICall(dictionary: ["action": "currentRide"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            //  "ride_status" = Ongoing;
            if response["is_error"] as! String == "false"
            {
                
                let dicCurrentData = response["data"] as! [String: Any]
                
                self.dicCurrentRideData = dicCurrentData
                
                if let key = dicCurrentData["ble_key"] as? String {
                    strBLEKey = key
                }
                else {
                    strBLEKey = "577N6k30"
                }
                
                if dicCurrentData["showcanclebutton"] as! String == "true" {
                    
                    self.scrollView.isHidden = true
                    self.viewBackEndride.isHidden = true
                    self.viewBackCancelMain.isHidden = false
                    
                    self.lblCanLockNumber.text = dicCurrentData["QRcode"] as? String ?? ""
                    print( dicCurrentData["QRcode"] as? String ?? "")
                    lbLockNumber.text =  dicCurrentData["QRcode"] as? String ?? ""
                    
                    
                    self.lblCanRideID.text = "\(dicCurrentData["rideID"] as? Int ?? 0)"
                    self.imgViewCanCycleCategory.image = UIImage(named: getDynamicCycleName(strCycleType: "\(dicCurrentData["categoryName"] as! String)"))
                    self.lblCanCycleCategoryName.text = "\(dicCurrentData["categoryName"] as! String)"
                    self.lblCanTicketID.text = "\(dicCurrentData["idendriderequest"] as? String ?? "-")"
                    self.lblCanDate.text = "\(dicCurrentData["req_date"] as! String) \(dicCurrentData["req_time"] as! String)"
                    self.lblCanDuration.text = "\(dicCurrentData["ride_duration"] as! String)"
                    self.lblCanRequestMessage.text = "\(dicCurrentData["cancel_ride_message"] as! String)"
                    
                }
                else {
                    
                    self.scrollView.isHidden = false
                    self.viewBackEndride.isHidden = false
                    self.viewBackCancelMain.isHidden = true
                    
                    self.lblLockNumber.text = dicCurrentData["QRcode"] as? String ?? ""
                    print( dicCurrentData["QRcode"] as? String ?? "")
                    lbLockNumber.text =  dicCurrentData["QRcode"] as? String ?? ""
                    
                    self.lblBikeNumber.text = dicCurrentData["SIN"] as? String ?? ""
                    self.lblBikeType.text = dicCurrentData["categoryName"] as? String ?? ""
                    self.lblRideID.text = "\(dicCurrentData["rideID"] as? Int ?? 0)"
                    self.imgViewCycleCategory.image = UIImage(named: getDynamicCycleName(strCycleType: "\(dicCurrentData["categoryName"] as! String)"))
                    self.lblBikeBattery.text = "\(dicCurrentData["batteryLevel"] as! Int)%"
                    self.lblNotes.text = (dicCurrentData["ride_note"] as! String).htmlToString
                    self.macAddress = dicCurrentData["macAddress"] as! String
                    
                    if dicCurrentData["usageTime"] != nil && !(dicCurrentData["usageTime"] is NSNull) {
                        self.timerCount = dicCurrentData["usageTime"] as! Int
                    }
                    else {
                        self.timerCount = 0
                    }
                    
                    self.timerCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counterRideTime), userInfo: nil, repeats: true)
                }
                
                UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
                UserDefaults.standard.synchronize()
            }
            else {
                
                if response["error_code"] as! String == "404" {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else
                {
                    UserDefaults.standard.removeObject(forKey: "RideStatus")
                    UserDefaults.standard.synchronize()
                    
                    let story = UIStoryboard(name: "Main", bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                 /*   let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()*/
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func unlockCycleBLE(strIsUnlock: String, strVoltage: String, strTimeStamp: String) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.unlockCycleBLE(dictionary: ["unlock": "1", "isUnlock":strIsUnlock, "voltage":strVoltage, "timestamp":strTimeStamp]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                //self.view.layoutIfNeeded()
                 
                 self.viewUnlockSuccess.frame = (self.view.window?.bounds)!
                 self.view.window?.addSubview(viewUnlockSuccess)
                 
                 self.viewUnlockSuccessAnim.contentMode = .scaleAspectFit
                self.viewUnlockSuccessAnim.loopMode = .playOnce
                 self.viewUnlockSuccessAnim.animationSpeed = 0.9
                 self.viewUnlockSuccessAnim.play()
                
                self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: false)
                
                self.bleClient?.sendUnlock(withUserId: 1, timestamp: Int32(self.getCurrentTimeStamp())!, outArea: false)
                
                
            }
            else
            {
                
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
    
    func endRideCycleBLE(strIsUnlock: String, strVoltage: String, strTimeStamp: String) {
        
        //"nearest_lock_macaddress" :
        
        /*
         let someArray = [1, 2, 3, 4, 5, 6, 7]
         let first5 = someArray.prefix(5)
         */
       // let tmpAry = aryScanMacAddress.remo
        let aryLockNear5 = aryScanMacAddress.prefix(5)
        let joinedMacAddress = aryLockNear5.joined(separator: ",")
        
        print(joinedMacAddress)
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        /*
         "lat": "21.712719",
         "long": "71.064774",
         */
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.endRideCycleBLE(dictionary: ["isUnlock":strIsUnlock, "voltage":strVoltage, "timestamp":strTimeStamp, "note":"", "cycleStatus":"1", "lockType":"\(self.dicCurrentRideData["lockType"] as! String)", "lat":"\(currentLocation.coordinate.latitude)", "long":"\(currentLocation.coordinate.longitude)","nearest_lock_macaddress":joinedMacAddress]) { [self] response in
           /* APIService.sharedInstance.endRideCycleBLE(dictionary: ["isUnlock":strIsUnlock, "voltage":strVoltage, "timestamp":strTimeStamp, "note":"", "cycleStatus":"1", "lockType":"\(self.dicCurrentRideData["lockType"] as! String)", "lat":"21.712719", "long":"71.064774","nearest_lock_macaddress":joinedMacAddress]) { [self] response in*/
            CommonClass.removeProgressHudCycling(viewController: self)
            
            self.bleManager?.stopScan()
            self.bleManager?.cancelCurrentConnect()
            
            print(response)
            
            let diRespo = response["data"] as? [String:Any]
           // print(diRespo?["videosubmit"]!!)
            
            if diRespo?["videosubmit"] as! String == "true"
            {
                EndRideTryRequest.instance.showEndRideTryRequest(title: "HAVE YOU LOCKED MYBYK PROPERLY AT THE HUB?", message: "The bike lock appears to be open!\nPlease ensure you have locked the bike properly at the hub and try again!", iconName: "IC_CycleLockStuckToLatch")
                 EndRideTryRequest.instance.ActionTryEndingRideAgain =
                 {
 //                    self.bleManager = OmniBleManager()
 //                    self.bleManager?.delegate = self
 //                    self.bleClient = BikeLockClient()
 //                    self.bleClient?.delegate = self
 //                    self.bleManager?.scanDevices()
                     
                 }
                 EndRideTryRequest.instance.ActionSubmitVideoEndRide = {
                     
                     self.getVideoRequestID()
                     
                 }
            }
            else
            {
                if response["is_error"] as! String == "false"
                {
//                    let viewControllers = self.navigationController!.viewControllers
//                 //   print(index!)
//                    for aViewController in viewControllers
//                      {
//                          print(aViewController)
////                         if aViewController is HomeVC
////                         {
////                            let aVC = aViewController as! HomeVC
////                             aVC.FromSelectBike = index
////                            _ = self.navigationController?.popToViewController(aVC, animated: true)
////                         }
//                      }
                    
                    let summary = self.storyboard?.instantiateViewController(withIdentifier: "RideSummaryVC") as! RideSummaryVC
                    summary.dicCurrentRideData = response["data"] as! [String: Any]
                    UserDefaults.standard.setValue(nil, forKey: "RideStatus")
                    UserDefaults.standard.synchronize()
                    self.navigationController?.pushViewController(summary, animated: true)
                    
                }
                else
                {
                    
                    if response["error_code"] as! String == "404"
                    {
                        
                        CommonClass.moveToLogOut(viewController: self)
                    }
                    else if response["error_code"] as! String == "403"
                    {
                        
                        let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                        toast.show()
                        
                        UserDefaults.standard.removeObject(forKey: "RideStatus")
                        UserDefaults.standard.synchronize()
                        
                        let story = UIStoryboard(name: "Main", bundle:nil)
                        let vc = story.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                        UIApplication.shared.windows.first?.rootViewController = vc
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                        
                       /* EndRideTryRequest.instance.showEndRideTryRequest(title: "HAVE YOU LOCKED MYBYK PROPERLY AT THE HUB?", message: "The bike lock appears to be open!\nPlease ensure you have locked the bike properly at the hub and try again!", iconName: "IC_CycleLockStuckToLatch")
                        EndRideTryRequest.instance.ActionTryEndingRideAgain =
                        {
        //                    self.bleManager = OmniBleManager()
        //                    self.bleManager?.delegate = self
        //                    self.bleClient = BikeLockClient()
        //                    self.bleClient?.delegate = self
        //                    self.bleManager?.scanDevices()
                            
                        }
                        EndRideTryRequest.instance.ActionSubmitVideoEndRide = {
                            
                            self.getVideoRequestID()
                            
                        }*/
                    }
                    else {
                        
                        let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                        toast.show()
                    }
                    
                }
            }
            
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func getVideoRequestID() {
        
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getVideoRequestID(dictionary: ["lat": "\(currentLocation.coordinate.latitude)", "long":"\(currentLocation.coordinate.longitude)", "cycleStatus":"1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let dicRequestData = response["data"] as! [String: Any]
                
                print(dicRequestData)
                print((dicRequestData["endridereqid"] as! Int))
                
                if let viewControllers = self.navigationController?.viewControllers
                    {
                        for controller in viewControllers
                        {
                            print(controller)
//                            if controller is UIViewController
//                            {
//                                viewControllers.removeElement(controller)
//                                self.navigationController?.viewControllers = viewControllers
//                            }
                        }
                }
                let endRideInstruction = self.storyboard?.instantiateViewController(withIdentifier: "EndRideInstructionVC") as! EndRideInstructionVC
                endRideInstruction.strRequestID = "\(dicRequestData["endridereqid"] as! Int)"
              //  UserDefaults.standard.setValue(nil, forKey: "RideStatus")
             //   UserDefaults.standard.synchronize()
                self.navigationController?.pushViewController(endRideInstruction, animated: true)
                
                
//                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                let endRideInstruction =  storyBoard.instantiateViewController(withIdentifier: "EndRideInstructionVC") as! EndRideInstructionVC
//                endRideInstruction.strRequestID = "\(dicRequestData["endridereqid"] as! Int)"
//                let appdelegate = UIApplication.shared.delegate as? AppDelegate
//                appdelegate?.window?.rootViewController = endRideInstruction
//                appdelegate?.window?.makeKeyAndVisible()
                
                 // appdelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                
               // self.window?.rootViewController = homeVC
                //self.window?.makeKeyAndVisible()
                
              //  DispatchQueue.main.async {
                    
                 
               // }
               
            }
            else {
                
                if response["error_code"] as! String == "404" {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else {
                    
                      let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                      toast.show()
                    
                    UserDefaults.standard.removeObject(forKey: "RideStatus")
                    UserDefaults.standard.synchronize()
                    
                    let story = UIStoryboard(name: "Main", bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                 
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func cancelVideoRequestAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.cancelVideoRequestAPICall(dictionary: ["endridereqid": "\(dicCurrentRideData["idendriderequest"] as! String)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicCancelRequestData = response["data"] as! [String: Any]
                
                self.getCurrentRideAPICall()
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
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

// ************************************ //
// MAKR:- BlueToothDelegate Methods
// ************************************ //
extension OngoingRideDetails : BikeLockCmdDelegate, BleManagerDelegate {
    
    func scanDevicesResult(_ lists: [LockDetailsItem])
    {
        
        self.listBleArray = [LockDetailsItem]()
        self.listBleArray = lists
        
        for item in listBleArray
        {
            print(item.mac)
            
            if !aryScanMacAddress.contains(item.mac)
            {
                aryScanMacAddress.append(item.mac)
            }
            if item.mac.uppercased() == self.macAddress.uppercased()
            {
                print(item.mac)
                CommonClass.loadProgressHudCycling(viewController: self)
                
                self.bleManager?.stopScan()
                self.bleManager?.connect(item.peripheral)
                isConnect = true
               // BlutoothConnectivityIssue.instance.hidePopup()
                print("Not Compare MAC")
//                BluetoothError770.instance.showAlert()
//                BluetoothError770.instance.ActionTryAgain770 =
//                {
//                    UnlockAlert.instance.hide()
//                 //   Blutooth660Error.instance.hi
//                    //hide
//                  /*  self.bleManager = OmniBleManager()
//                    self.bleManager?.delegate = self
//                    self.bleClient = BikeLockClient()
//                    self.bleClient?.delegate = self
//                    self.bleManager?.scanDevices()*/
//                }
            }
           /* if item.mac.uppercased() != self.macAddress.uppercased()
            {
                print("Compare MAC")
                
                BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
                
                BlutoothConnectivityIssue.instance.ActionTryAgain =
                {
                    self.isConnect = false
                    
                    //self.checkDeviceAvaibility = false
                    CommonClass.removeProgressHudCycling(viewController: self)
                    BlutoothConnectivityIssue.instance.hidePopup()
                    
//                    self.bleManager = OmniBleManager()
//                    self.bleManager?.delegate = self
//                    self.bleClient = BikeLockClient()
//                    self.bleClient?.delegate = self
//                    self.bleManager?.scanDevices()
                }
//                BluetoothError770.instance.HidePopup()
//                Blutooth660Error.instance.HideAlert()
//                BluetoothError303.instance.HideAlert()
//                UnlockAlert.instance.hide()
                
            }*/
        }
        
      //  CommonClass.loadProgressHudCycling(viewController: self)
        if self.checkDeviceAvaibility == false
        {
            CommonClass.loadProgressHudCycling(viewController: self)
            self.checkDeviceAvaibility = true

            self.errorCaseOfAreYouStanding()

        }
    }
    func errorCaseOfAreYouStanding()
    {
        print("Standing")
       // DispatchQueue.main.asyncAfter(deadline: .now() + 10.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0)
        {
            if self.isConnect == false
            {
              //  CommonClass.loadProgressHudCycling(viewController: self)
                CommonClass.removeProgressHudCycling(viewController: self)
                
                self.bleManager?.stopScan()
                
                BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
                
                BlutoothConnectivityIssue.instance.ActionTryAgain =
                {
                    self.isConnect = false
                    
                    self.checkDeviceAvaibility = false
                    CommonClass.removeProgressHudCycling(viewController: self)
                    BlutoothConnectivityIssue.instance.hidePopup()
                }
                    
                if self.isUnlock == false
                {
                    
                }
                else
                {
                    if self.isConnect == true
                    {
                        BlutoothConnectivityIssue.instance.hidePopup()
                    }
                    else
                    {
                        CommonClass.removeProgressHudCycling(viewController: self)
                        
                        BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
                        
                        BlutoothConnectivityIssue.instance.ActionTryAgain =
                        {
                            self.isConnect = false
                            
                            self.checkDeviceAvaibility = false
                            
                            CommonClass.removeProgressHudCycling(viewController: self)
                            BlutoothConnectivityIssue.instance.hidePopup()
//                            self.bleManager = OmniBleManager()
//                            self.bleManager?.delegate = self
//                            self.bleClient = BikeLockClient()
//                            self.bleClient?.delegate = self
                           // self.bleManager?.scanDevices()
                        }
                    }
                    
                }
               
            }
            else
            {
                CommonClass.removeProgressHudCycling(viewController: self)
//                if self.isConnect == true
//                {
//
//                    print("NOT CONNECTED CHECK DEVICE")
//                    //print(self.bleClient?.obtainLockDetails()!)
//
//                    CommonClass.removeProgressHudCycling(viewController: self)
//                }
//                else
//                {
//                    self.checkDeviceAvaibility = false
//
//                    CommonClass.removeProgressHudCycling(viewController: self)
//
//                    BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
//
//                    BlutoothConnectivityIssue.instance.ActionTryAgain =
//                    {
//                        self.bleManager = OmniBleManager()
//                        self.bleManager?.delegate = self
//                        self.bleClient = BikeLockClient()
//                        self.bleClient?.delegate = self
//                        self.bleManager?.scanDevices()
//                    }
//                }
//
//
            }
        }
        
    }
    @objc func timerHideUnlockSucccess()
    {
    //    self.isUnlock = false
       // self.isUnlock = true
        
        self.timer?.invalidate()
        self.viewUnlockSuccessAnim.stop()
        self.viewUnlockSuccess.removeFromSuperview()
       /* let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
      //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
      //  UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(ongoing, animated: true)*/
    }
    func didConnectedPeripheral(_ peripheral: CBPeripheral)
    {
        print("STATE",peripheral.state)
      //  CommonClass.removeProgressHudCycling(viewController: self)
        
      //  let toast = Toast(text: "didConnectedPeripheral", delay: 0.0, duration: Delay.long)
      //  toast.show()
        
      //  self.bleManager?.stopScan()
      //  self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
        
      //  if self.isUnlock == true
     //   {
            /*let toast = Toast(text: "didConnectedPeripheral", delay: 0.0, duration: Delay.long)
            toast.show()
            
           */
            
            self.bleManager?.stopScan()
            self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
            
            
      //  }
      //  else
      //  {
       //     self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
          //  self.bleManager?.stopScan()
          //  self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
            
           
      //  }
        
        
      /*  print("CHECK FIRST",peripheral.state)
        
//        btnUnlock.isEnabled = false
//        isConnected = true
        
     //   self.isUnlock = false
        
        self.bleManager?.stopScan()
        self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
//        self.errorConnectOfAreYouStanding()*/
      /*  if self.isUnlock == false
        {
            let toast = Toast(text: "didConnectedPeripheral", delay: 0.0, duration: Delay.long)
            toast.show()
            
            self.view.layoutIfNeeded()
             
             self.viewUnlockSuccess.frame = (self.view.window?.bounds)!
             self.view.window?.addSubview(viewUnlockSuccess)
             
             self.viewUnlockSuccessAnim.contentMode = .scaleAspectFit
             self.viewUnlockSuccessAnim.loopMode = .playOnce
             self.viewUnlockSuccessAnim.animationSpeed = 0.5
             self.viewUnlockSuccessAnim.play()
            
            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: true)
            
            self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
        }
        else{
            
            self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
        }*/
      
    }
    
    func didDisconnectPeripheral(_ peripheral: CBPeripheral)
    {

        print("CHECK SECOND")
        viewUnlockReconfirm.removeFromSuperview()
        CommonClass.removeProgressHudCycling(viewController: self)
        print("didDisconnectPeripheral")
        print("PERIPHERAL",peripheral)
        
      
        
     /*   if isConnect == true
        {
//            BluetoothError770.instance.showAlert()
//            BluetoothError770.instance.ActionTryAgain770 =
//            {
//                UnlockAlert.instance.hide()
//                //hide
//              /*  self.bleManager = OmniBleManager()
//                self.bleManager?.delegate = self
//                self.bleClient = BikeLockClient()
//                self.bleClient?.delegate = self
//                self.bleManager?.scanDevices()*/
//            }
        }
        else{
            
            BluetoothError770.instance.HidePopup()
            Blutooth660Error.instance.HideAlert()
            BluetoothError303.instance.HideAlert()
            UnlockAlert.instance.hide()
        }*/
      
    }
    
    func didFail(toConnect peripheral: CBPeripheral)
    {
        print("CHECK FAIL")
        CommonClass.removeProgressHudCycling(viewController: self)
        self.bleManager?.stopScan()
        
   /*     if isConnect == true
        {
            
        }
        else{
            /*  Blutooth660Error.instance.showAlert()
              Blutooth660Error.instance.ActionSubmitVideo */
//             BluetoothError770.instance.showAlert()
//
//              BluetoothError770.instance.ActionTryAgain770 =
//              {
//                  self.bleManager = OmniBleManager()
//                  self.bleManager?.delegate = self
//                  self.bleClient = BikeLockClient()
//                  self.bleClient?.delegate = self
//                  self.bleManager?.scanDevices()
//              }
        }
     */
        
    }
    
    func passBikeCertification()
    {
        print("CHECK CERTIFICATE")
        
//        isConnect = true
        print("passBikeCertification")
        self.bleClient?.obtainLockDetails()
    }
    
    func bikeLockDetailsCompletion(_ completion: BikeLockDetailsModel)
    {
        
        print("CHECK LOCKDETAIL",completion.lockStatus)
        print("CHECK LOCKDETAIL",completion.electricity)
        
        self.lockDetails = completion
//        isConnected = false
        
    
        if completion.lockStatus == 0
        {
//            self.isConnect = true
            self.bleManager?.cancelCurrentConnect()
//            self.showToast(message: "The Bike is already Unlocked")
            
            if self.isUnlock == true
            {
              //  self.viewUnlockSuccess.removeFromSuperview()
                print("CHECK LOCKDETAIL UNLOCK")
                self.viewUnlockSuccess.removeFromSuperview()
                
                UnlockAlert.instance.showAlert(message: "It seems your bike is already unlocked.", image: "IC_ErrorIcon", alertType: .success)
                UnlockAlert.instance.ActionOk =
                {
                   // self.isUnlock = false
                    
                    self.bleManager?.stopScan()
                    self.bleManager?.cancelCurrentConnect()
                }
              //  SwipeUnlockPopup.instance.showAlert(message: "Bike already unlocked", alertType: .success)
             //   let toast = Toast(text: "Bike already unlocked", delay: 0.0, duration: Delay.long)
             //   toast.show()
              //  AlertView.instance.showAlert(message: "Bike already unlocked", image: "IC_ErrorIcon", alertType: .success)
                
            }
            else {
                
                print("CHECK LOCKDETAIL UNLOCK ELSE")
                
//                EndRideTryRequest.instance.showEndRideTryRequest(title: "Oops! We are unable to connect with the bike.", message: "We are facing an issue in connecting with the bike and need to switch off and switch on your device’s Bluetooth and try again")
                EndRideTryRequest.instance.showEndRideTryRequest(title: "HAVE YOU LOCKED MYBYK PROPERLY AT THE HUB?", message: "The bike lock appears to be open!\nPlease ensure you have locked the bike properly at the hub and try again!", iconName: "IC_CycleLockStuckToLatch")
                EndRideTryRequest.instance.ActionTryEndingRideAgain =
                {
//                    self.bleManager = OmniBleManager()
//                    self.bleManager?.delegate = self
//                    self.bleClient = BikeLockClient()
//                    self.bleClient?.delegate = self
//                    self.bleManager?.scanDevices()
                    
                }
                EndRideTryRequest.instance.ActionSubmitVideoEndRide = {
                    
                    self.getVideoRequestID()
                    
                }
            }
        }
        else
        {
            print(self.isUnlock)
            if self.isUnlock == true
            {
                
                print("CHECK LOCKDETAIL UNLOCK ELSE TRUE")
                self.unlockCycleBLE(strIsUnlock: "false", strVoltage: "\(completion.electricity)", strTimeStamp: completion.timestamp)
            }
            else
            {
                print("CHECK LOCKDETAIL UNLOCK ELSE FALSE")
                self.endRideCycleBLE(strIsUnlock: "false", strVoltage: "\(completion.electricity)", strTimeStamp: completion.timestamp)
            }
            
        }
        
    }
    
    func bikeUnlockCompletion(_ completion: BikeLockUnlockModel) {
//        self.showToast(message: "bikeUnlockCompletion")
        
        print("CHECK UNLOCKCOMPLETION")
        
        print("bikeUnlockCompletion")
        print("timestamp = \(completion.timestamp)")
        
        
    //    self.bleManager?.stopScan()
    //    self.bleManager?.cancelCurrentConnect()
        
        CommonClass.removeProgressHudCycling(viewController: self)
        
        
        if completion.isSuccess == true
        {
            self.viewStuckLockMain.removeFromSuperview()
            
           // let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        //    ongoing.isHome = true
           // self.navigationController?.pushViewController(ongoing, animated: true)
        }
        else
        {
            
         //   self.viewProceedPayAfterConfirmation.removeFromSuperview()
            
            viewUnlockReconfirm.removeFromSuperview()
            
            self.view.layoutIfNeeded()
            
            self.viewStuckLockMain.frame = (self.view.window?.bounds)!
            self.view.window?.addSubview(viewStuckLockMain)
            
            //Unlock-MYBYK
            do {
                let gif = try UIImage(gifName: "unable_to_lock")
                self.imgStucLock.setGifImage(gif, loopCount: -1)
                
            } catch {
                
            }
        }
        
//        if completion.isSuccess == false {
//            self.bleManager?.stopScan()
//            self.bleManager?.cancelCurrentConnect()
//            self.view.layoutIfNeeded()
//
//            self.viewNotOpenLockPopup.frame = (self.view.window?.bounds)!
//            self.view.window?.addSubview(self.viewNotOpenLockPopup)
//
//            do {
//                let gif = try UIImage(gifName: "UnableToUnlock-")
//                self.imgViewNotOpenLock.setGifImage(gif, loopCount: -1)
//            } catch {
//
//            }
//        }
//        else {
//
//            self.bleManager?.stopScan()
//
//            let message = "Bike unlocked successfully"
//            let alert = SCLAlertView()
//            alert.addButton("OK", actionBlock: {() -> Void in
//                self.bleManager?.cancelCurrentConnect()
//            })
//
//            alert.tintTopCircle = false
//            alert.removeTopCircle()
//            alert.setBodyTextFontFamily(Constant.REGULER_FONT, withSize: 14)
//            alert.showCustom(UIApplication.topViewController(), image: UIImage(named:"MYBYK-1"), color: UIColor(red: 84.0 / 255.0, green: 169.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0),title: nil, subTitle: message, closeButtonTitle: nil, duration: 0.0)
//        }
        
    }
    
    func bikeLockedCompletion(_ completion: BikeLockLockedModel)
    {
//        self.showToast(message: "bikeLockedCompletion")
        print("CHECK UNLOCKCOMPLETION TIME")
        
        print("timestamp = \(completion.timestamp)")
    }
    
    
    
}



