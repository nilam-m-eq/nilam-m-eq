//
//  ReferFriendMenuVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 07/04/22.
//

import UIKit
import Toaster

class ReferFriendMenuVC: UIViewController
{
    @IBOutlet var lbReferCode: UILabel!
    @IBOutlet var lbReferCredit: UILabel!
    @IBOutlet var lbAvailableCredit: UILabel!
    @IBOutlet var lbReferSchemeSubject: UILabel!
    
    @IBOutlet var viewNavigation: UIView!
    @IBOutlet var btnShare: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        viewNavigation.shadowZ100(frame: viewNavigation.frame)
        btnShare.layer.cornerRadius = 8.0
       // lbReferCode.shadowZ100(frame: lbReferCode.frame)
        
        lbReferCode.layer.masksToBounds = false
        lbReferCode.layer.shadowRadius = 2.0
        lbReferCode.layer.shadowOpacity = 0.2
        lbReferCode.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        lbReferCode.viewTextFieldActiveBorder()
        
        self.getReferCodeDetails()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnShareClicked(_ sender: Any)
    {
      /*  let refer = self.storyboard?.instantiateViewController(withIdentifier: "ReferFriendVC") as! ReferFriendVC
        refer.strRefer = lbReferCode.text!
        refer.strReferMessage = lbReferCredit.text!
        self.addChild(refer)
        self.view.addSubview(refer.view)
        refer.didMove(toParent: self)
        
        let height = view.frame.height
        let width = view.frame.width
        refer.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)*/
        
        //
      //  let message = String(format: "Hi! #MakingCitiesLiveableAgain with MYBYK, India's largest bicycle-share service. Use referral code %@ to get your first ride free*.\n\n Download now: http://onelink.to/5n7cxf", ReferCode!)
        
           let textToShare = String(format: "Hi! #MakingCitiesLiveableAgain with MYBYK, India's largest bicycle-share service. Use referral code %@ to get your first ride free*.\n\n Download now: http://onelink.to/5n7cxf", lbReferCode.text!)
        
           let shareAll = [textToShare]
           let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
           activityViewController.popoverPresentationController?.sourceView = self.view
           self.present(activityViewController, animated: true, completion: nil)
        
    }
    @IBAction func btnCopyReferClicked(_ sender: Any)
    {
        let pasteboard = UIPasteboard.general
        pasteboard.string = lbReferCode.text
        
        let toast = Toast(text: "Copied!", delay: 0.0, duration: Delay.long)
        toast.show()
    }
    
}
extension ReferFriendMenuVC
{
    
    func getReferCodeDetails()
    {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.ReferDetail(dictionary: ["getReferralDetails": "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicCurrentData = response["data"] as! [String: Any]
           
              
               // guard let strcode = dicCurrentData["referralCode"] as? String else { return false }
               
                guard let strcode = dicCurrentData["referralCode"] as? String else
                {
                    //print("green is not present in palette")
                    return
                }
                lbReferCode.text = strcode
                //dicCurrentData["referralCode"] as? String
                lbReferCredit.text = dicCurrentData["referralCodeMessage"] as? String
                lbReferSchemeSubject.text = dicCurrentData["referralCodeNotice"] as? String
                
                let normalText = "Available credits: "
                let boldText  = "\(dicCurrentData["credit"] as? String ?? "")"
            
               // let attributedString = NSMutableAttributedString(string:normalText)

                let attrs = [NSAttributedString.Key.font : UIFont(name: "Rubik Bold", size: 16.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_Primary") ]
                
                let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Rubik Regular", size: 16.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_N_Dark900") ]
                
                let boldString = NSMutableAttributedString(string: boldText, attributes:attrs as [NSAttributedString.Key : Any])
                
                let normalStr = NSMutableAttributedString(string: normalText, attributes:attrs1 as [NSAttributedString.Key : Any])
                
                normalStr.append(boldString)
                lbAvailableCredit.attributedText = normalStr
               // attributedString.append(boldString)
                //lbUploadTitle.attributedText = attributedString
                
              //  lbAvailableCredit.text = "\(dicCurrentData["credit"] as? String ?? "")"
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
