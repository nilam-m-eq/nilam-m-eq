//
//  ForgotPasswordVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 23/09/21.
//

import UIKit
import Toaster

class ForgotPasswordVC: CommonViewController {
    // ********** Forgot Password ********** //
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackMobileNumberText: UIView!
    @IBOutlet var lbCounterNumber: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnGetOTP: UIButton!
    @IBOutlet var viewBackForgotPass: UIView!
    
    @IBOutlet var imgPassErrorWarning: UIImageView!
    // *********** OTPView ********** //
    @IBOutlet var viewBackOTP: UIView!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtForth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtSixth: UITextField!
    @IBOutlet var lblOTPCountDown: UILabel!
    @IBOutlet var lblSingleOTP: UILabel!
    @IBOutlet var btnVerifyOTP: UIButton!
    @IBOutlet var btnResendOTP: UIButton!
    @IBOutlet var btnVerifyOTPSmall: UIButton!
    @IBOutlet var stackViewResendOTP: UIStackView!
    
    // *********** PasswordView ********** //
    @IBOutlet var viewBackPassword: UIView!
    @IBOutlet var viewBackNewPassText: UIView!
    @IBOutlet var txtNewPass: UITextField!
    @IBOutlet var viewBackConfirmPassText: UIView!
    @IBOutlet var txtConfirmPass: UITextField!
    @IBOutlet var btnResetPassword: UIButton!
    
    
    @IBOutlet var viewForgotPasswordHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbForgotPasswordError: UILabel!
    
    @IBOutlet var viewPasswordHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbPasswordError: UILabel!
    @IBOutlet var viewPasswordConfrimHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbConfirmPassError: UILabel!
    
    var timerOTP : Timer?
    var intTimer: Int = 30
    var strOTP = String()
    
    
    
    var strIsRegister = String()
    var strCountryCode = String()
    var strContactNumber = String()
    var strFullMobileNumber = String()
    
    var customizedText = NSMutableAttributedString()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewForgotPasswordHeightConstant.constant = 0
        viewPasswordHeightConstant.constant = 0
        viewPasswordConfrimHeightConstant.constant = 0
        
        txtFirst.TextFieldShadow()
        txtSecond.TextFieldShadow()
        txtThird.TextFieldShadow()
        txtForth.TextFieldShadow()
        txtFifth.TextFieldShadow()
        txtSixth.TextFieldShadow()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionGetOTP(_ sender: UIButton) {
        
        if CommonClass.isConnectedToNetwork() == true
        {
            print("Connected to the internet")
            self.getForgotPassOTPAPICall()
          
            
            
            
            //  Do something
        }
        else
        {
            print("No internet connection")
            
            viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
            
            viewInternetConnection.instance.ActionOkay =
            {
                OngoingRideCancelRequestAlert.instance.HidePopup()
            }
            //  Do something
        }
       
        
    }
    
    @IBAction func ActionVerifyOTP(_ sender: UIButton) {
        
        strOTP = "\(self.txtFirst.text!)\(self.txtSecond.text!)\(self.txtThird.text!)\(self.txtForth.text!)\(self.txtFifth.text!)\(self.txtSixth.text!)"
        if strOTP.count == 6
        {
            
            if CommonClass.isConnectedToNetwork() == true
            {
                self.forgotPassVerifyOTPAPICall()
            }
            else
            {
                print("No internet connection")
                
                viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
                
                viewInternetConnection.instance.ActionOkay =
                {
                    OngoingRideCancelRequestAlert.instance.HidePopup()
                }
                //  Do something
            }
        }
        else {
            
            viewForgotPasswordHeightConstant.constant = 15
            lbForgotPasswordError.text = "Please Enter Valid OTP"
          
            txtFirst.viewTextFieldErrorBorder()
            txtSecond.viewTextFieldErrorBorder()
            txtThird.viewTextFieldErrorBorder()
            txtForth.viewTextFieldErrorBorder()
            txtFifth.viewTextFieldErrorBorder()
            txtSixth.viewTextFieldErrorBorder()
            
            
         
//            let toast = Toast(text: "Please Enter Valid OTP", delay: 0.0, duration: Delay.long)
//            toast.show()
        }
        
    }
    
