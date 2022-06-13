//
//  SetupProfileVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 23/06/21.
//

import UIKit
import CoreLocation
import Toaster

class SetupProfileVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet var viewBackFirstName: UIView!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var viewBackLastName: UIView!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet weak var viewBackEmailID: UIView!
    @IBOutlet weak var txtYourEmailID: UITextField!
    @IBOutlet weak var viewBackMobileNumber: UIView!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet var viewBackYourPassword: UIView!
    @IBOutlet var txtYourPassword: UITextField!
    @IBOutlet var viewBackConfirmPassword: UIView!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var btnTermAccept: UIButton!
    @IBOutlet weak var btnProceed: UIButton!
    
    @IBOutlet var viewTermConditionHeightConst: NSLayoutConstraint!
    var strFullMobileNumber = String()
    
    @IBOutlet var lbFirstnameHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbPasswordHeightConst: NSLayoutConstraint!
    @IBOutlet var lbEmailHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbLastnameHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbMobileNumberHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbConfirmPassHeightConst: NSLayoutConstraint!
    
    @IBOutlet var lbFirstnameError: UILabel!
    @IBOutlet var lbSecondnameErroe: UILabel!
    @IBOutlet var lbEmailError: UILabel!
    @IBOutlet var lbMobileNumberError: UILabel!
    @IBOutlet var lbPasswordError: UILabel!
    @IBOutlet var lbConfirmError: UILabel!
    let locManager = CLLocationManager()
    
    var CheckTerm  = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 0)
        self.validatiohHeight(txtField: lbLastnameHeightConstant,val: 0)
        self.validatiohHeight(txtField: lbEmailHeightConstant,val: 0)
        self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
        self.validatiohHeight(txtField: lbPasswordHeightConst,val: 0)
        self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
        self.validatiohHeight(txtField: viewTermConditionHeightConst,val: 0)
        
        //viewTermConditionHeightConst
        //txtFirstName.addTarget(self, action: #selector(SetupProfileVC.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        self.setUIOnScreen()
    }
    //MARK: - button action
    // ********** All Button Actions ********** //
    @IBAction func btnBackClicked(_ sender: Any)
    {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: EnterMobileNumberVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
       // self.navigationController?.popViewController(animated: true)
       // self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func ActionTermAccept(_ sender: UIButton)
    {
        
        if CheckTerm == true
        {
            
           
            
            //IC_CheckSelected
            
            btnTermAccept.setImage(UIImage(named: "IC_CheckSelected"), for: UIControl.State.normal)
            
            btnTermAccept.backgroundColor = .clear
            btnTermAccept.layer.cornerRadius = 0
            btnTermAccept.layer.borderWidth = 0
            btnTermAccept.layer.borderColor = UIColor.clear.cgColor
          
            
            self.validatiohHeight(txtField: viewTermConditionHeightConst,val: 0)
            CheckTerm = false
        }
        else
        {
            btnTermAccept.setImage(nil, for: UIControl.State.normal)
            
            btnTermAccept.backgroundColor = .clear
            btnTermAccept.layer.cornerRadius = 3
            btnTermAccept.layer.borderWidth = 2
            btnTermAccept.layer.borderColor = UIColor(named: "Color_Primary")?.cgColor
            
           
      //      self.validatiohHeight(txtField: viewTermConditionHeightConst,val: 15)
            
            CheckTerm = true
        }
    }
    
    @IBAction func ActionProceed(_ sender: UIButton)
    {
        
        let strNewPass = txtYourPassword.text!
        let strConfirmPass = txtConfirmPassword.text!
        
//        if txtFirstName.text!.isEmpty || txtLastName.text!.isEmpty || txtYourEmailID.text!.isEmpty || strNewPass.isEmpty || strConfirmPass.isEmpty
//        {
//
//
//           // let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
//           // toast.show()
//
//        }
        if txtFirstName.text!.isEmpty
        {
            
            self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 15)
            self.validatiohHeight(txtField: lbLastnameHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbEmailHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbPasswordHeightConst,val: 0)
            self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
            viewBackFirstName.viewTextFieldErrorBorder()
            lbFirstnameError.text = "Field cannot be empty."
            return
           // let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
           // toast.show()
            
        }
        if txtLastName.text!.isEmpty
        {
            
            self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 15)
            self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbEmailHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbPasswordHeightConst,val: 0)
            self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
            viewBackLastName.viewTextFieldErrorBorder()
            lbSecondnameErroe.text = "Field cannot be empty."
            return
            
           // let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
           // toast.show()
            
        }
        if  txtYourEmailID.text!.isEmpty
        {
            
            self.validatiohHeight(txtField: lbEmailHeightConstant, val: 15)
            self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbPasswordHeightConst,val: 0)
            self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
            viewBackEmailID.viewTextFieldErrorBorder()
            lbEmailError.text = "Field cannot be empty."
            return
          //  self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 15)
            
           // let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
           // toast.show()
            
        }
        if txtYourEmailID.text!.isValidEmail == false
        {
            self.validatiohHeight(txtField: lbEmailHeightConstant, val: 15)
            self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbPasswordHeightConst, val: 0)
            self.validatiohHeight(txtField: lbConfirmPassHeightConst, val: 0)
            viewBackEmailID.viewTextFieldErrorBorder()
            lbEmailError.text = "Enter valid email id."
            return
        }
        if  strNewPass.isEmpty
        {
            self.validatiohHeight(txtField: lbEmailHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbPasswordHeightConst, val: 15)
            self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
            viewBackYourPassword.viewTextFieldErrorBorder()
            lbPasswordError.text = "Field cannot be empty."
            return
           // let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
           // toast.show()
            
        }
        if  strConfirmPass.isEmpty
        {
            self.validatiohHeight(txtField: lbEmailHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
            self.validatiohHeight(txtField: lbPasswordHeightConst, val: 0)
            self.validatiohHeight(txtField: lbConfirmPassHeightConst, val: 15)
            viewBackConfirmPassword.viewTextFieldErrorBorder()
            lbConfirmError.text = "Field cannot be empty."
            return
           // let toast = Toast(text: "Field cannot be empty.", delay: 0.0, duration: Delay.long)
           // toast.show()
            
        }
        if strNewPass != strConfirmPass
        {
            
           // let toast = Toast(text: "Password does not match!", delay: 0.0, duration: Delay.long)
           // toast.show()
             self.validatiohHeight(txtField: lbEmailHeightConstant, val: 0)
             self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
             self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
             self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
             self.validatiohHeight(txtField: lbPasswordHeightConst, val: 0)
             self.validatiohHeight(txtField: lbConfirmPassHeightConst, val: 15)
            viewBackConfirmPassword.viewTextFieldErrorBorder()
            lbConfirmError.text = "Password does not match!"
             return
        }
        if CheckTerm == true
        {
            
             self.validatiohHeight(txtField: lbEmailHeightConstant, val: 0)
             self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
             self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
             self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
             self.validatiohHeight(txtField: lbPasswordHeightConst, val: 0)
             self.validatiohHeight(txtField: lbConfirmPassHeightConst, val: 0)
             self.validatiohHeight(txtField: viewTermConditionHeightConst, val: 15)
             return
        //    viewBackConfirmPassword.viewTextFieldErrorBorder()
             
            //let toast = Toast(text: "Please accept the T&C", delay: 0.0, duration: Delay.long)
           // toast.show()
        }
        if CommonClass.isConnectedToNetwork() == true
        {
            self.registerUserAPICall()
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
       // else {
            
         /*   if txtYourEmailID.text!.isValidEmail
            {
                if CommonClass.isConnectedToNetwork() == true
                {
                    self.registerUserAPICall()
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
                self.validatiohHeight(txtField: lbEmailHeightConstant, val: 15)
                self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
                self.validatiohHeight(txtField: lbFirstnameHeightConstant,val: 0)
                self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
                self.validatiohHeight(txtField: lbPasswordHeightConst, val: 0)
                self.validatiohHeight(txtField: lbConfirmPassHeightConst, val: 0)
                viewBackEmailID.viewTextFieldErrorBorder()
                lbEmailError.text = "Enter valid email id."
                return
               // let toast = Toast(text: "Enter valid email id.", delay: 0.0, duration: Delay.long)
               // toast.show()
            }*/
            
       // }
        
    }
    func validatiohHeight(txtField : NSLayoutConstraint,val : Int)
    {
        txtField.constant = CGFloat(val)
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension SetupProfileVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnProceed.layer.cornerRadius = 10.0
        viewBackFirstName.viewBorderWithCornerRadius()
        viewBackLastName.viewBorderWithCornerRadius()
        viewBackEmailID.viewBorderWithCornerRadius()
        viewBackMobileNumber.viewBorderWithCornerRadius()
        viewBackYourPassword.viewBorderWithCornerRadius()
        viewBackConfirmPassword.viewBorderWithCornerRadius()
        
        btnTermAccept.backgroundColor = .clear
        btnTermAccept.layer.cornerRadius = 3
        btnTermAccept.layer.borderWidth = 2
        btnTermAccept.layer.borderColor = UIColor(named: "Color_Primary")?.cgColor
        self.txtMobileNumber.text = self.strFullMobileNumber
    }
    
}

