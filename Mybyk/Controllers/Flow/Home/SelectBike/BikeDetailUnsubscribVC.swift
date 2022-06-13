//
//  BikeDetailUnsubscribVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit
import Toaster

protocol MyDataSendingDelegateProtocol
{
    func RemoveViewController(myviewControlle : String)
}

class BikeDetailUnsubscribVC: CommonViewController, UIGestureRecognizerDelegate
{
    @IBOutlet var scrollview: UIScrollView!
    var delegate: MyDataSendingDelegateProtocol? = nil
    
    var Fullview: CGFloat = UIScreen.main.bounds.height
    var isDisplay = false
    var flagCheck : Bool!
    
    @IBOutlet var viewMainDetailHeightConst: NSLayoutConstraint!
    
    @IBOutlet var thumbIconTopConstant: NSLayoutConstraint!
    @IBOutlet weak var viewBackDetail: UIView!
    @IBOutlet weak var btnSelectPlan: UIButton!
    @IBOutlet var lblLockNumber: UILabel!
    @IBOutlet var lblLockBattery: UILabel!
    @IBOutlet var lblBikeNumber: UILabel!
    @IBOutlet var lblBikeBattery: UILabel!
    @IBOutlet var lbBykType: UILabel!
    @IBOutlet var imgViewStatusIcon: UIImageView!
    
    @IBOutlet var tblDetail: UITableView!
    @IBOutlet var imgCycleTypeName: UIImageView!
    var dicCycleData = [String: Any]()
    var strStationID = String()
    var arrCycleIssueTypesList = NSArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = true
     //cellView.imgLikeDislikeThumb.image = UIImage(named:"IC_DownGray")
        print(dicCycleData)
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        gesture.delegate = self
        viewBackDetail.addGestureRecognizer(gesture)
        
        if Fullview - 50 < btnSelectPlan.frame.origin.y + btnSelectPlan.frame.height + 20
        {
            viewMainDetailHeightConst.constant = Fullview - 80
            scrollview.isScrollEnabled = true
            
            
            
            flagCheck = false
           /* let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe1(_:)))

                // Configure Swipe Gesture Recognizer
            swipeGestureRecognizerDown.direction = .down
            scrollview.addGestureRecognizer(swipeGestureRecognizerDown)*/
        }
        else
        {
            viewMainDetailHeightConst.constant = btnSelectPlan.frame.origin.y + btnSelectPlan.frame.height + 80
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
        print("BUTTon",btnSelectPlan.frame.origin.y + btnSelectPlan.frame.height + 20)
        
        
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
            
            print("BUTTon1",btnSelectPlan.frame.origin.y + btnSelectPlan.frame.height + 20)
            
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
        
       // tblDetail.setContentOffset(.zero, animated: true)
        //tblDetail.estimatedRowHeight = 117
        
       // tblDetail.scrollsToTop = true
    //    tblDetail.scroll(to: .top, animated: true)
        
        
        
        self.setUIOnScreen()
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
    @IBAction func btnReportissueClicked(_ sender: Any)
    {
        let report = self.storyboard?.instantiateViewController(withIdentifier: "ReportIssueVC") as! ReportIssueVC
        report.dicCurrentRideData = dicCycleData
        report.arrCycleIssueTypes = arrCycleIssueTypesList
        self.navigationController?.pushViewController(report, animated: true)
        self.delegate?.RemoveViewController(myviewControlle: "Unscribed")
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
    @IBAction func ActionSelectPlan(_ sender: UIButton)
    {
        
        if #available(iOS 13.0, *) {
            let subscri = self.storyboard?.instantiateViewController(identifier: "SubscriptionPlanVC") as! SubscriptionPlanVC
            subscri.dicCycleData = dicCycleData
            subscri.strStationID = strStationID
            self.navigationController?.pushViewController(subscri, animated: true)
        } else {
            
            let subscri = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionPlanVC") as! SubscriptionPlanVC
            subscri.dicCycleData = dicCycleData
            subscri.strStationID = strStationID
            self.navigationController?.pushViewController(subscri, animated: true)
        }
    }
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension BikeDetailUnsubscribVC {
    
    func setUIOnScreen() {
        
        self.view.alpha = 1.0
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
        self.btnSelectPlan.layer.cornerRadius = 10.0
        
        viewBackDetail.roundCorners(corners: [.topLeft, .topRight], radius: 15.0, rect: self.view.frame)
        
        print(dicCycleData)
        /*
         if let StrStationID = dicHub["idStations"] as? String
         {
             self.CovertID = StrStationID
         }
         else
         {
             let StrStationIDCovert = dicHub["idStations"]
             self.CovertID  = "\(StrStationIDCovert as! Int)"
         }
         */
        self.lblLockNumber.text = "\(dicCycleData["sin"] as! String)"
       
        
        if let StrBetteryPercent = dicCycleData["betterypercentage"] as? String
        {
          //  self.lblLockBattery.text = StrBetteryPercent
        }
        else
        {
            let StrStationIDCovert = dicCycleData["betterypercentage"]
           // self.lblLockBattery.text = "\(StrStationIDCovert as! Int)"
        }
        
        //self.lbBykType.text = "\(dicCycleData["categoryName"] as! String)"
        
        if "\(dicCycleData["isMalfunction"] as! String)" == "true" {
            
            self.imgViewStatusIcon.image = UIImage(named: "IC_DownGray")
            thumbIconTopConstant.constant = 5
        }
        else
        {
            self.imgViewStatusIcon.image = UIImage(named: "IC_Thumbup")
            thumbIconTopConstant.constant = -5
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first?.view == self.view {
            
            UIView.animate(withDuration: 0.3) {
                
                self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
                self.view.frame.origin.y = self.view.frame.height
                
            } completion: { status in
                
                self.view.removeFromSuperview()
                
            }
        }
        
    }
    
    
    
}




