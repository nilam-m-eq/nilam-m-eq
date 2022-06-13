//
//  LoginWithPasswordVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 14/09/21.
//

import UIKit
import Toaster

class LoginWithPasswordVC: CommonViewController, UITextFieldDelegate
{
    @IBOutlet var viewPasswordBack: UIView!
    @IBOutlet var viewBackEnterPassword: UIView!
    @IBOutlet var txtEnterPassword: UITextField!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnHideShowPass: UIButton!
    
    @IBOutlet var lbLoginPasswordErrorMsg: UILabel!
    @IBOutlet var viewLoginPasswordWrongHeightConst: NSLayoutConstraint!
    var strIsRegister = String()
    var strCountryCode = String()
    var strContactNumber = String()
    var strFullMobileNumber = String()
    var flag = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print(strFullMobileNumber)
        
        viewLoginPasswordWrongHeightConst.constant = 0
        txtEnterPassword.delegate = self
        txtEnterPassword.addTarget(self, action: #selector(LoginWithPasswordVC.textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        txtEnterPassword.isSecureTextEntry = true
        self.setUIOnScreen()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
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
    // MARK: - Textfield delegate
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if txtEnterPassword.text == ""
        {
            viewBackEnterPassword.viewBorderWithCornerRadius()
            viewLoginPasswordWrongHeightConst.constant = 0
           // lbLoginPasswordErrorMsg.text = "Field cannot be empty."
        }
        else
        {
            viewBackEnterPassword.layer.borderColor = UIColor(named:Color_Primary)?.cgColor
            viewLoginPasswordWrongHeightConst.constant = 0
        }
    }
//    func textFieldDidBeginEditing(_ textField: UITextField)
//    {
//        txtEnterPassword.selectedTextRange = txtEnterPassword.textRange(from: txtEnterPassword.beginningOfDocument, to: txtEnterPassword.endOfDocument)
//
//    }
    // ********** All Button Actions ********** //
    @IBAction func btnHideShowClicked(_ sender: Any)
    {
      
        if flag == true
        {
            if #available(iOS 13.0, *) {
           
                btnHideShowPass.setImage(UIImage(named: "IC_EyeClose"), for: UIControl.State.normal)
                txtEnterPassword.isSecureTextEntry = false
                flag = false
               
            } else {
               
                
                     btnHideShowPass.setImage(UIImage(named: "IC_EyeClose"), for: UIControl.State.normal)
                     txtEnterPassword.isSecureTextEntry = false
                     flag = false
                // Fallback on earlier versions
            }
          
        }
        else
        {
            if #available(iOS 13.0, *) {
             
                btnHideShowPass.setImage(UIImage(named: "IC_EyeShow"), for: UIControl.State.normal)
                txtEnterPassword.isSecureTextEntry = true
                flag = true
            } else {
                btnHideShowPass.setImage(UIImage(named: "IC_EyeShow"), for: UIControl.State.normal)
                txtEnterPassword.isSecureTextEntry = true
                flag = true
                // Fallback on earlier versions
            }
           
        }
    }
    @IBAction func ActionClose(_ sender: UIButton)
    {
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            self.view.frame.origin.y = self.view.frame.height
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
        
    }
    
    @IBAction func ActionForgotPassword(_ sender: UIButton) {
        
        let forgotPass = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        forgotPass.strCountryCode = strCountryCode
        forgotPass.strContactNumber = strContactNumber
        forgotPass.strFullMobileNumber = strFullMobileNumber
        forgotPass.strIsRegister = strIsRegister
        self.navigationController?.pushViewController(forgotPass, animated: true)
        
    }
    
    @IBAction func ActionSignIn(_ sender: UIButton)
    {
        
        /*
         
         {
             viewBackEnterPassword.viewBorderWithCornerRadius()
             viewLoginPasswordWrongHeightConst.constant = 0
            // lbLoginPasswordErrorMsg.text = "Field cannot be empty."
         }
         else
         {
             viewBackEnterPassword.layer.borderColor = UIColor(named:Color_Primary)?.cgColor
             viewLoginPasswordWrongHeightConst.constant = 0
         }
         */
        if txtEnterPassword.text?.count == 0
        {
            viewLoginPasswordWrongHeightConst.constant = 15
            lbLoginPasswordErrorMsg.text = "Field cannot be empty."
            viewBackEnterPassword.viewTextFieldErrorBorder()
            //  viewBackMobileNumberText.viewTextFieldErrorBorder()
           // viewBackEnterPassword.layer.borderColor = UIColor(named:Color_Warning)?.cgColor
           // self.viewPasswordBack.viewTextFieldWarningBorder()
          //  let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
          //  toast.show()
            
        }
        else
        {
            if CommonClass.isConnectedToNetwork() == true   
            {
                print("Connected to the internet")
                self.signInWithPasswordAPICall()
              
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
        
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //

extension LoginWithPasswordVC
{
    func setUIOnScreen()
    {
        
        self.view.alpha = 1.0
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
        
        viewPasswordBack.roundCorners(corners: [.topLeft, .topRight], radius: 8.0, rect: self.view.frame)
        viewBackEnterPassword.viewBorderWithCornerRadius()
        self.btnSignIn.layer.cornerRadius = 10.0
        
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension LoginWithPasswordVC {
    
    func signInWithPasswordAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.signIsWithPasswordAPICall(dictionary: ["contactNumber": "\(strFullMobileNumber)", "password": "\(txtEnterPassword.text!)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: response, options: [])
                    let jsonData = try JSONDecoder().decode(LoginWithPass.self, from: data)
                    
                    print(jsonData.data)
                    
                    UserDefaults.standard.setValue(jsonData.data.authkey, forKey: "authkey")
                    UserDefaults.standard.synchronize()
                    
                    
                    if jsonData.data.currentRide == "true"
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
                   
                    
                } catch {
                    print("error")
                }
                
            }
            else {
                
             //   let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
              //  toast.show()
                viewLoginPasswordWrongHeightConst.constant = 15
                lbLoginPasswordErrorMsg.text = "\(response["message"] as! String)"
                viewBackEnterPassword.layer.borderColor = UIColor(named:Color_Warning)?.cgColor
            }
            
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
}



