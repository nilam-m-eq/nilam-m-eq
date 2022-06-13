//
//  EnterReferralCodeVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 23/06/21.
//

import UIKit
import Toaster

class EnterReferralCodeVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackVerifiedSuccess: UIView!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtForth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtSixth: UITextField!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    var strUserID = String()
    var strReferral = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionSkip(_ sender: UIButton) {
        
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.navigationController?.pushViewController(tabVC, animated: true)
    }
    
    @IBAction func ActionDone(_ sender: UIButton) {
        
        strReferral = "\(self.txtFirst.text!)\(self.txtSecond.text!)\(self.txtThird.text!)\(self.txtForth.text!)\(self.txtFifth.text!)\(self.txtSixth.text!)"
        if strReferral.count == 6 {
            self.referralNewRegisterAPICall()
        }
        else {
            
            let toast = Toast(text: "Verification failed! Please try again.", delay: 0.0, duration: Delay.long)
            toast.show()
        }
        
    }
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EnterReferralCodeVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnSkip.layer.cornerRadius = 10.0
        self.btnSkip.shadowSecondaryBtn(frame: self.btnSkip.frame)
        self.btnDone.layer.cornerRadius = 10.0
        
        txtFirst.viewBorderWithCornerRadius()
        txtSecond.viewBorderWithCornerRadius()
        txtThird.viewBorderWithCornerRadius()
        txtForth.viewBorderWithCornerRadius()
        txtFifth.viewBorderWithCornerRadius()
        txtSixth.viewBorderWithCornerRadius()
        
        txtFirst.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtSecond.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtThird.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtForth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtFifth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtSixth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        
        let text = textField.text
        textField.viewTextFieldPrimaryBorder()
        
        if (text?.utf16.count)! >= 1 {
            
            switch textField {
            case txtFirst:
                txtSecond.becomeFirstResponder()
            case txtSecond:
                txtThird.becomeFirstResponder()
            case txtThird:
                txtForth.becomeFirstResponder()
            case txtForth:
                txtFifth.becomeFirstResponder()
            case txtFifth:
                txtSixth.becomeFirstResponder()
            case txtSixth:
                txtSixth.resignFirstResponder()
                self.viewBackVerifiedSuccess.isHidden = false
                self.btnSkip.setTitle("SKIP FOR NOW", for: .normal)
            default:
                break
            }
        }
        
    }
    
}

// MARK:- UITextField Delegate Methods
extension EnterReferralCodeVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        
        textField.viewBorderWithCornerRadius()
        
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension EnterReferralCodeVC {
    
    func referralNewRegisterAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.referralNewRegisterAPICall(dictionary: ["referralCode": strReferral, "idUser": strUserID]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
               /* let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()*/
                
                let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                self.navigationController?.pushViewController(tabVC, animated: true)
                
            }
            else
            {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    
}




