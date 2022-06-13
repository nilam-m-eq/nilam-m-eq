//
//  SubscriptionDetailVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/12/21.
//

import UIKit
import CoreLocation
import Toaster
import OmniBaseTool
import OmniBikeLock
import Lottie

class SubscriptionDetailVC: CommonViewController, UIGestureRecognizerDelegate
{
    @IBOutlet var LbDetails: UILabel!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet weak var viewUnlockLottie: AnimationView!
    @IBOutlet var viewBackDetail: UIView!
    @IBOutlet var btnProceedToPay: UIButton!
    
    @IBOutlet var viewUnlockSuccessMail: UIView!
    @IBOutlet var btnStuckOkay: UIButton!
    @IBOutlet var imgStuck: UIImageView!
    @IBOutlet var viewStuckInner: UIView!
    @IBOutlet var viewStuckLock: UIView!
    @IBOutlet var lbSubsciptionLateReturnChargeConst: NSLayoutConstraint!
    @IBOutlet var lbSubscriptionValidityConst: NSLayoutConstraint!
    @IBOutlet var lbSubcriptionHeightConsnt: NSLayoutConstraint!
    @IBOutlet var viewChargeHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lblSubChagrePreview: UILabel!
    @IBOutlet weak var lblSubChargeAmount: UILabel!
    @IBOutlet weak var lblSubValidityPreview: UILabel!
    @IBOutlet weak var lblSubValidityDuration: UILabel!
    @IBOutlet weak var lblRideChargePreview: UILabel!
    @IBOutlet weak var lblRideChargeAmount: UILabel!
    @IBOutlet weak var viewBackDescription: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblRechargeAmountPreview: UILabel!
    @IBOutlet weak var lblSecurityDepositePreview: UILabel!
    @IBOutlet weak var lblSecurityDepositeAmount: UILabel!
    @IBOutlet weak var lblSubscriptionChargePreview: UILabel!
    @IBOutlet weak var lblSubscriptionChargeAmount: UILabel!
    @IBOutlet weak var lblToPayPreview: UILabel!
   
    @IBOutlet var viewMainHeigthConst: NSLayoutConstraint!
    @IBOutlet weak var lblRechargeAmount: UILabel!
    @IBOutlet var viewBackScrollMainWidth: NSLayoutConstraint!
    
    var locationManager = CLLocationManager()
    var dicCycleData = [String: Any]()
    var dicSubscriptionPlan = [String: Any]()
    var strStationID = String()
    var macAddress = String()
    var bleManager: OmniBleManager?
    var bleClient: BikeLockClient?
    var listBleArray = [LockDetailsItem]()
    var lockDetails = BikeLockDetailsModel()
    
    var checkDeviceAvaibility = Bool()
    var isConnect = false
    
    @IBOutlet var txtDetail: UITextView!
    var Fullview: CGFloat = UIScreen.main.bounds.height
    var isDisplay = false
    var flagCheck : Bool!
    
    @IBOutlet var txtHeightConst: NSLayoutConstraint!
    @IBOutlet var viewSubscriptionDetail: UIView!
    @IBOutlet var lblPlanTitle: UILabel!
    @IBOutlet var lbSubscriptionCharge: UILabel!
    @IBOutlet var lbSubscriptionChargeValue: UILabel!
    @IBOutlet var lbSubscriptionValidity: UILabel!
    @IBOutlet var lbSubscriptionValidityValue: UILabel!
    @IBOutlet var lbLateReturnCharge: UILabel!
    @IBOutlet var lbLateReturnChargeValue: UILabel!
   // @IBOutlet var lbDetails: UILabel!
    @IBOutlet var lbSubscriptionChargeSecond: UILabel!
    @IBOutlet var lbSubscriptionChargeSecondValue: UILabel!
    @IBOutlet var lbMyCredit: UILabel!
    @IBOutlet var lbMyCreditValue: UILabel!
    @IBOutlet var lbWallet: UILabel!
    @IBOutlet var lbWalletValue: UILabel!
    @IBOutlet var lbNetCharge: UILabel!
    @IBOutlet var lbNetChargeValue: UILabel!
    @IBOutlet var lbSecurityDeposite: UILabel!
    @IBOutlet var lbSecurityDepoValue: UILabel!
    @IBOutlet var lbRechargeAmnt: UILabel!
    @IBOutlet weak var lblToPayAmount: UILabel!
    
    @IBOutlet var btnOkay: UIButton!
    var CovertAmnt  : String!
    
    var setGPRSBLEVal : Bool!
    
    @IBOutlet var imgConfirmation: UIImageView!
    @IBOutlet var lbConfirmationLockNumber: UILabel!
    @IBOutlet var viewConfirmationInnerPopup: UIView!
    @IBOutlet var viewConfirmationPopup: UIView!
    var timer : Timer?
    
    var fontForSubCharge : UIFont!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        gesture.delegate = self
        viewBackDetail.addGestureRecognizer(gesture)
        
