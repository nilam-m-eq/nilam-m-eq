//
//  OTPVerificationVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 23/06/21.
//

import UIKit
import Toaster
import IQKeyboardManagerSwift
import NotificationCenter

class OTPVerificationVC: CommonViewController {
    @IBOutlet weak var viewOTPBack: UIView!
    @IBOutlet var lbTimerCount: UILabel!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtForth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtSixth: UITextField!
    @IBOutlet weak var lblOTPResendTimer: UILabel!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet var btnResendOTP: UIButton!
    @IBOutlet var btnVerifyOTPSmall: UIButton!
    @IBOutlet var stackViewResendOTP: UIStackView!
    @IBOutlet var lblSingleOTP: UILabel!
    
    @IBOutlet var ViewOTPHeightConstErrorHeightConst: NSLayoutConstraint!
    @IBOutlet var lbOTPTextErrorMsg: UILabel!
    var timerOTP : Timer?
    var intTimer: Int = 30
    var strOTP = String()
    
    var strIsRegister = String()
    var strCountryCode = String()
    var strContactNumber = String()
    var strFullMobileNumber = String()
    
    //    var viewModel = OTPTimerViewModel(state: .timerStopped(OTPSecond(secondsRemaining: 30, initialSecondsRemaining: 30))) {
    //        didSet {
    //            switch self.viewModel.state {
    //            case .timerStarted(_):
    //                CountdownTimer.sharedInstace.start()
    //            default:
    //                CountdownTimer.sharedInstace.stop()
    //            }
    //            self.updateUIForOTPTimer()
    //        }
    //    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      
        
       
    
