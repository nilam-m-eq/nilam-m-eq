//
//  OTPAnimationVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 07/03/22.
//

import UIKit
import Lottie

class OTPAnimationVC: UIViewController {
    @IBOutlet var viewAnimation: AnimationView!
  //  var view1 = UIView()
    var animatView : AnimationView?
    let lableMsg = UILabel()
    var checkFromOTPFirstTime : String!
    var strFullMobileNumberAdd = String()
    var strRideStatus : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        viewAnimation = .init(name: "Confirmation tickReditect")
//        viewAnimation.contentMode = .scaleAspectFit
//        viewAnimation.loopMode = .playOnce
//        viewAnimation.animationSpeed = 0.5
//        viewAnimation.play()
        
//        view1 = UIView(frame: UIApplication.shared.keyWindow!.frame)
//        view1.backgroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
        
        animatView = .init(name: "Confirmation tickReditect")
        animatView!.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animatView!.contentMode = .scaleAspectFit
        animatView!.loopMode = .playOnce
        animatView!.animationSpeed = 1.0
        animatView?.center = CGPoint(x: UIApplication.shared.keyWindow!.frame.width / 2, y: UIApplication.shared.keyWindow!.frame.height / 2)
        lableMsg.frame = CGRect(x: 0, y:  (UIApplication.shared.keyWindow!.frame.height / 2) + 40, width: (UIApplication.shared.keyWindow?.frame.width)!, height: 90)
        lableMsg.font = UIFont(name: "Rubik-Regular", size: 24.0)
        lableMsg.text = "OTP Verified Successfully!"
        lableMsg.numberOfLines = 1
       // lableMsg.attributedText = NSMutableAttributedString(string: "OTP Verified\nSuccessfully!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])


       // lableMsg.backgroundColor = .red
        lableMsg.textAlignment = .center
        view.addSubview(lableMsg)
        view.addSubview(animatView!)
        animatView?.play(completion: { status in
            
        print(status)
            /*
             let anim = self.storyboard?.instantiateViewController(withIdentifier: "OTPAnimationVC") as! OTPAnimationVC
             anim.checkFromOTPFirstTime = "SetupProfile"
             anim.strFullMobileNumberAdd = self.strFullMobileNumber
             self.navigationController?.pushViewController(anim, animated: false)
             
             let anim = self.storyboard?.instantiateViewController(withIdentifier: "OTPAnimationVC") as! OTPAnimationVC
             anim.checkFromOTPFirstTime = "SetupOTP"
             anim.strFullMobileNumberAdd = ""
             self.navigationController?.pushViewController(anim, animated: false)
             */
            print(self.strFullMobileNumberAdd)
            print(self.checkFromOTPFirstTime!)
            if self.checkFromOTPFirstTime == "SetupProfile"
            {
                
                    let setupProfVC = self.storyboard?.instantiateViewController(withIdentifier: "SetupProfileVC") as! SetupProfileVC
                    setupProfVC.strFullMobileNumber = self.strFullMobileNumberAdd
                    self.navigationController?.pushViewController(setupProfVC, animated: true)
            }
            if self.checkFromOTPFirstTime == "SetupOTP"
            {
                if self.strRideStatus == "true"
                {
                    let Ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                    Ongoing.isHome = false
                    self.navigationController?.pushViewController(Ongoing, animated: true)
                }
                else
                {
                    let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    self.navigationController?.pushViewController(tabVC, animated: true)
                }
                
            }
            
        })
//        window.addSubview(view)
//        self.view.addSubview(view1)
        
    }
    

}