// MARK:- UITextField Delegate Methods
extension SetupProfileVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtFirstName {
            
            self.viewBackFirstName.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 0)
        }
        else if textField == txtLastName {
            
            self.viewBackLastName.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbLastnameHeightConstant, val: 0)
        }
        else if textField == txtYourEmailID {
            
            self.viewBackEmailID.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbEmailHeightConstant, val: 0)
        }
        else if textField == txtMobileNumber {
            
            self.viewBackMobileNumber.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbMobileNumberHeightConstant, val: 0)
        }
        else if textField == txtYourPassword {
            
            self.viewBackYourPassword.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbPasswordHeightConst, val: 0)
        }
        else if textField == txtConfirmPassword {
            
            self.viewBackConfirmPassword.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbConfirmPassHeightConst, val: 0)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtFirstName {
            
            if textField.text?.count == 0 {
                
                self.viewBackFirstName.viewTextFieldWarningBorder()
               
               
            }
            else {
                self.viewBackFirstName.viewBorderWithCornerRadius()
             //   self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 0)
              
            }
        }
        else if textField == txtLastName {
            
            if textField.text?.count == 0 {
                
                self.viewBackLastName.viewTextFieldWarningBorder()
            }
            else {
                self.viewBackLastName.viewBorderWithCornerRadius()
            }
        }
        else if textField == txtYourEmailID {
            
            if textField.text!.isValidEmail {
                
                self.viewBackEmailID.viewBorderWithCornerRadius()
            }
            else if textField.text?.count == 0 {
                
                self.viewBackEmailID.viewTextFieldWarningBorder()
            }
            else {
                self.viewBackEmailID.viewTextFieldErrorBorder()
            }
        }
        else if textField == txtMobileNumber {
            
            if textField.text?.count == 0 {
                
                self.viewBackMobileNumber.viewTextFieldWarningBorder()
            }
            else {
                self.viewBackMobileNumber.viewBorderWithCornerRadius()
            }
        }
        else if textField == txtYourPassword {
            
            if textField.text?.count == 0 {
                
                self.viewBackYourPassword.viewTextFieldWarningBorder()
            }
            else {
                self.viewBackYourPassword.viewBorderWithCornerRadius()
            }
        }
        else if textField == txtConfirmPassword {
            
            if textField.text?.count == 0 {
                
                self.viewBackConfirmPassword.viewTextFieldWarningBorder()
            }
            else {
                self.viewBackConfirmPassword.viewBorderWithCornerRadius()
            }
        }
        
    }
    
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension SetupProfileVC {
    
    func registerUserAPICall() {
        
       
        self.checkLocationAuthorizationStatus()
        
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            
            var currentLocation = CLLocation()
            currentLocation = locManager.location!
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            CommonClass.loadProgressHudCycling(viewController: self)
            APIService.sharedInstance.registerUserAPICall(dictionary: ["contactNumber": strFullMobileNumber, "firstName": "\(txtFirstName.text!)", "lastName": "\(txtLastName.text!)", "email":"\(txtYourEmailID.text!)", "password":"\(txtYourPassword.text!)", "confirmpassword":"\(txtConfirmPassword.text!)", "token":"\(UserDefaults.standard.value(forKey: "deviceToken")!)", "userlat":"\(currentLocation.coordinate.latitude)", "userlong":"\(currentLocation.coordinate.longitude)", "termsandcondition":"1"]) { [self] response in
                CommonClass.removeProgressHudCycling(viewController: self)
                
                print(response)
                
                if response["is_error"] as! String == "false" {
                    
                    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
                    
                    let dicRegData = response["data"] as! [String: Any]
                    let authKey = dicRegData["authkey"] as! String
                    
                    UserDefaults.standard.setValue(authKey, forKey: "authkey")
                    UserDefaults.standard.synchronize()
                    
                    let referral = self.storyboard?.instantiateViewController(withIdentifier: "EnterReferralCodeVC") as! EnterReferralCodeVC
                    referral.strUserID = String(format: "%d", dicRegData["idUser"] as! Int)
                    self.navigationController?.pushViewController(referral, animated: true)
                }
                else {
                    
                    if response["error_code"] as! String == "401"
                    {
                        self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 15)
                        self.validatiohHeight(txtField: lbLastnameHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbEmailHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbPasswordHeightConst,val: 0)
                        self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
                        self.validatiohHeight(txtField: viewTermConditionHeightConst, val: 0)
                     //   viewBackFirstName.viewTextFieldErrorBorder()
                        lbFirstnameError.text = "\(response["message"] as! String)"
                        return
                    }
                    else if response["error_code"] as! String == "403"
                    {
                        self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 0)
                        self.validatiohHeight(txtField: lbLastnameHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbEmailHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbPasswordHeightConst,val: 15)
                        self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
                        self.validatiohHeight(txtField: viewTermConditionHeightConst, val: 0)
                     //   viewBackFirstName.viewTextFieldErrorBorder()
                        lbPasswordError.text = "\(response["message"] as! String)"
                        return
                    }
                    else if response["error_code"] as! String == "400"
                    {
                        self.validatiohHeight(txtField: lbFirstnameHeightConstant, val: 0)
                        self.validatiohHeight(txtField: lbLastnameHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbEmailHeightConstant,val: 15)
                        self.validatiohHeight(txtField: lbMobileNumberHeightConstant,val: 0)
                        self.validatiohHeight(txtField: lbPasswordHeightConst,val: 0)
                        self.validatiohHeight(txtField: lbConfirmPassHeightConst,val: 0)
                        self.validatiohHeight(txtField: viewTermConditionHeightConst, val: 0)
                     //   viewBackFirstName.viewTextFieldErrorBorder()
                        lbEmailError.text = "\(response["message"] as! String)"
                        return
                    }
                    else
                    {
                         let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                         toast.show()
                    }
                    
                }
                
            } blockError: { error in
                CommonClass.removeProgressHudCycling(viewController: self)
                
            }
            
        }
        
    }
    func showLocationAccessAlert() {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
        self.present(alertController, animated: true)
         //   let appdelegate = UIApplication.shared.delegate as? AppDelegate
           // appdelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    func checkLocationAuthorizationStatus()
    {
        let status = CLLocationManager.authorizationStatus()
        print(status.rawValue)
        
        if status == CLAuthorizationStatus.notDetermined
        {
            print("NotDetermined")
            locManager.requestWhenInUseAuthorization()
            CLLocationManager.locationServicesEnabled()
            locManager.requestLocation()
            
        }
        else if status == CLAuthorizationStatus.authorizedAlways
        {
            print("Problem with authorizedAlways")
        }
        else if status == CLAuthorizationStatus.authorizedWhenInUse
        {
            print("Problem with authorizedWhenInUse")
        }
        else if status == CLAuthorizationStatus.denied
        {
            print("Problem with denied")
            showLocationAccessAlert()
        }
        else if status == CLAuthorizationStatus.restricted
        {
            print("Problem with restricted")
        }
        else {
            
            if CLLocationManager.locationServicesEnabled()
            {
                locManager.requestLocation()
            }
            else{
                locManager.requestWhenInUseAuthorization()
                locManager.startUpdatingLocation()
                //   setUIOnScreen()
            }
            print("Problem with authorization")
            
        }

    }
    
    
}



