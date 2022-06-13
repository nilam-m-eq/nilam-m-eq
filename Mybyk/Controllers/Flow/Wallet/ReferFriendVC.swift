//
//  ReferFriendVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 07/01/22.
//

import UIKit
import MessageUI

class ReferFriendVC: CommonViewController, MFMessageComposeViewControllerDelegate
{
 
    @IBOutlet weak var viewBackDetail: UIView!
    @IBOutlet var lblRefer: UILabel!
    @IBOutlet var lblReferMessage: UILabel!
    @IBOutlet weak var viewBackWhatsapp: UIView!
    @IBOutlet weak var viewBackSMS: UIView!
    
    var strRefer = String()
    var strReferMessage = String()
    
    var ReferCode : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    @IBAction func ActionClose(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            self.view.frame.origin.y = self.view.frame.height
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
    }
    
    @IBAction func ActionWhatsApp(_ sender: UIButton)
    {

//        if UserDefaults.standard.value(forKey: "RefereCode") == nil
//        {
//
//        }
//        else
//        {
//            ReferCode = UserDefaults.standard.value(forKey: "RefereCode") as? String
//        }
        
        let message = String(format: "Hi! #MakingCitiesLiveableAgain with MYBYK, India's largest bicycle-share service. Use referral code %@ to get your first ride free*.\n\n Download now: http://onelink.to/5n7cxf", ReferCode!)
        let queryCharSet = NSCharacterSet.urlQueryAllowed
        
        if let escapedString = message.addingPercentEncoding(withAllowedCharacters: queryCharSet)
        {
            if let whatsappURL = URL(string: "whatsapp://send?text=\(escapedString)")
            {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    let alertCntrl = UIAlertController(title: "", message: "Please install WhatsApp", preferredStyle: .alert)
                    alertCntrl.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertCntrl, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func ActionSMS(_ sender: UIButton)
    {
//        if UserDefaults.standard.value(forKey: "RefereCode") == nil
//        {
//
//        }
//        else
//        {
//            ReferCode = UserDefaults.standard.value(forKey: "RefereCode") as? String
//        }
//
      //  print(ReferCode!)
        if ReferCode == nil
        {
            ReferCode = ""
        }
        let message = String(format: "Hi! #MakingCitiesLiveableAgain with MYBYK, India's largest bicycle-share service. Use referral code %@ to get your first ride free*.\n\n Download now: http://onelink.to/5n7cxf", ReferCode!)
        
              if MFMessageComposeViewController.canSendText() {
                  let controller = MFMessageComposeViewController()
                  controller.body = message
                  controller.recipients = ["xxxxxxxxx", "xxxxxxxxx"] // sending for two numbers
                  controller.messageComposeDelegate = self
                  self.present(controller, animated: true, completion: nil)
              }

    }
    //MARK: - Message Delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        switch (result.rawValue)
        {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ReferFriendVC {
    
    func setUIOnScreen() {
        
        viewBackDetail.roundCorners(corners: [.topLeft, .topRight], radius: 16.0, rect: self.view.frame)
     //   lblRefer.text = strRefer
        lblReferMessage.text = strReferMessage
        
//        viewBackWhatsapp.shadowZ100(frame: viewBackWhatsapp.frame)
//        viewBackSMS.shadowZ100(frame: viewBackSMS.frame)
        
        viewBackWhatsapp.layer.cornerRadius = 8.0
        viewBackSMS.layer.cornerRadius = 8.0
        
//        viewBackWhatsapp.shadowZ100(frame: viewBackWhatsapp.frame)
//        viewBackSMS.shadowZ100(frame: viewBackSMS.frame)
//
        viewBackWhatsapp.shadowZ100WithShadowRadiusWhatsAppMsg(frame: viewBackWhatsapp.frame, radius: 8.0)
        viewBackSMS.shadowZ100WithShadowRadiusWhatsAppMsg(frame: viewBackWhatsapp.frame, radius: 8.0)
      
        
    }
    
}





