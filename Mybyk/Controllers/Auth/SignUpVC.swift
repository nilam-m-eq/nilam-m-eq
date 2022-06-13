//
//  SignUpVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 22/06/21.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var btnGetStarted: UIButton!
    
    @IBOutlet var CollLottieDisplay: UICollectionView!
    
    var aryLottieData = ["lf20_tphlkzpl","lf20_tphlkzpl","lf20_tphlkzpl"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setUIOnScreen()
    }
    
    
    // ********** All Button Actions ********** //
    @IBAction func ActionGetStarted(_ sender: UIButton)
    {
        
        let goToEnterMobile = self.storyboard?.instantiateViewController(withIdentifier: "EnterMobileNumberVC") as! EnterMobileNumberVC
        self.navigationController?.pushViewController(goToEnterMobile, animated: true)
        
    }
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension SignUpVC {
    
    func setUIOnScreen() {
        
        self.btnGetStarted.layer.cornerRadius = 10.0
    }
    
}

