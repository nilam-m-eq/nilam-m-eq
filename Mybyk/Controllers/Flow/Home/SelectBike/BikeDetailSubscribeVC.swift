//
//  BikeDetailSubscribeVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit
import Toaster
import CoreLocation
import OmniBaseTool
import OmniBikeLock
import Lottie

protocol MyDataSendingDelegateProtocolSubscribed
{
    func RemoveViewControllerDta(myviewControlle : String)
}

class BikeDetailSubscribeVC: CommonViewController, UIGestureRecognizerDelegate
{
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var viewDetailConst: NSLayoutConstraint!
    @IBOutlet var viewMainHeightConst: NSLayoutConstraint!
    @IBOutlet var imgNote: UIImageView!
    @IBOutlet var viewLottieUnlock: AnimationView!
    @IBOutlet var viewUnlockSuccessMain: UIView!
    
    @IBOutlet var lbNote: UILabel!
    @IBOutlet var lbSecurityDepoValue: UILabel!
    @IBOutlet var viewRechargeNowInnerHeightConst: NSLayoutConstraint!
    @IBOutlet var lbSecurityDepo: UILabel!
    
    @IBOutlet var btnWhenStuckOkay: UIButton!
    @IBOutlet var imgWhenLockStuck: UIImageView!
    @IBOutlet var viewWhenLockStuckInner: UIView!
    @IBOutlet var viewWhenLockStuckMain: UIView!
    @IBOutlet var btnProceedPayAfterCancel: UIButton!
    @IBOutlet var btnProceedPayAfterOkay: UIButton!
    @IBOutlet var imgProceedPayAfterConfirmation: UIImageView!
    @IBOutlet var viewProceedPayAfterConfirInnerView: UIView!
    @IBOutlet var viewProceedPayAfterConfirmation: UIView!
    var delegate: MyDataSendingDelegateProtocolSubscribed? = nil
    @IBOutlet weak var viewBackDetail: UIView!
    @IBOutlet weak var btnProceedToUnlock: UIButton!
    @IBOutlet var lblLockNumber: UILabel!
    @IBOutlet var lblLockBattery: UILabel!
    @IBOutlet var lblBikeNumber: UILabel!
    @IBOutlet var lblBikeBattery: UILabel!
    @IBOutlet var imgViewStatusIcon: UIImageView!
    @IBOutlet var lblWallentBalPreview: UILabel!
    @IBOutlet var lblWalletBalance: UILabel!
    @IBOutlet var tblView: UITableView!
    @IBOutlet var lbBykName: UILabel!
    
    @IBOutlet var lbPlanName: UILabel!
    @IBOutlet var lbBykPlanTime: UILabel!
    var locationManager = CLLocationManager()
    
    @IBOutlet var lbExpireIn: UILabel!
    @IBOutlet var lbProceedAfterConfirmLockNumber: UILabel!

    @IBOutlet var imgThumbUpDownTopConstraint: NSLayoutConstraint!
    var dicCycleData = [String: Any]()
    var arrSubscriptionDetail = NSArray()
    var strTerminalID = String()
    var intMinBalance = Int()
    var macAddress = String()
    
    var bleManager: OmniBleManager?
    var bleClient: BikeLockClient?
    var listBleArray = [LockDetailsItem]()
    var lockDetails = BikeLockDetailsModel()
    
    var checkDeviceAvaibility = Bool()
    var isConnect = false
    
    var setGPRSBLEVal : Bool!
    
    var centralManager: CBCentralManager?
    
    var timer : Timer?
    var arrCycleIssueTypesList = NSArray()
    
    var strSecurityDepoVal: String!
    var strNote: String!
    var aryDataInsuffcient : NSArray!
    var HeightConstPlan : CGFloat!
    var HeightConstPlanDetail : CGFloat!
    
    var Fullview: CGFloat = UIScreen.main.bounds.height
    var isDisplay = false
    var flagCheck : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.tabBarController?.tabBar.isHidden = true
        