    @IBAction func ActionResendOTP(_ sender: UIButton) {
        
        viewForgotPasswordHeightConstant.constant = 0
        txtFirst.viewBorderWithCornerRadius()
        txtSecond.viewBorderWithCornerRadius()
        txtThird.viewBorderWithCornerRadius()
        txtForth.viewBorderWithCornerRadius()
        txtFifth.viewBorderWithCornerRadius()
        txtSixth.viewBorderWithCornerRadius()
        
        txtFirst.text = ""
        txtSecond.text = ""
        txtThird.text = ""
        txtForth.text = ""
        txtFifth.text = ""
        txtSixth.text = ""
        
        if CommonClass.isConnectedToNetwork() == true
        {
            self.getForgotPassResendOTPAPICall()
        }
        else
        {
            print("No internet connection")
            
            viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
            
            viewInternetConnection.instance.ActionOkay =
            {
                OngoingRideCancelRequestAlert.instance.HidePopup()
            }
            //  Do something
        }
      
    }
    
    @IBAction func ActionVerifyOTPSmall(_ sender: UIButton) {
        
        strOTP = "\(self.txtFirst.text!)\(self.txtSecond.text!)\(self.txtThird.text!)\(self.txtForth.text!)\(self.txtFifth.text!)\(self.txtSixth.text!)"
        if strOTP.count == 6 {
            
            if CommonClass.isConnectedToNetwork() == true
            {
                self.forgotPassVerifyOTPAPICall()
            }
            else
            {
                print("No internet connection")
                
                viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
                
                viewInternetConnection.instance.ActionOkay =
                {
                    OngoingRideCancelRequestAlert.instance.HidePopup()
                }
                //  Do something
            }
           
        }
        else {
            
           // let toast = Toast(text: "Please Enter Valid OTP", delay: 0.0, duration: Delay.long)
          //  toast.show()
            viewForgotPasswordHeightConstant.constant = 15
            lbForgotPasswordError.text = "Please Enter Valid OTP"
            
            txtFirst.viewTextFieldErrorBorder()
            txtSecond.viewTextFieldErrorBorder()
            txtThird.viewTextFieldErrorBorder()
            txtForth.viewTextFieldErrorBorder()
            txtFifth.viewTextFieldErrorBorder()
            txtSixth.viewTextFieldErrorBorder()
        }
    }
    