      //  txtSixth.clearsOnBeginEditing = true
    //    txtFirst.clearButtonMode = .always
       
        
        
    
        //        CountdownTimer.sharedInstace.handler = { [weak self] in
        //            self?.handleTick()
        //        }
        //        self.updateUIForOTPTimer()
        //        self.viewModel = self.viewModel.buttonTapped()
    }
    
    //    deinit {
    //        CountdownTimer.sharedInstace.handler = nil
    //    }
    
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
    //MARK: - Hide keyboard
    
    @objc func MethodShow(notification: Notification)
    {
       
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func MethodHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //MARK: - button action
    // ********** All Button Actions ********** //
    @IBAction func ActionClose(_ sender: UIButton)
    {
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            self.view.frame.origin.y = self.view.frame.height
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
        
    }
    
    @IBAction func ActionVerify(_ sender: UIButton)
    {
        strOTP = "\(self.txtFirst.text!)\(self.txtSecond.text!)\(self.txtThird.text!)\(self.txtForth.text!)\(self.txtFifth.text!)\(self.txtSixth.text!)"
        if strOTP.count == 6
        {
            if CommonClass.isConnectedToNetwork() == true
            {
                print("Connected to the internet")
                self.loginVerifyOTPAPICall()
              
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
        else
        {
            
            //            let toast = Toast(text: "Please Enter Valid OTP", delay: 0.0, duration: Delay.long)
            //            toast.show()
            
            //  AlertView.instance.showAlert(message: "Please Enter Valid OTP", image: "IC_ErrorIcon", alertType: .success)
            
            ViewOTPHeightConstErrorHeightConst.constant = 15
            lbOTPTextErrorMsg.text = "Please Enter Valid OTP"
            
            txtFirst.viewTextFieldErrorBorder()
            txtSecond.viewTextFieldErrorBorder()
            txtThird.viewTextFieldErrorBorder()
            txtForth.viewTextFieldErrorBorder()
            txtFifth.viewTextFieldErrorBorder()
            txtSixth.viewTextFieldErrorBorder()
        }
        
        
        
           /* txtFirst.TextFieldColorBorder()
            txtSecond.TextFieldColorBorder()
            txtThird.TextFieldColorBorder()
            txtFifth.TextFieldColorBorder()
            txtSixth.TextFieldColorBorder()
            txtForth.TextFieldColorBorder()*/
            //TextFieldColorBorder
            
    }
    
    @IBAction func ActionResendOTP(_ sender: UIButton)
    {
        if CommonClass.isConnectedToNetwork() == true
        {
            self.ClearOTPText()
            self.getLoginResendOTPAPICall()
        }
        else
        {
            print("No internet connection")
            
            viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
            
            viewInternetConnection.instance.ActionOkay =
            {
                OngoingRideCancelRequestAlert.instance.HidePopup()
            }
        }
       
    }
    
    @IBAction func ActionVerifyOTPSmall(_ sender: UIButton)
    {
        
        strOTP = "\(self.txtFirst.text!)\(self.txtSecond.text!)\(self.txtThird.text!)\(self.txtForth.text!)\(self.txtFifth.text!)\(self.txtSixth.text!)"
        if strOTP.count == 6
        {
            if CommonClass.isConnectedToNetwork() == true
            {
                self.loginVerifyOTPAPICall()
            }
            else
            {
                print("No internet connection")
                
                viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
                
                viewInternetConnection.instance.ActionOkay =
                {
                    OngoingRideCancelRequestAlert.instance.HidePopup()
                }
            }
            
        }
        else
        {
            
            //            let toast = Toast(text: "Please Enter Valid OTP", delay: 0.0, duration: Delay.long)
            //            toast.show()
            
           // AlertView.instance.showAlert(message: "Please Enter Valid OTP", image: "IC_ErrorIcon", alertType: .success)'
            ViewOTPHeightConstErrorHeightConst.constant = 15
            lbOTPTextErrorMsg.text = "Please Enter Valid OTP"
            
            txtFirst.viewTextFieldErrorBorder()
            txtSecond.viewTextFieldErrorBorder()
            txtThird.viewTextFieldErrorBorder()
            txtForth.viewTextFieldErrorBorder()
            txtFifth.viewTextFieldErrorBorder()
            txtSixth.viewTextFieldErrorBorder()
        }
        
    }
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension UITextField
{
    func TextFieldShadow()
    {
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor(red: 189.0/255.0, green: 189.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        layer.shadowOpacity = 1.0
        
        /*
         shadowButton.layer.shadowOpacity = 0.7
         shadowButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
         shadowButton.layer.shadowRadius = 15.0
         shadowButton.layer.shadowColor = UIColor.yellowColor().CGColor
         view.backgroundColor = UIColor.grayColor()
         view.layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1)
         
         layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
         layer.cornerRadius = 3
         layer.borderWidth = 1
         layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1).cgColor
         */
    }
    func TextFieldColorBorder()
    {
        layer.borderColor = UIColor.red.cgColor
    }
}
extension OTPVerificationVC
{
    
    func ClearOTPText()
    {
        txtFirst.text = ""
        txtSecond.text = ""
        txtThird.text = ""
        txtForth.text = ""
        txtFifth.text = ""
        txtSixth.text = ""
    }
    func setUIOnScreen() {
        
        txtFirst.delegate = self
        txtSecond.delegate = self
        txtThird.delegate = self
        txtForth.delegate = self
        txtFifth.delegate = self
        txtSixth.delegate = self
        
        txtFirst.TextFieldShadow()
        txtSecond.TextFieldShadow()
        txtThird.TextFieldShadow()
        txtForth.TextFieldShadow()
        txtFifth.TextFieldShadow()
        txtSixth.TextFieldShadow()
        
        self.timerOTP = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountDown), userInfo: nil, repeats: true)
        
        ViewOTPHeightConstErrorHeightConst.constant = 0
        
        self.view.alpha = 1.0
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
        
        viewOTPBack.roundCorners(corners: [.topLeft, .topRight], radius: 8.0, rect: self.view.frame)
        self.btnVerify.layer.cornerRadius = 10.0
        self.btnResendOTP.layer.cornerRadius = 10.0
        self.btnVerifyOTPSmall.layer.cornerRadius = 10.0
        
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
    
    @objc func timerCountDown() {
        
        if intTimer == 0 {
            
            timerOTP?.invalidate()
            self.lblSingleOTP.isHidden = false
            self.stackViewResendOTP.isHidden = false
            self.btnVerify.isHidden = true
        }
        else
        {
            
            intTimer = intTimer - 1
            
            let minutes = Int(intTimer) / 60 % 60
            let seconds = Int(intTimer) % 60
            
            //  self.lblOTPResendTimer.text = String(format:"Resend OTP in %01i:%02i", minutes, seconds)
            
            /*
             Rubik Bold 13.0
             
             Rubik Regular 13.0
             */
            //UIFont.boldSystemFont(ofSize: 15.0)
            let strLb =  String(format:"%01i:%02i", minutes, seconds)
          //  let customizedText = NSMutableAttributedString(string: strLb)
        
            
           // customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: 14, length:strLb.count - 14))
            self.lbTimerCount.text = strLb
        }
    }
    
    @objc func timerCountDown59() {
        
        if intTimer == 0 {
            
            timerOTP?.invalidate()
            self.btnResendOTP.isEnabled = true
        }
        else {
            
            intTimer = intTimer - 1
            
            let strMinus = " secs Remaining"
            let strLb =  "\(intTimer) secs Remaining"
            let customizedText = NSMutableAttributedString(string: strLb)
           // customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: strLb.count - strMinus.count, length:strLb.count - strMinus.count))
            customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: 0, length:strLb.count - strMinus.count))
            self.lblOTPResendTimer.attributedText = customizedText
            
            //  self.lblOTPResendTimer.text = "\(intTimer) secs Remaining"
        }
    }
    
    //    func updateUIForOTPTimer() {
    //
    //        self.lblOTPResendTimer.text = "Resend OTP in \(self.viewModel.lblText)"
    //    }
    
    //    private func handleTick() {
    //        self.viewModel = self.viewModel.tick()
    //    }
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        let text = textField.text
        
        print((text?.utf16.count)! as Int)
        if (text?.utf16.count)! >= 1
        {
            
            switch textField
            {
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
               
                //viewTextFieldActiveBorder
                txtSixth.resignFirstResponder()
                
            default:
                break
            }
        }
       else
       {
            switch textField
            {
            case txtSixth:
                txtFirst.viewTextFieldActiveBorder()
                txtSecond.viewTextFieldActiveBorder()
                txtThird.viewTextFieldActiveBorder()
                txtForth.viewTextFieldActiveBorder()
                txtFifth.viewTextFieldActiveBorder()
                txtSixth.viewTextFieldActiveBorder()
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
           let maxLength = 1
           let currentString: NSString = textField.text! as NSString
           let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= maxLength
      //  return range.location < 1
    }
    
}



// MARK:- UITextField Delegate Methods
extension OTPVerificationVC : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        ViewOTPHeightConstErrorHeightConst.constant = 0
        
        if textField == txtSixth
        {
            txtFirst.viewTextFieldPrimaryBorder()
            txtSecond.viewTextFieldPrimaryBorder()
            txtThird.viewTextFieldPrimaryBorder()
            txtForth.viewTextFieldPrimaryBorder()
            txtFifth.viewTextFieldPrimaryBorder()
            txtSixth.viewTextFieldPrimaryBorder()
        }
//        txtFirst.viewTextFieldPrimaryBorder()
//        txtSecond.viewTextFieldPrimaryBorder()
//        txtThird.viewTextFieldPrimaryBorder()
//        txtForth.viewTextFieldPrimaryBorder()
//        txtFifth.viewTextFieldPrimaryBorder()
//        txtSixth.viewTextFieldPrimaryBorder()
        
//        textField.text = ""
        
        //  IQKeyboardManager.shared.accessibilityNavigationStyle = .automatic
        //  self.navigationController?.isNavigationBarHidden = false
            //  IQKeyboardManager.shared.enableAutoToolbar = false
        
    }
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        print(updatedText)
        // make sure the result is under 16 characters
        return updatedText.count <= 16
    }*/
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension OTPVerificationVC {
    
    func getLoginResendOTPAPICall()
    {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getLoginResendOTPAPICall(dictionary: ["contactNumber":strFullMobileNumber, "resendOTPReg": "1", "isuserregister":strIsRegister]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                self.btnResendOTP.isEnabled = false
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                ViewOTPHeightConstErrorHeightConst.constant = 0
             //   lbOTPTextErrorMsg.text = "\(response["message"] as! String)"
                
                self.intTimer = 50
                self.timerOTP = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountDown59), userInfo: nil, repeats: true)
                
            }
            else
            {
                
//                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
//                toast.show()
                ViewOTPHeightConstErrorHeightConst.constant = 0
                lbOTPTextErrorMsg.text = "\(response["message"] as! String)"
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    
    func loginVerifyOTPAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.loginVerifyOTPAPICall(dictionary: ["contactNumber":strFullMobileNumber, "otp": strOTP]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
              //  ViewOTPHeightConstErrorHeightConst.constant = 15
            //    lbOTPTextErrorMsg.text = "\(response["message"] as! String)"
                
               // let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
              //  toast.show()
                
                self.timerOTP?.invalidate()
                
                let dicOTPdata = response["data"] as! [String: Any]
                
                if dicOTPdata["new_register"] as! String == "false"
                {
                    
                    self.loginRequestAPICall(strNewRegister: "\(dicOTPdata["new_register"] as! String)")
                    
                }
                else
                {
                    /*
                     checkFromOTPFirstTime
                     */
                    let anim = self.storyboard?.instantiateViewController(withIdentifier: "OTPAnimationVC") as! OTPAnimationVC
                    anim.checkFromOTPFirstTime = "SetupProfile"
                    anim.strFullMobileNumberAdd = self.strFullMobileNumber
                 //   anim.strRideStatus =
                    self.navigationController?.pushViewController(anim, animated: false)
                    
//                    let setupProfVC = self.storyboard?.instantiateViewController(withIdentifier: "SetupProfileVC") as! SetupProfileVC
//                    setupProfVC.strFullMobileNumber = self.strFullMobileNumber
//                    self.navigationController?.pushViewController(setupProfVC, animated: true)
                }
                
            }
            else {
                
               // let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
              //  toast.show()
                ViewOTPHeightConstErrorHeightConst.constant = 15
                
                lbOTPTextErrorMsg.text = "\(response["message"] as! String)"
                
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
    
    func loginRequestAPICall(strNewRegister: String) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        
        let strToken = "\(UserDefaults.standard.value(forKey: "deviceToken") as! String)"
        
        APIService.sharedInstance.loginRequestAPICall(dictionary: ["contactNumber":strFullMobileNumber, "new_register": strNewRegister, "token": strToken]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: response, options: [])
                    let jsonData = try JSONDecoder().decode(LoginWithPass.self, from: data)
                    
                    print(jsonData.data)
                    
                    UserDefaults.standard.setValue(jsonData.data.authkey, forKey: "authkey")
                    UserDefaults.standard.synchronize()
                    
//                    let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                    self.navigationController?.pushViewController(tabVC, animated: true)
                    
//                    let anim = self.storyboard?.instantiateViewController(withIdentifier: "OTPAnimationVC") as! OTPAnimationVC
//                    self.navigationController?.pushViewController(anim, animated: false)
                    
                    let anim = self.storyboard?.instantiateViewController(withIdentifier: "OTPAnimationVC") as! OTPAnimationVC
                    anim.checkFromOTPFirstTime = "SetupOTP"
                    anim.strFullMobileNumberAdd = ""
                    anim.strRideStatus = jsonData.data.currentRide
                    self.navigationController?.pushViewController(anim, animated: false)
                    
                    
                } catch {
                    print("error")
                }
                
            }
            else {
                
             //   let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
              //  toast.show()
                ViewOTPHeightConstErrorHeightConst.constant = 15
                lbOTPTextErrorMsg.text = "\(response["message"] as! String)"
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    
}