       /* if btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 20 > Fullview - 50
        {
            viewMainHeigthConst.constant = Fullview - 80
            scrollview.isScrollEnabled = true
            
            
            
            flagCheck = false
           /* let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe1(_:)))

                // Configure Swipe Gesture Recognizer
            swipeGestureRecognizerDown.direction = .down
            scrollview.addGestureRecognizer(swipeGestureRecognizerDown)*/
        }
        else
        {
            viewMainHeigthConst.constant = btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 54
            print("Y",btnProceedToPay.frame.origin.y)
            print("HEIGHT",btnProceedToPay.frame.height)
            print("HEIGHT",btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 54 )
            scrollview.isScrollEnabled = false
            
            flagCheck = true
          /*  let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))

                // Configure Swipe Gesture Recognizer
            swipeGestureRecognizerDown.direction = .down
            scrollview.addGestureRecognizer(swipeGestureRecognizerDown)*/
            
          // let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToNewImage(_:)))
         //   swipeLeftGesture.direction = .t
          //  scrollview.addGestureRecognizer(swipeLeftGesture)
         //   var panGesture = UIPanGestureRecognizer(target: self, action:("handlePanGesture:"))
               // viewMain.addGestureRecognizer(panGesture)
            
        }*/
     //   self.tabBarController?.tabBar.isHidden = true
    }
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer)
    {
        print(flagCheck!)
        let translation = recognizer.translation(in: self.viewBackDetail)
        let velocity = recognizer.velocity(in: self.view)
        print("VELOCITY",velocity)
        
        print("TRANSLATION",translation.y)
        
        let y = viewBackDetail.frame.minY
        
        print("Y",y)
        print(Fullview - self.viewBackDetail.frame.height + 30)
        print("Y POS",y)
        
       // if (y + translation.y >= fullView) && (y + translation.y <=  btnClick.frame.origin.y + btnClick.frame.height + 20)
        print("FULL VIEW",Fullview - 80)
        print("BUTTon",btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 20)
        
        
        /*
         if (x >= 0)
         {
             // do positive stuff
         }
         else
         {
             // do negative stuff
         }
         */
       
        if flagCheck == false
        {
            if velocity.y < 0
            {
                if y > 80
                {
                    self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
                else
                {
                    self.viewBackDetail.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: viewBackDetail.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
               
                   
               /* }
                else
                {
                    self.viewMain.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewMain.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }*/
                print("HEIGHT after change",viewBackDetail.frame.height)
            }
            else if velocity.y == 0.0
            {
                self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
            }
            else
            {
               
                self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
              //  viewMainHeightConstant.constant = Fullview - 80
            }
            
            /* self.viewMain.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: btnClick.frame.origin.y + btnClick.frame.height + 20)
            recognizer.setTranslation(CGPoint.zero, in: self.viewMain)*/
        //}
      /*  if (y + translation.y <=  btnClick.frame.origin.y + btnClick.frame.height + 20)
        {
           // self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
          //  recognizer.setTranslation(CGPoint.zero, in: self.view)
            
         //   viewMainHeightConstant.constant = y + translation.y
         //  recognizer.setTranslation(CGPoint.zero, in: self.view)
        }*/
    
        if recognizer.state == .ended
        {
            print("ENDED")
           // var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y)
            
            print("TOUCH ENDED",velocity.y)
            
           /* UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations:
            {
                self.viewMain.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.viewMain.frame.height)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
            }, completion: { [weak self] _ in
                if (velocity.y < 0) {
                    //                        self?.tableView.isScrollEnabled = true
                }
            })*/
            if velocity.y > 0
            {
                self.view.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0) {

                    self.view.layoutIfNeeded()
                    
                  //  self.view.removeFromSuperview()
                    
                   // self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
                  //  self.view.frame.origin.y = self.view.frame.height

                } completion: { status in

                   

                }
               
            }
            
        }
        else
        {
            
        }
            
           // duration = duration > 1.3 ? 1 : duration
            
           /* UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations:
            {
                if  velocity.y >= 0
                {
                    self.view.frame = CGRect(x: 0, y: self.btnClick.frame.origin.y + self.btnClick.frame.height + 80, width: self.view.frame.width, height: self.view.frame.height)
                   // print(self.partialView - 50)
                   // print(self.view.frame.height)
                   // self.btnExpandMore.isSelected = false
                } else {
                    self.view.frame = CGRect(x: 0, y: self.Fullview - 80, width: self.view.frame.width, height: self.view.frame.height)
                  //  print(self.fullView)
                  //  print(self.view.frame.height)
                   // self.btnExpandMore.isSelected = true
                }
                
            }, completion: { [weak self] _ in
                if (velocity.y < 0) {
                    //                        self?.tableView.isScrollEnabled = true
                }
            })*/
        }
        else
        {
            print("CUSTOME1",y)
            print("DSDSD1",Fullview - self.viewBackDetail.frame.height)
            
            print("VELOCITY1",velocity.y)
            
            print("TRANSLATION1",translation.y)
            
            let y = viewBackDetail.frame.minY
            
           
            print(Fullview - self.viewBackDetail.frame.height + 30)
            print("Y POS1 VIEWMAIN",viewBackDetail.frame.origin.y + 50)
            
           // if (y + translation.y >= fullView) && (y + translation.y <=  btnClick.frame.origin.y + btnClick.frame.height + 20)
            print("Y1",y)
            print("FULL VIEW1",Fullview)
            
            print("BUTTon1",btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 20)
            
            if velocity.y < 0
            {
                if y > Fullview - self.viewBackDetail.frame.height
                {
                    self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
                else
                {
                    self.viewBackDetail.frame = CGRect(x: 0, y: Fullview - self.viewBackDetail.frame.height, width: view.frame.width, height: viewBackDetail.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
               
                   
               /* }
                else
                {
                    self.viewMain.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewMain.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }*/
                print("HEIGHT after change",viewBackDetail.frame.height)
            }
            else if velocity.y == 0.0
            {
                self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
            }
            else
            {
               
                    self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
               
              //  viewMainHeightConstant.constant = Fullview - 80
            }
            
            /* self.viewMain.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: btnClick.frame.origin.y + btnClick.frame.height + 20)
            recognizer.setTranslation(CGPoint.zero, in: self.viewMain)*/
        //}
      /*  if (y + translation.y <=  btnClick.frame.origin.y + btnClick.frame.height + 20)
        {
           // self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
          //  recognizer.setTranslation(CGPoint.zero, in: self.view)
            
         //   viewMainHeightConstant.constant = y + translation.y
         //  recognizer.setTranslation(CGPoint.zero, in: self.view)
        }*/
    
        if recognizer.state == .ended
        {
            print("ENDED")
           // var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y)
            
            print("TOUCH ENDED",velocity.y)
            
           /* UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations:
            {
               /* self.viewMain.frame = CGRect(x: 0, y: self.Fullview - self.viewMain.frame.height + 30, width: self.view.frame.width, height: self.viewMain.frame.height)
                recognizer.setTranslation(CGPoint.zero, in: self.view)*/
                
                self.view.removeFromSuperview()
            }, completion: { [weak self] _ in
                if (velocity.y < 0) {
                    //                        self?.tableView.isScrollEnabled = true
                }
            })*/
            if velocity.y > 0
            {
                
                UIView.animate(withDuration: 1.0) {

                   
                    //self.view.layoutIfNeeded()
                   
                  //  self.view.removeFromSuperview()
                    
                   // self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
                  //  self.view.frame.origin.y = self.view.frame.height

                } completion: { status in

                    self.view.removeFromSuperview()

                }
               
            }
            
            
        }
        else
        {
            
        }
     }
    }
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setUIOnScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.bleManager?.cancelCurrentConnect()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let yComponent = UIScreen.main.bounds.height - UIScreen.main.bounds.height
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        } completion: { status in
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut) {
                self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.5)
            } completion: { stat in
                
            }
        }
        
    }
    
    
    // ********** All Button Actions ********** //
    
    @IBAction func btnStuckOkayClicked(_ sender: Any)
    {
        self.viewStuckLock.removeFromSuperview()
        
        let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
      //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
      //  UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(ongoing, animated: true)
    }
    
    @IBAction func btnArrowDownClicked(_ sender: Any)
    {
        
        UIView.animate(withDuration: 0.3)
        {
           // self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            self.view.frame.origin.y = self.view.frame.height
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
       // self.view.removeFromSuperview()
    }
    @IBAction func btnConfirmationCancelClicked(_ sender: Any)
    {
        self.viewConfirmationPopup.removeFromSuperview()
    }
    @IBAction func btnConfirmationOkayClicked(_ sender: Any)
    {
        if setGPRSBLEVal == false
        {
            print("GPRS")
        }
        else
        {
            print("BLE")
            
            self.viewConfirmationPopup.removeFromSuperview()
            
           // centralManager = CBCentralManager(delegate: self, queue: nil)
          //  centralManager = CBCentralManager(delegate: nil, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey:true])
            
             self.bleManager = OmniBleManager()
             self.bleManager?.delegate = self
             self.bleClient = BikeLockClient()
             self.bleClient?.delegate = self
             self.bleManager?.scanDevices()
             
        }
    }
    @IBAction func ActionProceedToPay(_ sender: UIButton)
    {
        
        if CLLocationManager.locationServicesEnabled()
        {
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways
            {
                 
                /*
                 if strRechargeAmt == "0"
                 {
                     btnProceedToPay.setTitle("PROCEED TO UNLOCK", for: UIControl.State.normal)
                 }
                 else
                 {
                     btnProceedToPay.setTitle("PROCEED TO PAY", for: UIControl.State.normal)
                 }
                 */
                let strCheckLock = btnProceedToPay.titleLabel?.text
                
                if strCheckLock == "PROCEED TO UNLOCK"
                {
                    var currentLocation = CLLocation()
                    currentLocation = locationManager.location!
                    print(currentLocation.coordinate.latitude)
                    print(currentLocation.coordinate.longitude)
                    
                    self.addSubscriptionAPICall(lat: "\(currentLocation.coordinate.latitude)", long: "\(currentLocation.coordinate.longitude)")
                    
                  //  print("PRCEED",strCheckLock!)
                }
                else
                {
                    self.addSubscriptionPlanAPICall()
                }
               
                
            }
            else
            {
                print("No Access")
                AlertView.instance.showAlert(message: strLocationPrivacy, image: "IC_ErrorIcon", alertType: .success)
            }
            
        }
        else
        {
            
            print("Location services are not enabled")
            AlertView.instance.showAlert(message: strLocationEnable, image: "IC_ErrorIcon", alertType: .success)
        }
        
        
    }
    func addSubscriptionAPICall(lat: String, long: String)
    {
        //dicSubscriptionPlan
        
        print(dicSubscriptionPlan)
        let idUserSubscription = dicSubscriptionPlan["idUserSubscriptions"] as! Int
        let startDate = dicSubscriptionPlan["end_date"] as! String
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.addSubscriptionAPICall(dictionary: ["idUserSubscriptions": "\(idUserSubscription)", "idStations": "\(strStationID)", "startDate":"\(startDate)", "user_subscribed":"true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                if dicCycleData["lockType"] as! String == "GPRS"
                {
                    setGPRSBLEVal = false
                    self.BTCGRPSycleValidateAPICall(lat: "\(lat)", long: "\(long)")
                }
                else
                {
                    setGPRSBLEVal = true
                    self.BTCycleValidateAPICall(lat: "\(lat)", long: "\(long)")
                }
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
    //MARK: - GRPS check dialog
    
    func BTCGRPSycleValidateAPICall(lat: String, long: String)
    {
        /*let idUserSubscription = (arrSubscriptionDetail[0] as! [String: Any])["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = (arrSubscriptionDetail[0] as! [String: Any])["payasyougo1"] as! Int*/
        
        let idUserSubscription = dicSubscriptionPlan["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo =  dicSubscriptionPlan["payasyougo1"] as! Int
        
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.BTCycleValidateGPRSAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":lat, "long":long, "payasyougo":"\(payasugo)", "idUserSubscriptions": "\(idUserSubscription)", "home": "true","buzz" : "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                self.view.layoutIfNeeded()
                
                self.viewConfirmationPopup.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(viewConfirmationPopup)
                
                //Unlock-MYBYK
                do {
                    let gif = try UIImage(gifName: "Unlock-MYBYK")
                    self.imgConfirmation.setGifImage(gif, loopCount: -1)
                    
                } catch {
                    
                }
                
                 /*
                  setGPRSBLEVal = false
                  self.BTCGRPSycleValidateAPICall(lat: "\(lat)", long: "\(long)")
              }
              else
              {
                  setGPRSBLEVal = true
                  self.BTCycleValidateAPICall(l
                  */
              //  viewUnlockReconfirmSubview.layer.cornerRadius = 8.0
              //  btnUnlockReconfirm.layer.cornerRadius = 8.0
              //  btnUnlockCancel.layer.cornerRadius = 8.0
                
              //  self.btnUnlockReconfirm.shadowSecondaryView(frame: self.btnUnlockReconfirm.frame)
               // self.btnUnlockCancel.shadowSecondaryView(frame: self.btnUnlockCancel.frame)
                
             
//                if self.dicCycleData["lockType"] as! String == "GPRS"
//                {
//                    // Set GPRS flow
//                }
//                else
//                {
//
//                    self.bleManager = OmniBleManager()
//                    self.bleManager?.delegate = self
//                    self.bleClient = BikeLockClient()
//                    self.bleClient?.delegate = self
//                    self.bleManager?.scanDevices()
//                }
                
              /*  BuzzPop.instance.showBuzzPopup(title: "Did you hear the beep from the cycle?", message: "You will see an LED blinking and hear a beep of you bike lock. Make sure spoke is not touching the latch.", animationName: "buzz_bell")
                BuzzPop.instance.ActionBuzzAgain = {
                    
                    self.BTCycleValidateAPICall(lat: lat, long: long)
                }
                BuzzPop.instance.ActionYesIDid = { [self]
                    
                    if self.dicCycleData["lockType"] as! String == "GPRS"
                    {
                        // Set GPRS flow
                    }
                    else
                    {
                        
                        self.bleManager = OmniBleManager()
                        self.bleManager?.delegate = self
                        self.bleClient = BikeLockClient()
                        self.bleClient?.delegate = self
                        self.bleManager?.scanDevices()
                    }
                }*/
                
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
// MARK:- All Custom Functions
// ************************************ //
class InsetLabel: UILabel
{
    override func drawText(in rect: CGRect)
    {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)))
    }
}
extension SubscriptionDetailVC : PaymentBackToProceedToUnlockDelegateProtocol
{
    func sendSearchLocationLatLong(DicPass: [String : Any])
    {
       // dicSubscriptionPlan = DicPass
        
        print(DicPass)
        
        
       // dicSubscriptionPlan["subscriptionAmount"] = DicPass["subscriptionAmount"]
     //   self.setUIOnScreen()
        
        
        
        //subscriptionAmount
        
        /*
         "subscription_details" =     {
                 creditLabel = "MYBYK CREDITS";
                 freeUsage = "";
                 netCharges = "\U20b90";
                 netChargesLabel = "Net Charges";
                 rechargeAmountLabel = "Recharge Amount";
                 "recharge_amount" = 0;
                 rentalChargeLabel = "";
                 "ride_charges" =         (
                 );
                 ridechargeconsiderforlatecharge = 0;
                 securityDepositPaid = "";
                 securityDepositPaidLabel = "";
                 subscripitonLateChargeLabel = "Late Return Charges";
                 subscriptionAmount = 1;
                 subscriptionChargesLabel = "Subscription Charges";
                 subscriptionDepositAmount = Paid;
                 subscriptionDepositAmountLabel = "Security Deposit (Refundable)";
                 subscriptionValidityLabel = "Subscription Validity";
                 tbDuration = "";
                 tbDurationWiseCharge = "";
                 userCreditPoints = "- \U20b9 1";
                 walletBalance = "";
                 walletBalanceLabel = "";
             };

         */
        
        if DicPass["creditLabel"] != nil
        {
            dicSubscriptionPlan["creditLabel"] = DicPass["creditLabel"]
        }
        if DicPass["freeUsage"] != nil
        {
            dicSubscriptionPlan["freeUsage"] = DicPass["freeUsage"]
        }
        if DicPass["netCharges"] != nil
        {
            dicSubscriptionPlan["netCharges"] = DicPass["netCharges"]
        }
        if DicPass["netChargesLabel"] != nil
        {
            dicSubscriptionPlan["netChargesLabel"] = DicPass["netChargesLabel"]
        }
        if DicPass["rechargeAmountLabel"] != nil
        {
            dicSubscriptionPlan["rechargeAmountLabel"] = DicPass["rechargeAmountLabel"]
        }
        if DicPass["recharge_amount"] != nil
        {
            dicSubscriptionPlan["recharge_amount"] = DicPass["recharge_amount"]
        }
        if DicPass["rentalChargeLabel"] != nil
        {
            dicSubscriptionPlan["rentalChargeLabel"] = DicPass["rentalChargeLabel"]
        }
        if DicPass["ridechargeconsiderforlatecharge"] != nil
        {
            dicSubscriptionPlan["ridechargeconsiderforlatecharge"] = DicPass["ridechargeconsiderforlatecharge"]
        }
        if DicPass["securityDepositPaid"] != nil
        {
            dicSubscriptionPlan["securityDepositPaid"] = DicPass["securityDepositPaid"]
        }
        if DicPass["securityDepositPaidLabel"] != nil
        {
            dicSubscriptionPlan["securityDepositPaidLabel"] = DicPass["securityDepositPaidLabel"]
        }
        if DicPass["subscripitonLateChargeLabel"] != nil
        {
            dicSubscriptionPlan["subscripitonLateChargeLabel"] = DicPass["subscripitonLateChargeLabel"]
        }
       /* if DicPass["subscriptionAmount"] != nil
        {
            dicSubscriptionPlan["subscriptionAmount"] = DicPass["subscriptionAmount"]
        }*/
        if DicPass["subscriptionChargesLabel"] != nil
        {
            dicSubscriptionPlan["subscriptionChargesLabel"] = DicPass["subscriptionChargesLabel"]
        }
        if DicPass["subscriptionDepositAmount"] != nil
        {
            dicSubscriptionPlan["subscriptionDepositAmount"] = DicPass["subscriptionDepositAmount"]
        }
        if DicPass["subscriptionDepositAmountLabel"] != nil
        {
            dicSubscriptionPlan["subscriptionDepositAmountLabel"] = DicPass["subscriptionDepositAmountLabel"]
        }
        if DicPass["subscriptionValidityLabel"] != nil
        {
            dicSubscriptionPlan["subscriptionValidityLabel"] = DicPass["subscriptionValidityLabel"]
        }
        if DicPass["tbDuration"] != nil
        {
            dicSubscriptionPlan["tbDuration"] = DicPass["tbDuration"]
        }
        if DicPass["tbDurationWiseCharge"] != nil
        {
            dicSubscriptionPlan["tbDurationWiseCharge"] = DicPass["tbDurationWiseCharge"]
        }
        if DicPass["userCreditPoints"] != nil
        {
            dicSubscriptionPlan["userCreditPoints"] = DicPass["userCreditPoints"]
        }
        if DicPass["walletBalance"] != nil
        {
            dicSubscriptionPlan["walletBalance"] = DicPass["walletBalance"]
        }
        if DicPass["walletBalanceLabel"] != nil
        {
            dicSubscriptionPlan["walletBalanceLabel"] = DicPass["walletBalanceLabel"]
        }
        let StrStationIDCovert = DicPass["recharge_amount"] as! Int
      
        print(StrStationIDCovert)
        if StrStationIDCovert == 0
        {
            print(dicSubscriptionPlan)
           btnProceedToPay.titleLabel?.text = "PROCEED TO UNLOCK"
            var currentLocation = CLLocation()
            currentLocation = locationManager.location!
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            self.addSubscriptionAPICall(lat: "\(currentLocation.coordinate.latitude)", long: "\(currentLocation.coordinate.longitude)")
        }
        else
        {
            
        }
        //recharge_amount
        
        print(dicSubscriptionPlan)
       // subDetail.dicSubscriptionPlan = DicPass
    }
    
    
}

extension SubscriptionDetailVC
{
    
    func setUIOnScreen()
    {
        /*
         let content = strHTML
                 let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                             NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
                             NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html
                         ]
                 let attrStr = try! NSAttributedString(data: content.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: options, documentAttributes: nil)
                 self.lblNotes.attributedText = attrStr
         */
        var CovertID  = String()
        var strSubAmnt : String!
        
        self.view.alpha = 1.0
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
        self.btnProceedToPay.layer.cornerRadius = 10.0
        viewSubscriptionDetail.layer.cornerRadius = 5.0
        LbDetails.layer.cornerRadius = 5.0
        LbDetails.clipsToBounds = true
       // lbDetails.padding(15, 15, 15, 15)
      //  lbDetails = sampleLabel(frame: CGRect(x: lbDetails.frame.origin.x, y: lbDetails.frame.origin.y, width: lbDetails.frame.width, height: lbDetails.frame.height))
      //  let lb =
      //  lbDetails = EdgeInsetLabel()
      //  lbDetails.textInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
       // txtDetail.layer.cornerRadius = 8.0
    //    lbDetails.layer.cornerRadius = 8.0
      //  lbDetails.clipsToBounds = true
        
       
      //  lbDetails.drawText(in: CGRect(x: lbDetails.frame.origin.x, y: lbDetails.frame.origin.y, width: lbDetails.frame.width, height:lbDetails.frame.height))

        viewConfirmationInnerPopup.layer.cornerRadius = 8.0
        imgConfirmation.clipsToBounds = true
        imgConfirmation.layer.cornerRadius = 15.0
        btnOkay.layer.cornerRadius = 10.0
        
        
        btnStuckOkay.layer.cornerRadius = 10.0
        viewStuckInner.layer.cornerRadius = 8.0
        
        imgStuck.layer.borderWidth = 1.0
        imgStuck.layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        imgStuck.layer.cornerRadius = 10.0
        
        imgStuck.clipsToBounds = true
        imgStuck.layer.cornerRadius = 15.0
        
        viewBackDetail.roundCorners(corners: [.topLeft, .topRight], radius: 8.0, rect: self.view.frame)
       // self.viewBackScrollMainWidth.constant = self.view.frame.width
        
        self.macAddress = "\(dicCycleData["macAddress"] as! String)"
        
        print(dicSubscriptionPlan)
        //idUserSubscriptions
        //recharge_amount
        //deviceType
        //subscription_details object ne replace kravano
        //WsAddBalance
        
        lbConfirmationLockNumber.text = dicCycleData["QRCode"] as? String
        
        /*
         creditLabel = "MYBYK CREDITS";
               freeUsage = "";
               netCharges = "\U20b90";
               netChargesLabel = "Net Charges";
               rechargeAmountLabel = "Recharge Amount";
               "recharge_amount" = 0;
               rentalChargeLabel = "";
               "ride_charges" =         (
               );
               ridechargeconsiderforlatecharge = 0;
               securityDepositPaid = "";
               securityDepositPaidLabel = "";
               subscripitonLateChargeLabel = "Late Return Charges";
               subscriptionAmount = 1;
               subscriptionChargesLabel = "Subscription Charges";
               subscriptionDepositAmount = Paid;
               subscriptionDepositAmountLabel = "Security Deposit (Refundable)";
               subscriptionValidityLabel = "Subscription Validity";
               tbDuration = "";
               tbDurationWiseCharge = "";
               userCreditPoints = "- \U20b9 1";
               walletBalance = "";
               walletBalanceLabel = "";
         */
        if dicSubscriptionPlan["subscriptionNameCapital"] != nil
        {
            self.lblPlanTitle.text = "\(dicSubscriptionPlan["subscriptionNameCapital"] as! String)"
            // now val is not nil and the Optional has been unwrapped, so use it
        }
        
       
 
        let arrRideCharge = dicSubscriptionPlan["ride_charges"] as! [Any]
        
        var dicRideCharge = [String: Any]()
        
        if arrRideCharge.count != 0 {
            
            dicRideCharge = arrRideCharge[0] as! [String: Any]
        }
        
        /*
         @IBOutlet var viewSubscriptionDetail: UIView!
         @IBOutlet var lblPlanTitle: UILabel!
         @IBOutlet var lbSubscriptionCharge: UILabel!
         @IBOutlet var lbSubscriptionChargeValue: UILabel!
         @IBOutlet var lbSubscriptionValidity: UILabel!
         @IBOutlet var lbSubscriptionValidityValue: UILabel!
         @IBOutlet var lbLateReturnCharge: UILabel!
         @IBOutlet var lbLateReturnChargeValue: UILabel!
         @IBOutlet var lbDetails: UILabel!
         @IBOutlet var lbSubscriptionChargeSecond: UILabel!
         @IBOutlet var lbSubscriptionChargeSecondValue: UILabel!
         @IBOutlet var lbMyCredit: UILabel!
         @IBOutlet var lbMyCreditValue: UILabel!
         @IBOutlet var lbWallet: UILabel!
         @IBOutlet var lbWalletValue: UILabel!
         @IBOutlet var lbNetCharge: UILabel!
         @IBOutlet var lbNetChargeValue: UILabel!
         @IBOutlet var lbSecurityDeposite: UILabel!
         @IBOutlet var lbSecurityDepoValue: UILabel!
         @IBOutlet var lbRechargeAmnt: UILabel!
         @IBOutlet weak var lblToPayAmount: UILabel!
         */
        
        // Top Charges ₹
        lbSubscriptionCharge.text = "\(dicSubscriptionPlan["subscriptionChargesLabel"] as! String)"
        
        //print(dicSubscriptionPlan["subscriptionAmount"] as! String)
        
        
       
        print(dicSubscriptionPlan["subscriptionAmount"]!)
        
        if let StrStationID = dicSubscriptionPlan["subscriptionAmount"] as? String
        {
            CovertID = StrStationID
        }
        else
        {
            //strSubAmnt = "₹ \(dicSubscriptionPlan["subscriptionAmount"] as! String)"
            let StrStationIDCovert = dicSubscriptionPlan["subscriptionAmount"]
            CovertID = "\(StrStationIDCovert as! Int)"
        }
        
        strSubAmnt = "₹ \(CovertID)"
        
        print(strSubAmnt!)
       // let strSubAmnt = "₹ \(dicSubscriptionPlan["subscriptionAmount"] as! String)"
        //String(format: "₹ %d", dicSubscriptionPlan["subscriptionAmount"])
        let attributedString = NSMutableAttributedString(string: strSubAmnt)
        //let font = UIFont(name: "Rubik Bold", size: 15.0)
        
        print(attributedString)
        DispatchQueue.main.async {
            
            attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 15.0)!, range: NSRange.init(location: 0, length: 1))
            
            self.lbSubscriptionChargeValue.attributedText = attributedString
        }
      

        lbSubscriptionValidity.text = "\(dicSubscriptionPlan["subscriptionValidityLabel"] as! String)"
        
        if dicSubscriptionPlan["subscriptionDuration"] != nil
        {
            lbSubscriptionValidityValue.text = "\(dicSubscriptionPlan["subscriptionDuration"] as! String)"
            // now val is not nil and the Optional has been unwrapped, so use it
        }
       
        
     //   viewChargeHeightConstant.constant = 100
        viewChargeHeightConstant.constant = 100
        print("CONSTANT",viewChargeHeightConstant.constant)
        if (dicSubscriptionPlan["ridechargeconsiderforlatecharge"] as! Int) == 0 && (dicSubscriptionPlan["ride_charges"] as! NSArray).count != 0
        {
          //  lbSubscriptionCharge.text = "Sample1"
            
       //     lbSubscriptionCharge.text = "\(dicSubscriptionPlan["subscriptionChargesLabel"] as! String)"
       //     lbSubscriptionChargeValue.text = "\(dicSubscriptionPlan["subscriptionAmount"] as! String)"
            
            lbSubscriptionValidityConst.constant = 25
           
        //    viewChargeHeightConstant.constant = 210
            print("CONSTANT",viewChargeHeightConstant.constant)
         //   viewChargeHeightConstant.constant =
            
            lbSubscriptionValidity.text = "\(dicSubscriptionPlan["subscriptionValidityLabel"] as! String)"
            lbSubscriptionValidityValue.text = "\(dicSubscriptionPlan["subscriptionDuration"] as! String)"
            
            lbLateReturnCharge.text = "\(dicSubscriptionPlan["rideChargesLabel"] as! String)"
            
            let aryCount = dicSubscriptionPlan["ride_charges"] as! NSArray
            
            if aryCount.count == 0
            {
                
            }
            else
            {
                let valuDic = aryCount[0] as! NSDictionary
                lbLateReturnChargeValue.text = String(format: "%@ / %@", valuDic.value(forKey: "amount") as! CVarArg,valuDic.value(forKey: "time") as! CVarArg)
            }
            viewChargeHeightConstant.constant = 100
        }
        
        /*
         //  viewChargeHeightConstant.constant = 20
        //   print("Constant",viewChargeHeightConstant.constant)
          /* let normalText = dicRideCharge["time"] as! String

           let boldText  = dicRideCharge["amount"] as! String

           let attributedString1 = NSMutableAttributedString(string:normalText)
           
           let attributedString = NSMutableAttributedString(string:boldText)

           //Rubik Bold 20.0
           let attrs = [NSAttributedString.Key.font : UIFont(name:"Rubik Bold", size: 15.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_Primary")]
           let boldString = NSMutableAttributedString(string: boldText, attributes:attrs as [NSAttributedString.Key : Any])

           boldString.append(attributedString1)
           
           lblRideChargeAmount.attributedText = boldString*/
         */
        
        /*
         //BRTS PLAN RIDE Charges

                    if (subscriptionDetails?.rideChargesLabel?.isNotEmpty() == true && subscriptionDetails?.ridechargeconsiderforlatecharge == 1){
                            view.txtChargeDurationLbl.visibility = View.GONE
                            view.txtChargeDuration.visibility = View.GONE
                            view.txtCharge.text = subscriptionDetails?.rideChargesLabel

                        if (subscriptionDetails?.subscriptionAmount.equals("Free")) {
                            val normalText = "<font color='#555555'>" + " / " + subscriptionDetails?.subscriptionDuration + "</font>"
                            val s = SpannableStringBuilder()
                                .bold { append(subscriptionDetails?.subscriptionAmount + " ")}
                                .append(Html.fromHtml(" $normalText"))
                            view.txtChargeAmt.text = s
                        }else{
                            val normalText = "<font color='#555555'>" + " / " + subscriptionDetails?.subscriptionDuration + "</font>"
                            val s = SpannableStringBuilder()
                                .bold { append(currencySymbol + " " +
                                        subscriptionDetails?.subscriptionAmount + " ") }
                                .append(Html.fromHtml(" $normalText"))
                            view.txtChargeAmt.text = s
                        }
                    }
         */
        
        //BRTS PLAN RIDE Charges
        if "\(dicSubscriptionPlan["rideChargesLabel"] as! String)" != "" && (dicSubscriptionPlan["ridechargeconsiderforlatecharge"] as! Int) == 1
        {
            //lbSubscriptionCharge.text = "Sample2"
            
            lbSubscriptionValidity.text = ""
            lbSubscriptionValidityValue.text = ""
            lbSubscriptionValidityConst.constant = 0
          
            print("CONSTANT",viewChargeHeightConstant.constant)
            lbSubscriptionCharge.text =  "\(dicSubscriptionPlan["rideChargesLabel"] as! String)"
         
            /*
             print(dicSubscriptionPlan["subscriptionAmount"]!)
             if let StrStationID = dicSubscriptionPlan["subscriptionAmount"] as? String
             {
                 CovertID = StrStationID
             }
             else
             {
                 //strSubAmnt = "₹ \(dicSubscriptionPlan["subscriptionAmount"] as! String)"
                 let StrStationIDCovert = dicSubscriptionPlan["subscriptionAmount"]
                 CovertID = "\(StrStationIDCovert as! Int)"
             }
             */
            
            //strSubAmnt
            //if "\(dicSubscriptionPlan["subscriptionAmount"] as! String)" == "Free"
            print(strSubAmnt!)
            if strSubAmnt == "Free"
            {
              // lbSubscriptionCharge.text = "Sample3"
                
                let strCharge = dicSubscriptionPlan["subscriptionDuration"] as! String
                let strAmnt = dicSubscriptionPlan["subscriptionAmount"] as! String
                
                let strSubAmn = String(format: "₹ %@ / %@", strAmnt,strCharge)
                let attributedString = NSMutableAttributedString(string: strSubAmn)
                
                let font = UIFont(name: "Rubik Bold", size: 15.0)
                let color = UIColor(named: "Color_N_Dark200")
                let color1 = UIColor(named: "Color_N_Dark900")
                
                attributedString.addAttribute(NSAttributedString.Key.font, value:font!, range: NSRange.init(location: 0, length: strCharge.count))
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: NSRange.init(location: 0, length: strCharge.count))
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color1!, range: NSRange(location: strCharge.count + 5, length: strAmnt.count))
                
                lbSubscriptionChargeValue.attributedText = attributedString
            }
            else
            {
              //  lbSubscriptionCharge.text = "Sample4"
                
                lbSubscriptionCharge.text =  "\(dicSubscriptionPlan["rideChargesLabel"] as! String)"
                
                let strCharge = dicSubscriptionPlan["subscriptionDuration"] as! String
                let strAmnt = strSubAmnt
                //"₹ \(dicSubscriptionPlan["subscriptionAmount"] as! String)"
                
                let strSubAmn = String(format: "%@ / %@", strAmnt!,strCharge)
                let attributedString = NSMutableAttributedString(string: strSubAmn)
                
                //
               
                let color = UIColor(named: "Color_N_Dark200")
                let color1 = UIColor(named: "Color_Primary")
                
                DispatchQueue.main.async {
                    
                    self.fontForSubCharge = UIFont(name: "Rubik Bold", size: 15.0)
                    attributedString.addAttribute(NSAttributedString.Key.font, value:self.fontForSubCharge!, range: NSRange.init(location: 0, length: strAmnt!.count))
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color1!, range: NSRange.init(location: 0, length: strAmnt!.count))
                    
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: NSRange(location: strAmnt!.count + 1, length: strCharge.count + 2))
                    
                    self.lbSubscriptionChargeValue.attributedText = attributedString
                }
              
                
               
            }
            viewChargeHeightConstant.constant = 65
        }
        
        //LAte Return Charges
        if "\(dicSubscriptionPlan["subscripitonLateFee"] as! String)" == "" && "\(dicSubscriptionPlan["subscripitonLateChargeLabel"] as! String)" != ""
        {
            if (dicSubscriptionPlan["ridechargeconsiderforlatecharge"] as! Int) == 1
            {
                lbLateReturnCharge.text = dicSubscriptionPlan["subscripitonLateChargeLabel"] as? String
                
                if (dicSubscriptionPlan["ride_charges"] as! NSArray).count != 0
                {
                    let aryCount = dicSubscriptionPlan["ride_charges"] as! NSArray
                    let valuDic = aryCount[0] as! NSDictionary
                    lbLateReturnChargeValue.text = String(format: "%@ / %@", valuDic.value(forKey: "amount") as! CVarArg,valuDic.value(forKey: "time") as! CVarArg)
                   
                }
                
            }
         //   viewChargeHeightConstant.constant = 100
        }
        if "\(dicSubscriptionPlan["subscripitonLateFee"] as! String)" != ""
        {
          //  lbSubscriptionCharge.text = "Sample8"
            lbLateReturnCharge.text = dicSubscriptionPlan["subscripitonLateChargeLabel"] as? String
            lbLateReturnChargeValue.text = dicSubscriptionPlan["subscripitonLateFee"] as? String
          //  viewChargeHeightConstant.constant = 80
            print("CONSTANT1",viewChargeHeightConstant.constant)
          //  viewChargeHeightConstant.constant = 100
         //   viewChargeHeightConstant.constant = 40
         //   print("Constant",viewChargeHeightConstant.constant)
        }
       
        //Ride Charges when Unlimited Plan
        if (dicSubscriptionPlan["ridechargeconsiderforlatecharge"] as! Int) == 0 && (dicSubscriptionPlan["ride_charges"] as! NSArray).count != 0
        {
           // lbSubscriptionCharge.text = "Sample9"
            lbLateReturnCharge.text = dicSubscriptionPlan["rideChargesLabel"] as? String
            
            if (dicSubscriptionPlan["ride_charges"] as! NSArray).count != 0
            {
             //   lbSubscriptionCharge.text = "Sample10"
                let aryCount = dicSubscriptionPlan["ride_charges"] as! NSArray
                let valuDic = aryCount[0] as! NSDictionary
                lbLateReturnChargeValue.text = String(format: "%@ / %@", valuDic.value(forKey: "amount") as! CVarArg,valuDic.value(forKey: "time") as! CVarArg)
            }
           // viewChargeHeightConstant.constant = 100
        //    viewChargeHeightConstant.constant = 50
        //    print("Constant",viewChargeHeightConstant.constant)
        }
        
        //Bottom Charges
        if "\(dicSubscriptionPlan["subscriptionDepositAmount"] as! String)" == "Paid"
        {
         //   viewChargeHeightConstant.constant = 80
            print("CONSTANT2",viewChargeHeightConstant.constant)
         //   lbSubscriptionCharge.text = "Sample11"
              let boldText  = dicSubscriptionPlan["subscriptionDepositAmount"] as? String
              let attrs = [NSAttributedString.Key.font : UIFont(name:"Rubik Bold", size: 15.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_Primary")]
            let boldString = NSMutableAttributedString(string: boldText!, attributes:attrs as [NSAttributedString.Key : Any])
             lbSecurityDepoValue.attributedText = boldString
            
          //  viewChargeHeightConstant.constant = 100
        }
        else
        {
           // lbSubscriptionCharge.text = "Sample12"
            let boldText = dicSubscriptionPlan["subscriptionDepositAmount"] as? String
            let attrs = [NSAttributedString.Key.font : UIFont(name:"Rubik Bold", size: 15.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_N_Dark200")]
            let boldString = NSMutableAttributedString(string: boldText!, attributes:attrs as [NSAttributedString.Key : Any])
           lbSecurityDepoValue.attributedText = boldString
          //  viewChargeHeightConstant.constant = 100
        }
        
        //Ride Charges
        if "\(dicSubscriptionPlan["rentalChargeLabel"] as! String)" == ""
        {
         //   lbSubscriptionCharge.text = "Sample13"
            
           // if "\(dicSubscriptionPlan["subscriptionAmount"] as! String)" == "Free"
            print(strSubAmnt!)
            if strSubAmnt == "Free"
            {
              //  lbSubscriptionCharge.text = "Sample14"
                lbSubscriptionChargeSecondValue.text = " " + "\(dicSubscriptionPlan["subscriptionAmount"] as! String)"
            }
            else
            {
             //   viewChargeHeightConstant.constant = 80
                print("CONSTANT3",viewChargeHeightConstant.constant)
            //    lbSubscriptionCharge.text = "Sample15"
                //Add currency symbol back
                
               // lbSubscriptionChargeSecondValue.text = "₹" + " " + "\(dicSubscriptionPlan["subscriptionAmount"] as! String)"
                lbSubscriptionChargeSecondValue.text = strSubAmnt
            }
           // viewChargeHeightConstant.constant = 100
         //   viewChargeHeightConstant.constant = 60
         //   print("Constant",viewChargeHeightConstant.constant)
        }
        else
        {
          //  lbSubscriptionCharge.text = "Sample16"
         
            lbSubscriptionChargeSecond.text = "\(dicSubscriptionPlan["rentalChargeLabel"] as! String)"
            
            //if "\(dicSubscriptionPlan["subscriptionAmount"] as! String)" == "Free"
            print(strSubAmnt!)
            if strSubAmnt == "Free"
            {
               // lbSubscriptionCharge.text = "Sample17"
                
                lbSubscriptionChargeSecondValue.text = " " + "\(dicSubscriptionPlan["subscriptionAmount"] as! String)"
            }
            else
            {
              //  lbSubscriptionCharge.text = "Sample18"
                //Add currency symbol back
              //  lbSubscriptionChargeSecondValue.text = "₹" + " " + "\(dicSubscriptionPlan["subscriptionAmount"] as! String)"
                lbSubscriptionChargeSecondValue.text =  strSubAmnt
            }
       //     viewChargeHeightConstant.constant = 100
        //    lbSubscriptionCharge.text = "\(dicSubscriptionPlan["subscriptionChargesLabel"] as! String)"
        //    viewChargeHeightConstant.constant = 70
        //    print("Constant",viewChargeHeightConstant.constant)
        }
        
        // MYBYK Credit
        
        if "\(dicSubscriptionPlan["creditLabel"] as! String)" != "" && "\(dicSubscriptionPlan["userCreditPoints"] as! String)" != ""
        {
         //   lbSubscriptionCharge.text = "Sample19"
            var i = 0
            var strFinalCredit : String!
            
            let strCreditdata = dicSubscriptionPlan["creditLabel"] as! String
            let strCredit = strCreditdata.components(separatedBy:" ")
            
           
            strCredit.forEach { value in
                
                if i == 0
                {
                    strFinalCredit = value.uppercased()
                }
                else
                {
                    strFinalCredit = strFinalCredit + " " + value.capitalized
                }
                i += 1
            }
            lbMyCredit.text = strFinalCredit
            lbMyCreditValue.text = "\(dicSubscriptionPlan["userCreditPoints"] as! String)"
            
         //   viewChargeHeightConstant.constant = 100
         //   viewChargeHeightConstant.constant = 80
            print("CONSTANT4",viewChargeHeightConstant.constant)
         //   viewChargeHeightConstant.constant = 80
         //   lbSubscriptionCharge.text = "\(dicSubscriptionPlan["subscriptionChargesLabel"] as! String)"
          //  print("Constant",viewChargeHeightConstant.constant)
        }
        else
        {
           // lbSubscriptionCharge.text = "Sample20"
            
            lbMyCredit.text = ""
            lbMyCreditValue.text = ""
            
         //   viewChargeHeightConstant.constant = 100
        }
        
        // Wallet
        if "\(dicSubscriptionPlan["walletBalanceLabel"] as! String)" != "" && "\(dicSubscriptionPlan["walletBalance"] as! String)" != ""
        {
          //  viewChargeHeightConstant.constant = 80
            print("CONSTANT5",viewChargeHeightConstant.constant)
           // lbSubscriptionCharge.text = "Sample21"
            
         //   lbSubscriptionCharge.text = "\(dicSubscriptionPlan["subscriptionChargesLabel"] as! String)"
            
            lbWallet.text = "\(dicSubscriptionPlan["walletBalanceLabel"] as! String)"
            lbWalletValue.text = "\(dicSubscriptionPlan["walletBalance"] as! String)"
            
          //  viewChargeHeightConstant.constant = 100
        }
        else
        {
         //   lbSubscriptionCharge.text = "Sample22"
            
            lbWallet.text = ""
            lbWalletValue.text = ""
            
          //  viewChargeHeightConstant.constant = 100
        }
        
        
        // Net Charges
        if "\(dicSubscriptionPlan["netChargesLabel"] as! String)" != ""
        {
       //     viewChargeHeightConstant.constant = 80
            print("CONSTANT6",viewChargeHeightConstant.constant)
         //   lbSubscriptionCharge.text = "Sample23"
            
         //   lbSubscriptionCharge.text = "\(dicSubscriptionPlan["subscriptionChargesLabel"] as! String)"
            
            lbNetCharge.text = "\(dicSubscriptionPlan["netChargesLabel"] as! String)"
            lbNetChargeValue.text = "\(dicSubscriptionPlan["netCharges"] as! String)"
            
           // viewChargeHeightConstant.constant = 100
        }
        else
        {
         //   lbSubscriptionCharge.text = "Sample24"
            
            lbNetCharge.text = ""
            lbNetChargeValue.text = ""
            
          //  viewChargeHeightConstant.constant = 100
        }
        
        //Security Desposite
        if "\(dicSubscriptionPlan["subscriptionDepositAmountLabel"] as! String)" != "" && "\(dicSubscriptionPlan["subscriptionDepositAmount"] as! String)" != ""
        {
          //  lbSubscriptionCharge.text = "Sample25"
            
          //  lbSecurityDeposite.text = dicSubscriptionPlan["subscriptionDepositAmountLabel"] as? String
            
         //   viewChargeHeightConstant.constant = 80
            print("CONSTANT7",viewChargeHeightConstant.constant)
            let strCreditdata = dicSubscriptionPlan["subscriptionDepositAmountLabel"] as! String
            let strCredit = strCreditdata.components(separatedBy:" ")
            let aryLastObject = strCredit.last
            let range = (strCreditdata as NSString).range(of: aryLastObject!)
            let attributedString = NSMutableAttributedString(string:strCreditdata)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "Color_N_Dark200")! , range: range)
            lbSecurityDeposite.attributedText = attributedString
            
         //   viewChargeHeightConstant.constant = 100
        }
        else
        {
            lbSecurityDeposite.text = ""
          //  viewChargeHeightConstant.constant = 100
        }
        
        //Security Desposite already paid
        if "\(dicSubscriptionPlan["securityDepositPaidLabel"] as! String)" != "" && "\(dicSubscriptionPlan["securityDepositPaid"] as! String)" != ""
        {
           // /.text = "Sample27"
            
            lbSecurityDepoValue.text = "\(dicSubscriptionPlan["securityDepositPaidLabel"] as! String)"
            
            let strDepo = dicSubscriptionPlan["securityDepositPaidLabel"] as? String
            lbSecurityDepoValue.attributedText = strDepo?.htmlToAttributedString
            
        //    viewChargeHeightConstant.constant = 100
        }
//        else
//        {
//        //    lbSubscriptionCharge.text = "Sample28"
//
//            lbSecurityDeposite.text = ""
//            lbSecurityDepoValue.text = ""
//        }
        
        //Description
        if "\(dicSubscriptionPlan["description"] as! String)" != ""
        {
           // lbSubscriptionCharge.text = "Sample29"
            
            let htmlString = dicSubscriptionPlan["description"] as! String
            let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
            let attrStr = try? NSAttributedString( // do catch
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            
            //Rubik Regular 14.0
            
            let font = UIFont(name: "Rubik Regular", size: 14.0)
            let fontAttributes = [NSAttributedString.Key.font: font]
            
            let size = (htmlString as String).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
            
            print("HEIGHT",size.height)
            print("WEIGHT",size.width)
            
            
            let content = htmlString
                    let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                                NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
                                NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html
                            ]
                    let attrStrNew = try! NSAttributedString(data: content.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: options, documentAttributes: nil)
            
            
          /*  let yourOtherAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name:"Rubik Regular", size: 15.0)!]


            let strDisp = NSMutableAttributedString(string: htmlString as! string, attributes: yourOtherAttributes)
            
            let strDisp1 = NSMutableAttributedString(attributedString: strDisp)
            LbDetails.attributedText = strDisp1*/
            
            LbDetails.attributedText = attrStrNew
            
            
           // print(size.height)
           // print(LbDetails.frame.height)
           // txtHeightConst.constant = size.height + 20
            
            
            
           // lbDetails.frame = uied
           // UIEdgeInsetsInsetRect(textRect, insets)
           // lbDetails.attributedText = attrStr
            
           // let Desc = dicSubscriptionPlan["description"] as! String
    
           // lbDetails.attributedText = Desc.htmlToAttributedString
            
         //   viewChargeHeightConstant.constant = 100
        }
        else
        {
           // viewChargeHeightConstant.constant = 80
            print("CONSTANT8",viewChargeHeightConstant.constant)
           // lbSubscriptionCharge.text = "Sample30"
            
          //  lbDetails.text = ""
            
          //  viewChargeHeightConstant.constant = 100
        }
        
        // Recharge Amount
        //
        lblToPayAmount.text = String(format: "₹ %d", dicSubscriptionPlan["recharge_amount"] as! Int)
        
        let strRechargeAmt = String(format: "%d", dicSubscriptionPlan["recharge_amount"] as! Int)
        
        if strRechargeAmt == "0"
        {
            btnProceedToPay.setTitle("PROCEED TO UNLOCK", for: UIControl.State.normal)
        }
        else
        {
            btnProceedToPay.setTitle("PROCEED TO PAY", for: UIControl.State.normal)
        }
        
        if btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 20 > Fullview - 50
        {
            viewMainHeigthConst.constant = Fullview - 80
            scrollview.isScrollEnabled = true
            
            
            
            flagCheck = false
           /* let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe1(_:)))

                // Configure Swipe Gesture Recognizer
            swipeGestureRecognizerDown.direction = .down
            scrollview.addGestureRecognizer(swipeGestureRecognizerDown)*/
        }
        else
        {
            viewMainHeigthConst.constant = lbRechargeAmnt.frame.origin.y + 136 + 54
            //btnProceedToPay.frame.origin.y + btnProceedToPay.frame.height + 54 + lbDetails.frame.height
            scrollview.isScrollEnabled = false
            
            flagCheck = true
          /*  let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))

                // Configure Swipe Gesture Recognizer
            swipeGestureRecognizerDown.direction = .down
            scrollview.addGestureRecognizer(swipeGestureRecognizerDown)*/
            
          // let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToNewImage(_:)))
         //   swipeLeftGesture.direction = .t
          //  scrollview.addGestureRecognizer(swipeLeftGesture)
         //   var panGesture = UIPanGestureRecognizer(target: self, action:("handlePanGesture:"))
               // viewMain.addGestureRecognizer(panGesture)
            
        }
        //"₹ \(dicSubscriptionPlan["recharge_amount"] as! Int)"
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if touches.first?.view == self.view
        {
            
            UIView.animate(withDuration: 0.3)
            {
                
                self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
                self.view.frame.origin.y = self.view.frame.height
                
            } completion: { status in
                
                self.view.removeFromSuperview()
                
            }
        }
        
    }
    
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension SubscriptionDetailVC {
    
    func addSubscriptionPlanAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.addSubscriptionPlanAPICall(dictionary: ["idUserSubscriptions":"\(dicSubscriptionPlan["idUserSubscriptions"] as! Int)", "idStations": "\(strStationID)", "startDate": "\(dicSubscriptionPlan["end_date"] as! String)", "user_subscribed":"false"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            let dicAddSubscriptionData = response["data"] as! [String: Any]
            
            if response["is_error"] as! String == "false"
            {
                
                if dicCycleData["lockType"] as! String == "GPRS"
                {
                    
                    // Set GPRS flow
                    
                    self.GPRSCycleOutAPICall()
                }
                else {
                    
                    var currentLocation = CLLocation()
                    currentLocation = locationManager.location!
                    print(currentLocation.coordinate.latitude)
                    print(currentLocation.coordinate.longitude)
                    
                    self.BTCycleValidateAPICall(lat: "\(currentLocation.coordinate.latitude)", long: "\(currentLocation.coordinate.longitude)")
                }
                
            }
            else
            {
                
                if response["error_code"] as! String == "404"
                {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else if dicAddSubscriptionData["add_balance"] as! String == "true"
                {
                    
                    if let StrStationID = dicSubscriptionPlan["recharge_amount"] as? String
                     {
                         self.CovertAmnt = StrStationID
                     }
                     else
                     {
                         let StrStationIDCovert = dicSubscriptionPlan["recharge_amount"] as! Int
                         self.CovertAmnt  = "\(StrStationIDCovert )"
                     }
                     
                    let addMoney = self.storyboard?.instantiateViewController(withIdentifier: "AddMoneyVC") as! AddMoneyVC
                    addMoney.delegate = self
                  //  addMoney.strFrwdAmount = "\(dicSubscriptionPlan["recharge_amount"] as! String)"
                    print(dicSubscriptionPlan["idUserSubscriptions"] as! Int)
                    addMoney.strFrwdAmount = self.CovertAmnt
                    addMoney.IdSubscription = "\(dicSubscriptionPlan["idUserSubscriptions"] as! Int)"
                    
                    //String(format: "%d", dicSubscriptionPlan["idUserSubscriptions"] as! CVarArg) //"\(dicSubscriptionPlan["idUserSubscriptions"] as! String)"
                    addMoney.strForPaymentBack = "BackToChangeUnlock"
                    self.navigationController?.pushViewController(addMoney, animated: true)
                    
                    
                  /*  InsufficientBalance.instance.showInsufficientBalance(withTblData: dicAddSubscriptionData["add_bal_msg"] as! [Any])
                    InsufficientBalance.instance.ActionRecharge =
                    {
                        
                        print("Recharge Click")
                        let addMoney = self.storyboard?.instantiateViewController(withIdentifier: "AddMoneyVC") as! AddMoneyVC
                        addMoney.strFrwdAmount = "\(dicSubscriptionPlan["recharge_amount"] as! String)"
                        self.navigationController?.pushViewController(addMoney, animated: true)
                        
                    }
                    InsufficientBalance.instance.ActionCancel = {
                        
                        print("Cancel Click")
                    }*/
                }
                else
                {
                    
                    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func BTCycleValidateAPICall(lat: String, long: String) {
        
        let idUserSubscription = dicSubscriptionPlan["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = dicSubscriptionPlan["payasyougo1"] as! Int
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.BTCycleValidateAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":lat, "long":long, "payasyougo":"\(payasugo)", "idUserSubscriptions": "\(idUserSubscription)", "home": "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                self.view.layoutIfNeeded()
                
                self.viewConfirmationPopup.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(viewConfirmationPopup)
                
                //Unlock-MYBYK
                do {
                    let gif = try UIImage(gifName: "Unlock-MYBYK")
                    self.imgConfirmation.setGifImage(gif, loopCount: -1)
                    
                } catch {
                    
                }
                
               /* BuzzPop.instance.showBuzzPopup(title: "Did you hear the beep from the cycle?", message: "You will see an LED blinking and hear a beep of you bike lock. Make sure spoke is not touching the latch.", animationName: "buzz_bell")
                BuzzPop.instance.ActionBuzzAgain = {
                    
                    self.BTCycleValidateAPICall(lat: lat, long: long)
                }
                BuzzPop.instance.ActionYesIDid = {
                    
                    if dicCycleData["lockType"] as! String == "GPRS" {
                        
                        // Set GPRS flow
                    }
                    else {
                        
                        self.bleManager = OmniBleManager()
                        self.bleManager?.delegate = self
                        self.bleClient = BikeLockClient()
                        self.bleClient?.delegate = self
                        self.bleManager?.scanDevices()
                    }
                }*/
                
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
    @objc func timerHideUnlockSucccess()
    {
    //    self.isUnlock = false
       // self.isUnlock = true
        
        self.timer?.invalidate()
        self.viewUnlockLottie.stop()
        self.viewUnlockSuccessMail.removeFromSuperview()
        let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
      //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
      //  UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(ongoing, animated: true)
        
       /* let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
      //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
      //  UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(ongoing, animated: true)*/
    }
    func BlueToothCycleOutAPICall(strIsUnlock: String, strVoltage: String, strTimeStamp: String) {
        
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        let idUserSubscription = dicSubscriptionPlan["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = dicSubscriptionPlan["payasyougo1"] as! Int
        
        print(dicCycleData)
        print(dicSubscriptionPlan)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.BlueToothCycleOutAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":"\(currentLocation.coordinate.latitude)", "long":"\(currentLocation.coordinate.longitude)", "note":"", "payasyougo":"\(payasugo)", "terminalID":"\(strStationID)", "idUserSubscriptions": "\(idUserSubscription)", "isUnlock": strIsUnlock, "voltage":strVoltage, "timestamp":strTimeStamp]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                CommonClass.loadProgressHudCycling(viewController: self)
                
                self.viewUnlockSuccessMail.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(viewUnlockSuccessMail)
                
                self.viewUnlockLottie.contentMode = .scaleAspectFit
               self.viewUnlockLottie.loopMode = .playOnce
                self.viewUnlockLottie.animationSpeed = 0.9
                self.viewUnlockLottie.play()
               
               self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: false)
                
                self.bleClient?.sendUnlock(withUserId: 1, timestamp: Int32(self.getCurrentTimeStamp())!, outArea: false)
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
    
    func GPRSCycleOutAPICall() {
        
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        let idUserSubscription = dicSubscriptionPlan["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = dicSubscriptionPlan["payasyougo1"] as! Int
        
        print(dicCycleData)
        print(dicSubscriptionPlan)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.GPRSCycleOutAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":"\(currentLocation.coordinate.latitude)", "long":"\(currentLocation.coordinate.longitude)", "payasyougo":"\(payasugo)", "idUserSubscriptions": "\(idUserSubscription)", "home":"true", "buzz":"true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                
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

extension SubscriptionDetailVC : BikeLockCmdDelegate, BleManagerDelegate {
    
    func scanDevicesResult(_ lists: [LockDetailsItem])
    {
        
        self.listBleArray = [LockDetailsItem]()
        self.listBleArray = lists
        
        for item in listBleArray
        {
            if item.mac.uppercased() == self.macAddress.uppercased()
            {
                self.bleManager?.stopScan()
                self.bleManager?.connect(item.peripheral)
                isConnect = true
            }
        }
        
        if self.checkDeviceAvaibility == false
        {
            CommonClass.loadProgressHudCycling(viewController: self)
//            CommonClass.loadBottomlabelprogresshud(viewController: self, withText: "")
            self.checkDeviceAvaibility = true
            

            self.errorCaseOfAreYouStanding()
            
        }
    }
   
   
    func didDisconnectPeripheral(_ peripheral: CBPeripheral) {
        let toast = Toast(text: "didDisconnectPeripheral", delay: 0.0, duration: Delay.long)
        toast.show()
        
      //  print(peripheral)
    }
    
    func didFail(toConnect peripheral: CBPeripheral) {
        let toast = Toast(text: "didFail", delay: 0.0, duration: Delay.long)
        toast.show()
    }
    
    func passBikeCertification() {
        let toast = Toast(text: "passBikeCertification", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.bleClient?.obtainLockDetails()
    }
    
    func bikeLockDetailsCompletion(_ completion: BikeLockDetailsModel) {
        let toast = Toast(text: "bikeLockDetailsCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.lockDetails = completion
        print(self.lockDetails)
        self.BlueToothCycleOutAPICall(strIsUnlock: "false", strVoltage: "\(self.lockDetails.electricity)", strTimeStamp: self.lockDetails.timestamp)
    }
    
    func didConnectedPeripheral(_ peripheral: CBPeripheral)
    {
        let toast = Toast(text: "didConnectedPeripheral", delay: 0.0, duration: Delay.long)
        toast.show()
        
       /* self.view.layoutIfNeeded()
         
         self.viewConfirmationPopup.frame = (self.view.window?.bounds)!
         self.view.window?.addSubview(viewConfirmationPopup)
         
         self.viewLottieUnlock.contentMode = .scaleAspectFit
         self.viewLottieUnlock.loopMode = .playOnce
         self.viewLottieUnlock.animationSpeed = 0.5
         self.viewLottieUnlock.play()
        
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: true)*/
        
        
        self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
    }
    
    func bikeUnlockCompletion(_ completion: BikeLockUnlockModel)
    {
        let toast = Toast(text: "bikeUnlockCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
        BlutoothConnectivityIssue.instance.hidePopup()
        
        print(completion.isSuccess)
        if completion.isSuccess == true
        {
            
            self.viewConfirmationPopup.removeFromSuperview()
            
            let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
          //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
         //   UserDefaults.standard.synchronize()
            ongoing.isHome = true
            self.navigationController?.pushViewController(ongoing, animated: true)
            
           /* self.viewProceedPayAfterConfirmation.removeFromSuperview()
            
            let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
            ongoing.isHome = true
            self.navigationController?.pushViewController(ongoing, animated: true)*/
            
           /* self.view.layoutIfNeeded()
            
            self.viewUnlockSuccessMain.frame = (self.view.window?.bounds)!
            self.view.window?.addSubview(viewUnlockSuccessMain)
            
            self.viewLottieUnlock.contentMode = .scaleAspectFit
            self.viewLottieUnlock.loopMode = .playOnce
            self.viewLottieUnlock.animationSpeed = 0.5
            self.viewLottieUnlock.play()
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: true)
            */
        }
        else
        {
            
            self.viewConfirmationPopup.removeFromSuperview()
            
            
            self.view.layoutIfNeeded()
            
            self.viewStuckLock.frame = (self.view.window?.bounds)!
            self.view.window?.addSubview(viewStuckLock)
            
            //Unlock-MYBYK
            do {
                let gif = try UIImage(gifName: "unable_to_lock")
                self.imgStuck.setGifImage(gif, loopCount: -1)
                
            } catch {
                
            }
        }
        
       
        
    }
    
    func bikeLockedCompletion(_ completion: BikeLockLockedModel) {
        let toast = Toast(text: "bikeLockedCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
    }
    
    func errorCaseOfAreYouStanding()
    {
        //checkDeviceAvaibility
        
     /*
      EndRideTryRequest.instance.ActionTryEndingRideAgain = {
          
      }
      EndRideTryRequest.instance.ActionSubmitVideoEndRide = {
          
          self.getVideoRequestID()
          
      }
      */
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0)
        {
                
            if self.isConnect == false
            {
                self.checkDeviceAvaibility = false
                
                CommonClass.removeProgressHudCycling(viewController: self)
                
                self.bleManager?.stopScan()
                
                BlutoothConnectivityIssue.instance.showAlert(alertType: BlutoothConnectivityIssue.AlertTryAgain.success)
                
                BlutoothConnectivityIssue.instance.ActionTryAgain =
                {
                    self.isConnect = false
                    self.checkDeviceAvaibility = false
                    CommonClass.removeProgressHudCycling(viewController: self)
                    BlutoothConnectivityIssue.instance.hidePopup()
                   /* self.bleManager = OmniBleManager()
                    self.bleManager?.delegate = self
                    self.bleClient = BikeLockClient()
                    self.bleClient?.delegate = self
                    self.bleManager?.scanDevices()*/
                }
           //     print("BLUETOOTH CONNECTIVITY ISSUE?\n\nWe are facing an issue in connecting with the bike and need to switch on your device's Bluetooth and try again.")
                
//                CommonClass.removeBottomlabelprogresshud(viewController: self)
//
//                let alert = SCLAlertView()
//                alert.addButton("Try Again", actionBlock: {() -> Void in
//                })
//                alert.tintTopCircle = false
//                alert.removeTopCircle()
//                alert.setBodyTextFontFamily(Constant.REGULER_FONT, withSize: 14)
//                alert.showCustom(UIApplication.topViewController(), image: UIImage(named:"MYBYK-1"), color: UIColor(red: 84.0 / 255.0, green: 169.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0),title: nil, subTitle: "BLUETOOTH CONNECTIVITY ISSUE?\n\nWe are facing an issue in connecting with the bike and need to switch on your device's Bluetooth and try again.", closeButtonTitle: nil, duration: 0.0)
            }
            else
            {
                CommonClass.removeProgressHudCycling(viewController: self)
                
                print("NOT CONNECTED")
            }
        }
        
    }
   /* func scanDevicesResult(_ lists: [LockDetailsItem]) {
        
        self.listBleArray = [LockDetailsItem]()
        self.listBleArray = lists
        
        for item in listBleArray {
            if item.mac.uppercased() == self.macAddress.uppercased() {
                
                self.bleManager?.stopScan()
                self.bleManager?.connect(item.peripheral)
                isConnect = true
            }
        }
        
        if self.checkDeviceAvaibility == false {
            CommonClass.loadProgressHudCycling(viewController: self)
            self.checkDeviceAvaibility = true
            
            self.errorCaseOfAreYouStanding()
            
        }
        
    }
    
    func didConnectedPeripheral(_ peripheral: CBPeripheral) {
        let toast = Toast(text: "didConnectedPeripheral", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.bleClient?.discoverServices(with: peripheral, withKey: strBLEKey)
    }
    
    func didDisconnectPeripheral(_ peripheral: CBPeripheral) {
        let toast = Toast(text: "didDisconnectPeripheral", delay: 0.0, duration: Delay.long)
        toast.show()
        
        print(peripheral)
    }
    
    func didFail(toConnect peripheral: CBPeripheral) {
        let toast = Toast(text: "didFail", delay: 0.0, duration: Delay.long)
        toast.show()
    }
    
    func passBikeCertification() {
        let toast = Toast(text: "passBikeCertification", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.bleClient?.obtainLockDetails()
    }
    
    func bikeLockDetailsCompletion(_ completion: BikeLockDetailsModel) {
        let toast = Toast(text: "bikeLockDetailsCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.lockDetails = completion
        print(self.lockDetails)
        self.BlueToothCycleOutAPICall(strIsUnlock: "false", strVoltage: "\(self.lockDetails.electricity)", strTimeStamp: self.lockDetails.timestamp)
    }
    
    func bikeUnlockCompletion(_ completion: BikeLockUnlockModel)
    {
       /* let toast = Toast(text: "bikeUnlockCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
        let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
        self.navigationController?.pushViewController(ongoing, animated: true)*/
        let toast = Toast(text: "bikeUnlockCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
       // BlutoothConnectivityIssue.instance.hidePopup()
        
        print(completion.isSuccess)
        if completion.isSuccess == true
        {
            
            
           /* self.viewProceedPayAfterConfirmation.removeFromSuperview()
            
            let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
            ongoing.isHome = true
            self.navigationController?.pushViewController(ongoing, animated: true)*/
            
           /* self.view.layoutIfNeeded()
            
            self.viewUnlockSuccessMain.frame = (self.view.window?.bounds)!
            self.view.window?.addSubview(viewUnlockSuccessMain)
            
            self.viewLottieUnlock.contentMode = .scaleAspectFit
            self.viewLottieUnlock.loopMode = .playOnce
            self.viewLottieUnlock.animationSpeed = 0.5
            self.viewLottieUnlock.play()
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: true)
            */
        }
        else
        {
            
            self.viewConfirmationPopup.removeFromSuperview()
            
            
            self.view.layoutIfNeeded()
            
            self.viewStuckLock.frame = (self.view.window?.bounds)!
            self.view.window?.addSubview(viewStuckLock)
            
            //Unlock-MYBYK
            do {
                let gif = try UIImage(gifName: "unable_to_lock")
                self.imgStuck.setGifImage(gif, loopCount: -1)
                
            } catch {
                
            }
        }
        
        
    }
    
    func bikeLockedCompletion(_ completion: BikeLockLockedModel) {
        let toast = Toast(text: "bikeLockedCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
    }
    
    func errorCaseOfAreYouStanding() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            
            if self.isConnect == false {
                self.bleManager?.stopScan()
                print("BLUETOOTH CONNECTIVITY ISSUE?\n\nWe are facing an issue in connecting with the bike and need to switch on your device's Bluetooth and try again.")
                
                CommonClass.removeProgressHudCycling(viewController: self)
                
//                let alert = SCLAlertView()
//                alert.addButton("Try Again", actionBlock: {() -> Void in
//                })
//                alert.tintTopCircle = false
//                alert.removeTopCircle()
//                alert.setBodyTextFontFamily(Constant.REGULER_FONT, withSize: 14)
//                alert.showCustom(UIApplication.topViewController(), image: UIImage(named:"MYBYK-1"), color: UIColor(red: 84.0 / 255.0, green: 169.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0),title: nil, subTitle: "BLUETOOTH CONNECTIVITY ISSUE?\n\nWe are facing an issue in connecting with the bike and need to switch on your device's Bluetooth and try again.", closeButtonTitle: nil, duration: 0.0)
            }
        }
    }*/
    
    
    
}