    @IBAction func ActionResetPassword(_ sender: UIButton) {
        
        let strNewPass = txtNewPass.text!
        let strConfirmPass = txtConfirmPass.text!
        
        if strNewPass.isEmpty
        {
            
          //  let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
         //   toast.show()
            viewPasswordHeightConstant.constant = 15
            viewPasswordConfrimHeightConstant.constant = 0
            lbPasswordError.text = "Field cannot be empty."
            
            viewBackNewPassText.viewTextFieldErrorBorder()
            //txtNewPass.viewTextFieldErrorBorder()
            
            return
        }
        else if strConfirmPass.isEmpty
        {
            viewPasswordHeightConstant.constant = 0
            viewPasswordConfrimHeightConstant.constant = 15
            lbConfirmPassError.text = "Field cannot be empty."
            
            viewBackConfirmPassText.viewTextFieldErrorBorder()
          //  txtConfirmPass.viewTextFieldErrorBorder()
            return
        }
        else if strNewPass != strConfirmPass
        {
            viewPasswordHeightConstant.constant = 0
            viewPasswordConfrimHeightConstant.constant = 15
            lbConfirmPassError.text = "Password does not match!."
            viewBackConfirmPassText.viewTextFieldErrorBorder()
           // txtConfirmPass.viewTextFieldErrorBorder()
           // let toast = Toast(text: "Password does not match!", delay: 0.0, duration: Delay.long)
            //toast.show()
        }
        else {
            
            if CommonClass.isConnectedToNetwork() == true
            {
                self.resetPasswordAPICall()
            }
            else
            {
                print("No internet connection")
                
                viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
                
                viewInternetConnection.instance.ActionOkay =
                {
                    OngoingRideCancelRequestAlert.instance.HidePopup()
                }
                //  Do something
            }
            
        }
        
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ForgotPasswordVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackMobileNumberText.viewBorderWithCornerRadius()
        viewBackNewPassText.viewBorderWithCornerRadius()
        viewBackConfirmPassText.viewBorderWithCornerRadius()
        self.btnGetOTP.layer.cornerRadius = 10.0
        self.btnVerifyOTP.layer.cornerRadius = 10.0
        self.btnResendOTP.layer.cornerRadius = 10.0
        self.btnVerifyOTPSmall.layer.cornerRadius = 10.0
        self.btnResetPassword.layer.cornerRadius = 10.0
        
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
        
        self.txtMobileNumber.text = strFullMobileNumber
        
       
        
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        
        let text = textField.text
        
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
                
                txtFirst.viewTextFieldPrimaryBorder()
                txtSecond.viewTextFieldPrimaryBorder()
                txtThird.viewTextFieldPrimaryBorder()
                txtForth.viewTextFieldPrimaryBorder()
                txtFifth.viewTextFieldPrimaryBorder()
                txtSixth.viewTextFieldPrimaryBorder()
                
                txtFirst.backgroundColor = .clear
                txtSecond.backgroundColor = .clear
                txtThird.backgroundColor = .clear
                txtForth.backgroundColor = .clear
                txtFifth.backgroundColor = .clear
                txtSixth.backgroundColor = .clear
                
            default:
                break
            }
        }
        else
        {
             switch textField
             {
             case txtSixth:
                 txtFifth.becomeFirstResponder()
             case txtFifth:
                 txtForth.becomeFirstResponder()
             case txtForth:
                 txtThird.becomeFirstResponder()
             case txtThird:
                 txtSecond.becomeFirstResponder()
             case txtSecond:
                 txtFirst.becomeFirstResponder()

             default:
                 break
             }
         }
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtNewPass
        {
            return true
        }
        else if textField == txtConfirmPass
        {
            return true
        }
        else
        {
            let maxLength = 1
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
          
      //  return range.location < 1
    }
    @objc func timerCountDown() {
        
        if intTimer == 0 {
            
            timerOTP?.invalidate()
            self.lblSingleOTP.isHidden = false
            self.stackViewResendOTP.isHidden = false
            self.btnVerifyOTP.isHidden = true
        }
        else {
            
            intTimer = intTimer - 1
            
            let minutes = Int(intTimer) / 60 % 60
            let seconds = Int(intTimer) % 60
            
            lbCounterNumber.text = String(format:"%01i:%02i", minutes, seconds)
          //  self.lblOTPCountDown.text = String(format:"Resend OTP in %01i:%02i", minutes, seconds)
            
          //  let strLb =  String(format:"Resend OTP in %01i:%02i", minutes, seconds)
          //  customizedText = NSMutableAttributedString(string: strLb)
          //  customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: 14, length:strLb.count - 14))
            
           // self.lblOTPCountDown.attributedText = customizedText
        }
    }
    
    @objc func timerCountDown59() {
        
        if intTimer == 0 {
            
            timerOTP?.invalidate()
            self.btnResendOTP.isEnabled = true
        }
        else {
            
            intTimer = intTimer - 1
           // self.lblOTPCountDown.text = "\(intTimer) secs Remaining"
            
            let strMinus = " secs Remaining"
            let strLb =  "\(intTimer) secs Remaining"
            let customizedText = NSMutableAttributedString(string: strLb)
           // customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: strLb.count - strMinus.count, length:strLb.count - strMinus.count))
            customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: 0, length:strLb.count - strMinus.count))
            self.lblOTPCountDown.attributedText = customizedText
        }
    }
    
}

// MARK:- UITextField Delegate Methods
extension ForgotPasswordVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
      //  textField.text = ""
        viewForgotPasswordHeightConstant.constant = 0
        viewPasswordHeightConstant.constant = 0
        viewPasswordConfrimHeightConstant.constant = 0
        
        //txtNewPass.viewTextFieldPrimaryBorder()
      //  txtConfirmPass.viewTextFieldPrimaryBorder()
        
        if textField == txtNewPass
        {
            viewBackNewPassText.viewTextFieldPrimaryBorder()
        }
        if textField == txtConfirmPass
        {
            viewBackConfirmPassText.viewTextFieldPrimaryBorder()
        }