        print(dicCycleData)
        print(arrSubscriptionDetail)
        print(strTerminalID)
        
    
        //plan_expiry_msg
//        /subscriptionName
        let dicPlanDet = arrSubscriptionDetail[0] as! [String:Any]
        lbPlanName.text = "\(dicPlanDet["subscriptionName"] as! String)"
        
        HeightConstPlan = self.heightForView(text: "\(dicPlanDet["subscriptionName"] as! String)", font: UIFont(name: "Rubik Medium", size: 14.0)!, width: self.view.frame.width - 178)
        
        lbExpireIn.text = "\(dicPlanDet["plan_expiry_msg"] as! String)"
        
        //Rubik Medium 12.0
        HeightConstPlanDetail = self.heightForView(text: "\(dicPlanDet["plan_expiry_msg"] as! String)", font: UIFont(name: "Rubik Medium", size: 14.0)!, width: self.view.frame.width - 178)
        
      
        
       // lbBykPlanTime.text = "\(dicPlanDet["subscriptionName"] as! String)"
        
      //  cell.lblPlanAmount.text = "₹ \(dicPlanDet["subscriptionAmount"] as! String)"
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
        print("BUTTon",btnProceedToUnlock.frame.origin.y + btnProceedToUnlock.frame.height + 20)
        
        
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
                
                
                UIView.animate(withDuration: 1.0) {

                 //   self.view.layoutIfNeeded()
                    
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
            
            print("BUTTon1",btnProceedToUnlock.frame.origin.y + btnProceedToUnlock.frame.height + 20)
            
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.getCycleIssueTypeAPICall()
        
        self.setUIOnScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.bleManager?.cancelCurrentConnect()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    @IBAction func btnDownArrowClicked(_ sender: Any)
    {
        UIView.animate(withDuration: 0.3) {
            
            self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            self.view.frame.origin.y = self.view.frame.height
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
    }
    @IBAction func btnProceedPayAfterCancelClicked(_ sender: Any)
    {
        self.viewProceedPayAfterConfirmation.removeFromSuperview()
    }
    @IBAction func btnProceedAfterOkClicked(_ sender: Any)
    {
        if setGPRSBLEVal == false
        {
            print("GPRS")
        }
        else
        {
            print("BLE")
            
            self.viewProceedPayAfterConfirmation.removeFromSuperview()
            
        //    centralManager = CBCentralManager(delegate: self, queue: nil)
          //  centralManager = CBCentralManager(delegate: nil, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey:true])
            
             self.bleManager = OmniBleManager()
             self.bleManager?.delegate = self
             self.bleClient = BikeLockClient()
             self.bleClient?.delegate = self
             self.bleManager?.scanDevices()
             
            
        }
    }
    @IBAction func btnReportIssueClicked(_ sender: Any)
    {
        let report = self.storyboard?.instantiateViewController(withIdentifier: "ReportIssueVC") as! ReportIssueVC
        report.dicCurrentRideData = dicCycleData
        report.arrCycleIssueTypes = arrCycleIssueTypesList
        self.navigationController?.pushViewController(report, animated: true)
        self.delegate?.RemoveViewControllerDta(myviewControlle: "Subscribed")
      //  self.removeChild()
    }
    //MARK: - GET LIST OF ISSUES TYPES
    func getCycleIssueTypeAPICall() {
        
      //  CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getCycleIssueTypeAPICall(dictionary: ["getcycleissuetypes": "1"]) { [self] response in
          //  CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicCurrentData = response["data"] as! [String: Any]
                arrCycleIssueTypesList = dicCurrentData["cycleIssueTypes"] as! NSArray
                
                //self.collectView.reloadData()
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
    @IBAction func btnWhenStuckOkayClicked(_ sender: Any)
    {
       
        self.viewWhenLockStuckMain.removeFromSuperview()
        
        let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
        self.navigationController?.pushViewController(ongoing, animated: true)
    }
    @IBAction func ActionProceedToUnlock(_ sender: UIButton)
    {
        /*
         if strSecurityDepoVal == ""
         {
             viewRechargeNowInnerHeightConst.constant = 0
             lbNote.text = ""
             btnProceedToUnlock.titleLabel?.text = "PROCEED TO UNLOCK"
         }
         else
         {
             lbSecurityDepoValue.text = strSecurityDepoVal
             lbNote.text = strNote
             btnProceedToUnlock.titleLabel?.text = "RECHARGE NOW"
         }
         */
        
       // if btnProceedToUnlock.titleLabel?.text == "RECHARGE NOW"
       // {
           // self.
            
       // }
       // else
       // {
            if CLLocationManager.locationServicesEnabled()
            {
                
                if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways {
                    
                    print("Access")
                    var currentLocation = CLLocation()
                    currentLocation = locationManager.location!
                    print(currentLocation.coordinate.latitude)
                    print(currentLocation.coordinate.longitude)
                    
                    /*
                     dicCycleData
                     */
                    print(dicCycleData)
                    lbProceedAfterConfirmLockNumber.text = dicCycleData["QRCode"] as? String
                    self.addSubscriptionAPICall(lat: "\(currentLocation.coordinate.latitude)", long: "\(currentLocation.coordinate.longitude)")
                    
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
            
        //}
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        
         switch central.state
        {
              case .poweredOff:
                  print("Is Powered Off.")
//             self.viewProceedPayAfterConfirmation.removeFromSuperview()
//
//             self.bleManager = OmniBleManager()
//             self.bleManager?.delegate = self
//             self.bleClient = BikeLockClient()
//             self.bleClient?.delegate = self
//             self.bleManager?.scanDevices()
          
              case .poweredOn:
                  print("Is Powered On.")
                 // startScanning()
              case .unsupported:
                  print("Is Unsupported.")
              case .unauthorized:
              print("Is Unauthorized.")
              case .unknown:
                  print("Unknown")
              case .resetting:
                  print("Resetting")
              @unknown default:
                print("Error")
              }
      }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension BikeDetailSubscribeVC {
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    func setUIOnScreen() {
        
        print(dicCycleData)
        print(arrSubscriptionDetail)
        
        print(strNote!)
        /*
         HeightConst = self.heightForView(text: dataResponce["restrictedHubMessage"] as! String, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self.view.frame.width - 40)
         */
        //Rubik Medium 13.0
        
        if strSecurityDepoVal == ""
        {
         
            viewRechargeNowInnerHeightConst.constant = 0
            lbNote.text = ""
            lbSecurityDepo.text = ""
            lbSecurityDepoValue.text = ""
            imgNote.isHidden = true
            //btnProceedToUnlock.titleLabel?.text = "PROCEED TO UNLOCK"
            btnProceedToUnlock.setTitle("PROCEED TO UNLOCK", for:.normal)
         //   viewMainHeightConst.constant = 235 + HeightConstPlan + HeightConstPlanDetail
            viewDetailConst.constant = 380 + HeightConstPlan + HeightConstPlanDetail
        }
        else
        {
            lbSecurityDepoValue.text = String(format: "₹%@", strSecurityDepoVal!)
            //"₹\(strSecurityDepoVal ?? <#default value#>)"
            lbNote.text = strNote
            btnProceedToUnlock.setTitle("RECHARGE NOW", for:.normal)
            
            
         //   viewMainHeightConst.constant = 280 + HeightConstPlan + HeightConstPlanDetail
            viewDetailConst.constant = 430 + HeightConstPlan + HeightConstPlanDetail
          //  btnProceedToUnlock.titleLabel?.text = "RECHARGE NOW"
        }
       
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        gesture.delegate = self
        viewBackDetail.addGestureRecognizer(gesture)
        
        if btnProceedToUnlock.frame.origin.y + btnProceedToUnlock.frame.height + 20 > Fullview - 50
        {
            viewDetailConst.constant = Fullview - 80
            scrollview.isScrollEnabled = true
            
            
            
            flagCheck = false
           /* let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe1(_:)))

                // Configure Swipe Gesture Recognizer
            swipeGestureRecognizerDown.direction = .down
            scrollview.addGestureRecognizer(swipeGestureRecognizerDown)*/
        }
        else
        {
            viewDetailConst.constant = btnProceedToUnlock.frame.origin.y + btnProceedToUnlock.frame.height + 80
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
        
        btnProceedPayAfterOkay.layer.cornerRadius = 10.0
        btnProceedPayAfterCancel.layer.cornerRadius = 10.0
        viewProceedPayAfterConfirInnerView.layer.cornerRadius = 8.0

        imgProceedPayAfterConfirmation.layer.borderWidth = 1.0
        imgProceedPayAfterConfirmation.layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        imgProceedPayAfterConfirmation.layer.cornerRadius = 10.0
        
        imgProceedPayAfterConfirmation.clipsToBounds = true
        imgProceedPayAfterConfirmation.layer.cornerRadius = 15.0
        
        btnWhenStuckOkay.layer.cornerRadius = 10.0
        viewWhenLockStuckInner.layer.cornerRadius = 8.0
        
        imgWhenLockStuck.layer.borderWidth = 1.0
        imgWhenLockStuck.layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        imgWhenLockStuck.layer.cornerRadius = 10.0
        
        imgWhenLockStuck.clipsToBounds = true
        imgWhenLockStuck.layer.cornerRadius = 15.0
        
        self.btnProceedPayAfterOkay.shadowSecondaryView(frame: self.btnProceedPayAfterOkay.frame)
        
        self.view.alpha = 1.0
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
        self.btnProceedToUnlock.layer.cornerRadius = 10.0
        
        viewBackDetail.roundCorners(corners: [.topLeft, .topRight], radius: 15.0, rect: self.view.frame)
        
        self.lblLockNumber.text = "\(dicCycleData["sin"] as! String)"
     //   self.lblLockBattery.text = "\(dicCycleData["betterypercentage"] as! Int)"
        
        self.macAddress = "\(dicCycleData["macAddress"] as! String)"
        //self.lbBykName.text = "\(dicCycleData["categoryName"] as! String)"
        
        if "\(dicCycleData["isMalfunction"] as! String)" == "true"
        {
            /*
             IC_Thumbup
             IC_DownGray
             */
            self.imgViewStatusIcon.image = UIImage(named: "IC_DownGray")
            imgThumbUpDownTopConstraint.constant = 5
        }
        else {
            self.imgViewStatusIcon.image = UIImage(named: "IC_Thumbup")
            imgThumbUpDownTopConstraint.constant = -5
        }
    }
    
  /*  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first?.view == self.view {
            
            UIView.animate(withDuration: 0.3) {
                
                self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
                self.view.frame.origin.y = self.view.frame.height
                
            } completion: { status in
                
                self.view.removeFromSuperview()
                
            }
        }
        
    }*/
    
    
    
}

// ************************************************* //
// MARK:- UITableView Delegate & DataSource Methods
// ************************************************* //
extension BikeDetailSubscribeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if arrSubscriptionDetail.count == 0 {
//            return 0
//        }
//        else {
//            return 1
//        }
        
        return 0
        
//        return arrSubscriptionDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! BikeDetailTblCell
        
        let dicPlanDet = arrSubscriptionDetail[indexPath.row] as! [String:Any]
        
      //  cell.lblPlanName.text = "\(dicPlanDet["subscriptionName"] as! String)"
        cell.lblPlanAmount.text = "₹ \(dicPlanDet["subscriptionAmount"] as! String)"
        cell.lblPlanType.text = "/ \(dicPlanDet["subscriptionType"] as! String)"
        cell.lblPlanDes.text = "\((dicPlanDet["description"] as! String).htmlToString)"
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension BikeDetailSubscribeVC {
    
    func addSubscriptionAPICall(lat: String, long: String) {
        
        let idUserSubscription = (arrSubscriptionDetail[0] as! [String: Any])["idUserSubscriptions"] as! Int
        let startDate = (arrSubscriptionDetail[0] as! [String: Any])["end_date"] as! String
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.addSubscriptionAPICall(dictionary: ["idUserSubscriptions": "\(idUserSubscription)", "idStations": "\(strTerminalID)", "startDate":"\(startDate)", "user_subscribed":"true"]) { [self] response in
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
                    
                    let DicData = response["data"] as! [String:Any]
                    aryDataInsuffcient = DicData["add_balance_msg"] as? NSArray
                    
                    if btnProceedToUnlock.titleLabel?.text == "RECHARGE NOW"
                     {
                         InsufficientBalance.instance.showInsufficientBalance(withTblData: aryDataInsuffcient)
                         InsufficientBalance.instance.ActionRecharge  =
                         {
                             let AddmoneyVc = self.storyboard?.instantiateViewController(withIdentifier: "AddMoneyVC") as! AddMoneyVC
                             AddmoneyVc.strFrwdAmount = self.strSecurityDepoVal//self.CovertAmnt
                          //   ongoing.isHome = true
                           //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
                           //  UserDefaults.standard.synchronize()
                             self.navigationController?.pushViewController(AddmoneyVc, animated: true)
                         }
                     }
                   
                   // showInsufficientBalance(aryData)
                    
                   /* func showInsufficientBalance(withTblData: [Any]) {
                        
                        arrTblData = withTblData
                        
                        tblViewHeight.constant = CGFloat(36 * Int(arrTblData.count))
                        
                        self.tblView.reloadData()
                        
                        UIApplication.shared.keyWindow?.addSubview(parentView)
                    }
                    @IBAction func ActionRecharge(_ sender: UIButton) {
                        
                        parentView.removeFromSuperview()
                        ActionRecharge?()
                    }
                    
                    @IBAction func ActionCancel(_ sender: UIButton) {
                        
                        parentView.removeFromSuperview()
                        ActionCancel?()
                    }*/
                    
                   /* let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()*/
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func BTCycleValidateAPICall(lat: String, long: String)
    {
        let idUserSubscription = (arrSubscriptionDetail[0] as! [String: Any])["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = (arrSubscriptionDetail[0] as! [String: Any])["payasyougo1"] as! Int
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.BTCycleValidateAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":lat, "long":long, "payasyougo":"\(payasugo)", "idUserSubscriptions": "\(idUserSubscription)", "home": "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                 self.view.layoutIfNeeded()
                 
                 self.viewProceedPayAfterConfirmation.frame = (self.view.window?.bounds)!
                 self.view.window?.addSubview(viewProceedPayAfterConfirmation)
                 
                 //Unlock-MYBYK
                 do {
                     let gif = try UIImage(gifName: "Unlock-MYBYK")
                     self.imgProceedPayAfterConfirmation.setGifImage(gif, loopCount: -1)
                     
                 } catch {
                     
                 }
                 
                /*
                 self.view.layoutIfNeeded()
                 
                 self.viewProceedPayAfterConfirmation.frame = (self.view.window?.bounds)!
                 self.view.window?.addSubview(viewProceedPayAfterConfirmation)
                 
                 //Unlock-MYBYK
                 do {
                     let gif = try UIImage(gifName: "Unlock-MYBYK")
                     self.imgProceedPayAfterConfirmation.setGifImage(gif, loopCount: -1)
                     
                 } catch {
                     
                 }
                 */
             
               /* if self.dicCycleData["lockType"] as! String == "GPRS"
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
                }*/
                
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
    //MARK: - GRPS check dialog
    
    func BTCGRPSycleValidateAPICall(lat: String, long: String)
    {
        let idUserSubscription = (arrSubscriptionDetail[0] as! [String: Any])["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = (arrSubscriptionDetail[0] as! [String: Any])["payasyougo1"] as! Int
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.BTCycleValidateGPRSAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":lat, "long":long, "payasyougo":"\(payasugo)", "idUserSubscriptions": "\(idUserSubscription)", "home": "true","buzz" : "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                self.view.layoutIfNeeded()
                
                self.viewProceedPayAfterConfirmation.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(viewProceedPayAfterConfirmation)
                
                //Unlock-MYBYK
                do {
                    let gif = try UIImage(gifName: "Unlock-MYBYK")
                    self.imgProceedPayAfterConfirmation.setGifImage(gif, loopCount: -1)
                    
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
    func BlueToothCycleOutAPICall(strIsUnlock: String, strVoltage: String, strTimeStamp: String) {
        
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        let idUserSubscription = (arrSubscriptionDetail[0] as! [String: Any])["idUserSubscriptions"] as! Int
        let strQRCode = dicCycleData["sin"] as! String
        let payasugo = (arrSubscriptionDetail[0] as! [String: Any])["payasyougo1"] as! Int
        
        print(dicCycleData)
        print(arrSubscriptionDetail[0])
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.BlueToothCycleOutAPICall(dictionary: ["QRCode":"\(strQRCode)", "lat":"\(currentLocation.coordinate.latitude)", "long":"\(currentLocation.coordinate.longitude)", "note":"", "payasyougo":"\(payasugo)", "terminalID":"\(strTerminalID)", "idUserSubscriptions": "\(idUserSubscription)", "isUnlock": strIsUnlock, "voltage":strVoltage, "timestamp":strTimeStamp]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                self.viewUnlockSuccessMain.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(viewUnlockSuccessMain)
                
                self.viewLottieUnlock.contentMode = .scaleAspectFit
               self.viewLottieUnlock.loopMode = .playOnce
                self.viewLottieUnlock.animationSpeed = 0.9
                self.viewLottieUnlock.play()
               
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
    
    
}

extension BikeDetailSubscribeVC : BikeLockCmdDelegate, BleManagerDelegate
{
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
    
    func bikeLockDetailsCompletion(_ completion: BikeLockDetailsModel)
    {
        let toast = Toast(text: "bikeLockDetailsCompletion", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.lockDetails = completion
        print(self.lockDetails)
        self.BlueToothCycleOutAPICall(strIsUnlock: "false", strVoltage: "\(self.lockDetails.electricity)", strTimeStamp: self.lockDetails.timestamp)
    }
    
    @objc func timerHideUnlockSucccess()
    {
        self.timer?.invalidate()
        self.viewLottieUnlock.stop()
        self.viewUnlockSuccessMain.removeFromSuperview()
        let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
      //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
      //  UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(ongoing, animated: true)
    }
    func didConnectedPeripheral(_ peripheral: CBPeripheral)
    {
        let toast = Toast(text: "didConnectedPeripheral", delay: 0.0, duration: Delay.long)
        toast.show()
        
        self.bleManager?.stopScan()
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
            
            self.viewProceedPayAfterConfirmation.removeFromSuperview()
            
            
            self.view.layoutIfNeeded()
            
            self.viewWhenLockStuckMain.frame = (self.view.window?.bounds)!
            self.view.window?.addSubview(viewWhenLockStuckMain)
            
            //Unlock-MYBYK
            do {
                let gif = try UIImage(gifName: "unable_to_lock")
                self.imgWhenLockStuck.setGifImage(gif, loopCount: -1)
                
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
                    /*self.bleManager = OmniBleManager()
                    self.bleManager?.delegate = self
                    self.bleClient = BikeLockClient()
                    self.bleClient?.delegate = self
                    self.bleManager?.scanDevices()*/
                    self.isConnect = false
                    self.checkDeviceAvaibility = false
                    CommonClass.removeProgressHudCycling(viewController: self)
                    BlutoothConnectivityIssue.instance.hidePopup()
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
    
    
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}



