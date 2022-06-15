//
//  RideDetailsVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 26/06/21.
//

import UIKit
import Toaster

class RideDetailsVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var btnIHadAnIssue: UIButton!
    @IBOutlet weak var viewBackDetails: UIView!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    @IBOutlet var imgViewBikeType: UIImageView!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblRideID: UILabel!
    @IBOutlet var lblRideStatus: UIButton!
    @IBOutlet var lblLockNumber: UILabel!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblBikeNumber: UILabel!
    @IBOutlet var lblRideDate: UILabel!
    @IBOutlet var lblPickTime: UILabel!
    @IBOutlet var lblPickDate: UILabel!
    @IBOutlet var lblPickAddress: UILabel!
    @IBOutlet var lblDropTime: UILabel!
    @IBOutlet var lblDropDate: UILabel!
    @IBOutlet var lblDropAddress: UILabel!
    var arrTmpAllRidesData = [AnyObject]()
    
    var indexPath = IndexPath()
    var rideModel = MyRideFetchModel()
    var dataArrRideDetails : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackDetails.isHidden = true
      //  self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setUIOnScreen()
    }
    
    override func viewDidLayoutSubviews() {
        
      //  self.viewBackDetails.shadowZ100(frame: self.viewBackDetails.frame)
        self.viewBackDetails.viewTextFieldShadowBorderView()
        
      //  self.viewBackDetails.shadowSecondaryView(frame: self.viewBackDetails.frame)
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnIHadIssueClicked(_ sender: Any)
    {
        let report = self.storyboard?.instantiateViewController(withIdentifier: "ReportIssueVC") as! ReportIssueVC
        
        let dic = ["Duration" : rideModel.dataArr[indexPath.row].duration!,
                   "SIN" : rideModel.dataArr[indexPath.row].SIN!,
                   "categoryName" : rideModel.dataArr[indexPath.row].categoryName!,
                   "charges" : rideModel.dataArr[indexPath.row].charges!,
                   "deposited" : rideModel.dataArr[indexPath.row].deposited!,
                   "deposited_time" : rideModel.dataArr[indexPath.row].deposited_time!,
                   "idCycle" : rideModel.dataArr[indexPath.row].idCycle!,
                   "lock_QR_code" : rideModel.dataArr[indexPath.row].lock_QR_code!,
                   "lock_number" : rideModel.dataArr[indexPath.row].lock_number!,
                   "no" : rideModel.dataArr[indexPath.row].no!,
                   "rented" : rideModel.dataArr[indexPath.row].rented!,
                   "rented_time" : rideModel.dataArr[indexPath.row].rented_time!,
                   "rideID" : rideModel.dataArr[indexPath.row].rideID!,
                   "ride_end_date" : rideModel.dataArr[indexPath.row].ride_end_date!,
                   "ride_status" : rideModel.dataArr[indexPath.row].ride_status!,
                   "terminal_drop" : rideModel.dataArr[indexPath.row].terminal_drop!,
                   "terminal_pickup" : rideModel.dataArr[indexPath.row].terminal_pickup!,
                   "time_unit" : rideModel.dataArr[indexPath.row].time_unit!,
                   "ride_start_date" : rideModel.dataArr[indexPath.row].ride_start_date!] as [String : Any]
        report.dicCurrentRideData = dic
        self.navigationController?.pushViewController(report, animated: true)
    }
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension RideDetailsVC {
    
    
    func setUIOnScreen()
    {
        
      //  print(dataArrRideDetails!)
        print(dataArrRideDetails!)
        
        self.loadRideDetails(CycleTXnStartDate: "\(dataArrRideDetails["cycleTxnStartID"] as! Int)", CycleTXnEndDate: "\(dataArrRideDetails["cycleTxnEndID"]! as! Int)", strRideID: "\(dataArrRideDetails["rideID"] as! Int)", strRideCharges: "\(dataArrRideDetails["charges"] as! Int)")
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
      //  self.btnIHadAnIssue.layer.cornerRadius = 8.0
        self.btnIHadAnIssue.shadowZ100(frame: self.btnIHadAnIssue.frame)
      //  self.btnIHadAnIssue.shadowSecondaryBtn(frame: self.btnIHadAnIssue.frame)
        
        self.consViewBackDetailWidth.constant = self.view.frame.width - 40
    
        self.lblRideStatus.backgroundColor = UIColor(named: Color_Active)
        
        self.lblRideStatus.layer.cornerRadius = 5.0
        
        
        
    }
    func loadRideDetails(CycleTXnStartDate: String,CycleTXnEndDate: String,strRideID : String , strRideCharges : String)
    {
        //cycleTxnStartID
        //cycleTxnEndID
        //rideID
        //rideCharges
       CommonClass.loadProgressHudCycling(viewController: self)
        
        APIService.sharedInstance.loadRideDetails(dictionary: ["cycleTxnStartID": CycleTXnStartDate, "cycleTxnEndID": CycleTXnEndDate,"rideID" : strRideID,"rideCharges":strRideCharges]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                viewBackDetails.isHidden = false
                
                let dicData = response["data"] as! [String:Any]
                let dicRideData = dicData["rideDetails"] as! [String:Any]
              //  print(dicData["rideDetails"] as! NSArray)
                print(dicData["rideDetails"] as! [String:Any])
               // let aryDicData = dicData["rideDetails"] as!
               // print(aryDicData[0])
                
              //  self.imgViewBikeType.image = UIImage(named: getDynamicCycleName(strCycleType: rideModel.dataArr[indexPath.row].categoryName!))
                
                /*
                 ["idCycle": 8835, "rideCharges": 0, "terminal_pickup": EQUEST SOLUTIONS, "ride_status": Completed, "time_unit": minutes, "rideID": 5934195, "lock_QR_code": 66910002786, "cycleTxnStartTime": 02:32 pm, "lock_number": 669100-02786, "ride_end_date": 30 May 2022, "terminal_drop": EQUEST SOLUTIONS, "cycleTxnStartDate": 30 May, 2022, "rideDuration": 1min, "cycleTxnEndDate": 30 May, 2022, "cycleTxnEndTime": 02:32 pm, "SIN": DUMMYEQ3]
                 */
                
                self.lblAmount.text = "₹ \(dicRideData["rideCharges"]!)"
                //String(format: "₹ %d", dicRideData["charges"] as! CVarArg)
                //"\(dicRideData["charges"] as? Int ?? 0)"
                self.lblRideID.text = "\(dicRideData["rideID"]!)"
                //String(format: "%d", dicRideData["rideID"] as! CVarArg)
                //"\(dicRideData["rideID"] as? Int ?? 0)"
                //"\(rideModel.dataArr[indexPath.row].rideID!)"
                self.lblRideStatus.setTitle(dicRideData["ride_status"] as? String, for: .normal)
                self.lblLockNumber.text = dicRideData["lock_number"] as? String //rideModel.dataArr[indexPath.row].lock_number
                self.lblDuration.text = dicRideData["rideDuration"] as? String
              //  rideModel.dataArr[indexPath.row].duration
                self.lblBikeNumber.text = dicRideData["SIN"] as? String
                //rideModel.dataArr[indexPath.row].SIN
                self.lblRideDate.text = dicRideData["ride_end_date"] as? String
                
                //rideModel.dataArr[indexPath.row].ride_end_date
                self.lblPickTime.text = dicRideData["cycleTxnStartTime"] as? String
                //rideModel.dataArr[indexPath.row].rented_time
                self.lblPickDate.text = dicRideData["cycleTxnStartDate"] as? String
                
                self.lblDropTime.text = dicRideData["cycleTxnEndTime"] as? String
                //rideModel.dataArr[indexPath.row].deposited_time
                self.lblDropDate.text = dicRideData["cycleTxnEndDate"] as? String
                
                //rideModel.dataArr[indexPath.row].rented
                self.lblPickAddress.text = dicRideData["terminal_pickup"] as? String //rideModel.dataArr[indexPath.row].terminal_pickup
                
                //rideModel.dataArr[indexPath.row].ride_end_date
                self.lblDropAddress.text = dicRideData["terminal_drop"] as? String //rideModel.dataArr[indexPath.row].terminal_drop
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
}