//        txtFirst.viewTextFieldPrimaryBorder()
//        txtSecond.viewTextFieldPrimaryBorder()
//        txtThird.viewTextFieldPrimaryBorder()
//        txtForth.viewTextFieldPrimaryBorder()
//        txtFifth.viewTextFieldPrimaryBorder()
//        txtSixth.viewTextFieldPrimaryBorder()
    }
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension ForgotPasswordVC {
    
    func getForgotPassOTPAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getForgotPassOTPAPICall(dictionary: ["countrycode": strCountryCode, "contactNumber":strContactNumber, "completecontactnumber": strFullMobileNumber, "forgotPassword":"1", "sendOTP":"1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                self.viewBackForgotPass.isHidden = true
                self.viewBackOTP.isHidden = false
                
                self.btnGetOTP.isHidden = true
                self.btnVerifyOTP.isHidden = false
                
                self.timerOTP = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountDown), userInfo: nil, repeats: true)
                
            }
            else {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    
    func getForgotPassResendOTPAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getForgotPassResendOTPAPICall(dictionary: ["contactNumber":strFullMobileNumber, "resendOTPReg": "1", "isuserregister":strIsRegister]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                self.btnResendOTP.isEnabled = false
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                self.intTimer = 50
                self.timerOTP = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountDown59), userInfo: nil, repeats: true)
                
            }
            else {
                
              //  let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
            //    toast.show()
                viewForgotPasswordHeightConstant.constant = 15
                lbForgotPasswordError.text = "\(response["message"] as! String)"
                
                txtFirst.viewTextFieldErrorBorder()
                txtSecond.viewTextFieldErrorBorder()
                txtThird.viewTextFieldErrorBorder()
                txtForth.viewTextFieldErrorBorder()
                txtFifth.viewTextFieldErrorBorder()
                txtSixth.viewTextFieldErrorBorder()
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    
    func forgotPassVerifyOTPAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.forgotPassVerifyOTPAPICall(dictionary: ["contactNumber":strFullMobileNumber, "otp": strOTP, "forgotPassword":"1", "verifyOTP":"1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                self.btnResendOTP.isEnabled = false
                self.viewBackPassword.isHidden = false
                self.btnResetPassword.isHidden = false
                self.viewBackOTP.isHidden = true
                self.stackViewResendOTP.isHidden = true
                
                let dicVerifyData = response["data"] as! [String:Any]
                strTempAuthKey = "\(dicVerifyData["authkey"] as! String)"
                
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                self.timerOTP?.invalidate()
                
            }
            else {
                
             //   let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
             //   toast.show()
                viewForgotPasswordHeightConstant.constant = 15
                lbForgotPasswordError.text = "\(response["message"] as! String)"
                
                txtFirst.viewTextFieldErrorBorder()
                txtSecond.viewTextFieldErrorBorder()
                txtThird.viewTextFieldErrorBorder()
                txtForth.viewTextFieldErrorBorder()
                txtFifth.viewTextFieldErrorBorder()
                txtSixth.viewTextFieldErrorBorder()
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    
    func resetPasswordAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.resetPasswordAPICall(dictionary: ["newPassword":"\(txtNewPass.text!)", "confirmNewPassword": "\(txtConfirmPass.text!)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                self.navigationController?.popViewController(animated: true)
            }
            else {
                
                if response["error_code"] as! String == "401"
                {
                   
                    viewPasswordHeightConstant.constant = 15
                    viewPasswordConfrimHeightConstant.constant = 0
                    lbPasswordError.text = "\(response["message"] as! String)"
                    viewBackNewPassText.viewTextFieldErrorBorder()
                    viewBackConfirmPassText.viewTextFieldErrorBorder()
                    return
                }
            //    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
            //    toast.show()
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    
    
    
    
}











