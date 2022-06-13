//
//  RideSummaryVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 14/12/21.
//

import UIKit

class RideSummaryVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackDetails: UIView!
    @IBOutlet var viewBackRideDetails: UIView!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    @IBOutlet var imgViewBikeType: UIImageView!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblRideID: UILabel!
    @IBOutlet var lblRideStatus: UIButton!
    @IBOutlet var lblLockNumber: UILabel!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblBikeNumber: UILabel!
    @IBOutlet var lblRideDate: UILabel!
    @IBOutlet var lblPickAddress: UILabel!
    @IBOutlet var lblDropAddress: UILabel!
    @IBOutlet var viewBackTumbUp: UIView!
    @IBOutlet var viewBackThumbDown: UIView!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnDislike: UIButton!
    var timer = Timer()
    var counter = 0
    
    var dicCurrentRideData = [String: Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    self.tabBarController?.tabBar.isHidden = true
        self.setUIOnScreen()
        
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        self.viewBackRideDetails.viewTextFieldShadowBorderViewForSummary()
        self.viewBackThumbDown.viewTextFieldShadowBorderViewForSummary()
        self.viewBackTumbUp.viewTextFieldShadowBorderViewForSummary()
        
      /*  self.viewBackRideDetails.shadowSecondaryView(frame: self.viewBackRideDetails.frame)
        self.viewBackThumbDown.shadowSecondaryView(frame: self.viewBackThumbDown.frame)
        self.viewBackTumbUp.shadowSecondaryView(frame: self.viewBackTumbUp.frame)*/
        
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionLike(_ sender: UIButton) {
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                print(controller)
            }
        }
        
        timer.invalidate()
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    @IBAction func ActionDislike(_ sender: UIButton)
    {
        
        
        if let viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                print(controller)
            }
        }
        
        timer.invalidate()
        let report = self.storyboard?.instantiateViewController(withIdentifier: "ReportIssueVC") as! ReportIssueVC
        report.dicCurrentRideData = dicCurrentRideData
        report.FromRideSummary = "RideSummary"
        self.navigationController?.pushViewController(report, animated: true)
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension RideSummaryVC {
    
    func setUIOnScreen()
    {
        timer = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
       
        print(dicCurrentRideData)
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        
        self.consViewBackDetailWidth.constant = self.view.frame.width
        
        self.btnLike.setTitle("", for: .normal)
        self.btnDislike.setTitle("", for: .normal)
        
        self.imgViewBikeType.image = UIImage(named: getDynamicCycleName(strCycleType: "\(dicCurrentRideData["cycleCategory"] as! String)"))
        self.lblAmount.text = "₹\(dicCurrentRideData["charges"] as? Int ?? 0)"
        self.lblRideID.text = "\(dicCurrentRideData["rideID"] as? Int ?? 0)"
        self.lblRideStatus.setTitle("\(dicCurrentRideData["ride_status"] as? String ?? "")", for: .normal)
        self.lblRideStatus.backgroundColor = UIColor(named: Color_Active)
        self.lblLockNumber.text = "\(dicCurrentRideData["lock_number"] as? String ?? "")"
        self.lblDuration.text = "\(dicCurrentRideData["time"] as? String ?? "")"
        self.lblBikeNumber.text = "\(dicCurrentRideData["lock_number"] as? String ?? "")"
        self.lblRideDate.text = "\(dicCurrentRideData["ride_end_date"] as? String ?? "")"
        self.lblPickAddress.text = "\(dicCurrentRideData["pickupstation"] as? String ?? "")"
        self.lblDropAddress.text = "\(dicCurrentRideData["dropstation"] as? String ?? "")"
        
    }
    @objc func timerAction()
    {
//        counter += 1
//
//        if counter == 300
//        {
            timer.invalidate()
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(homeVC, animated: true)
//        }
    }
    
}






