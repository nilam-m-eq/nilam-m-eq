//
//  MyProfileEditVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit
import Toaster

class MyProfileEditVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var imgViewProPic: UIImageView!
    @IBOutlet weak var viewBackName: UIView!
    @IBOutlet weak var viewBackEmail: UIView!
    @IBOutlet weak var viewBackContactNumber: UIView!
    @IBOutlet weak var viewBackEmergencyContact: UIView!
    @IBOutlet weak var viewBackBloodGroup: UIView!
    @IBOutlet weak var viewBackCurrentPassword: UIView!
    @IBOutlet weak var viewBackNewPassword: UIView!
    @IBOutlet var lbNewpasswordError: UILabel!
    @IBOutlet var imgConfirmError: UIImageView!
    @IBOutlet var lbConfirmPasswordError: UILabel!
    
    @IBOutlet var imgEmailErroe: UIImageView!
    @IBOutlet var lbEmailInvalidError: UILabel!
    @IBOutlet var imgNewpasswordError: UIImageView!
    @IBOutlet var viewConfirmPassword: UIView!
    @IBOutlet var viewLastName: UIView!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtCurrentPassword: UITextField!
    @IBOutlet var txtBloodGroup: UITextField!
    @IBOutlet var txtContact: UITextField!
    @IBOutlet var txtContactNotEdit: UITextField!
    @IBOutlet var viewFirstNameErrorHeightConst: NSLayoutConstraint!
    @IBOutlet var viewLastNameErrorHeightConst: NSLayoutConstraint!
    @IBOutlet var viewEmailErrorHeightConst: NSLayoutConstraint!
    @IBOutlet var viewContactErrorHeightConst: NSLayoutConstraint!
    
    @IBOutlet var viewConfirmPassErrorHeightConst: NSLayoutConstraint!
    
    @IBOutlet var viewNewPaswordHeightConst: NSLayoutConstraint!
    @IBOutlet var viewCurrentPasswordHeightConst: NSLayoutConstraint!
    @IBOutlet var viewBloodErrorHeightConst: NSLayoutConstraint!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    
    var imagePicker: ImagePicker!
    var dicGetData = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
        self.viewBackName.viewBorderWithCornerRadius()
        self.viewBackEmail.viewBorderWithCornerRadius()
        self.viewBackContactNumber.viewBorderWithCornerRadius()
        self.viewBackEmergencyContact.viewBorderWithCornerRadius()
        self.viewBackBloodGroup.viewBorderWithCornerRadius()
        self.viewBackCurrentPassword.viewBorderWithCornerRadius()
        self.viewBackNewPassword.viewBorderWithCornerRadius()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionEditProfilePhoto(_ sender: UIButton)
    {
        self.imagePicker.present(from: sender)
    }
    @IBAction func btnSubmitClicked(_ sender: Any)
    {
      /*  if  txtFirstName.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackName.viewTextFieldErrorBorder()
            return
        }
        if  txtLastName.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 015)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewLastName.viewTextFieldErrorBorder()
            return
        }
        if  txtEmail.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackEmail.viewTextFieldErrorBorder()
            return
        }
        if txtEmail.text!.isValidEmail == false
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackEmail.viewTextFieldErrorBorder()
            lbEmailInvalidError.text = "Enter valid email id."
            return
        }
        if  txtContact.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackEmergencyContact.viewTextFieldErrorBorder()
            return
        }
        if  txtBloodGroup.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackBloodGroup.viewTextFieldErrorBorder()
            return
        }
        if  txtCurrentPassword.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackCurrentPassword.viewTextFieldErrorBorder()
            return
        }
        if  txtNewPassword.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackNewPassword.viewTextFieldErrorBorder()
            return
        }
        if  txtConfirmPassword.text == ""
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 15)
            viewConfirmPassword.viewTextFieldErrorBorder()
            return
        }*/
        if txtEmail.text!.isValidEmail == false
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
            viewBackEmail.viewTextFieldErrorBorder()
            lbEmailInvalidError.text = "Enter valid email id."
            return
        }
        if txtNewPassword.text != txtConfirmPassword.text
        {
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 15)
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 15)
            lbConfirmPasswordError.text = "Password does not match!"
            viewConfirmPassword.viewTextFieldErrorBorder()
            return
        }
       
        if imgViewProPic.image?.pngData() == nil
        {
              let toast = Toast(text: "Please select image", delay: 0.0, duration: Delay.long)
               toast.show()
              return
        }
        
        let dataImage = imgViewProPic.image?.compress(to: 300)
        //tempImage.compress(to: 200)
        
        self.EditProfile(data:  dataImage, strCheckForm: "FromAllField")
        
      //  self.EditProfile(data:  imgViewProPic.image?.pngData(), strCheckForm: "FromAllField")
        
    }
    func viewHeightHighlight(heightConst : NSLayoutConstraint,val : Int) -> Void
    {
        heightConst.constant = CGFloat(val)
    }
    func EditProfile(data : Data?,strCheckForm : String?)
    {
        
        CommonClass.loadProgressHudCycling(viewController: self)

      //  APIService.sharedInstance.getMyProfileGraph(media : (imgViewProPic.image?.pngData() as? NSData)!,
        
        //self.EditProfile(data: data, strCheckForm: "FromEditPhoto")
        
        //WsEditUserProfile.php?
        //FromAllField
        
        if strCheckForm == "FromAllField"
        {
            //getMyProfileEditData
            APIService.sharedInstance.getMyProfileEditData(dictionary: ["action": "updateDetails", "firstName": "\(txtFirstName.text!)", "lastName": "\(txtLastName.text!)", "email":"\(txtEmail.text!)", "alternateContactNumber":"\(txtContact.text!)", "bloodGroup":"\(txtBloodGroup.text!)", "currentPassword":"\(txtCurrentPassword.text!)", "newPassword":"\(txtNewPassword.text!)", "confirmNewPassword":"\(txtConfirmPassword.text!)"]) { [self] response in
                CommonClass.removeProgressHudCycling(viewController: self)
                
                print(response)
                
                /*
                 self.EditProfile(data: data, strCheckForm: "FromEditPhoto")
                 //FromAllField
                 */
                if response["is_error"] as! String == "false"
                {
                  /*  let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                     toast.show()*/
                    if strCheckForm == "FromAllField"
                    {
                        viewInternetConnection.instance.showMsg(strmsg: "\(response["message"] as! String)")
                        
                        viewInternetConnection.instance.ActionOkay =
                        {
                            OngoingRideCancelRequestAlert.instance.HidePopup()
                            self.getMenuListAPICallEditProfilePic(strCheckForm: strCheckForm!)
                        }
                    }
                    else
                    {
                        self.getMenuListAPICallEditProfilePic(strCheckForm: strCheckForm!)
                    }
                   
                   
                }
                else {
                    
                      let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                       toast.show()
                    
                }
                
            } blockError: { error in
                CommonClass.removeProgressHudCycling(viewController: self)
                
            }
        }
        else
        {
            
        APIService.sharedInstance.getMyProfileGraph(media : (data! as NSData),dictionary: ["action": "updateDetails", "firstName": "\(txtFirstName.text!)", "lastName": "\(txtLastName.text!)", "email":"\(txtEmail.text!)", "alternateContactNumber":"\(txtContact.text!)", "bloodGroup":"\(txtBloodGroup.text!)", "currentPassword":"\(txtCurrentPassword.text!)", "newPassword":"\(txtNewPassword.text!)", "confirmNewPassword":"\(txtConfirmPassword.text!)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            /*
             self.EditProfile(data: data, strCheckForm: "FromEditPhoto")
             //FromAllField
             */
            if response["is_error"] as! String == "false"
            {
              /*  let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                 toast.show()*/
                if strCheckForm == "FromAllField"
                {
                    viewInternetConnection.instance.showMsg(strmsg: "Your request has been submitted successfully.You will be notified once your request will be processed.")
                    
                    viewInternetConnection.instance.ActionOkay =
                    {
                        OngoingRideCancelRequestAlert.instance.HidePopup()
                        self.getMenuListAPICallEditProfilePic(strCheckForm: strCheckForm!)
                    }
                }
                else
                {
                    self.getMenuListAPICallEditProfilePic(strCheckForm: strCheckForm!)
                }
               
               
            }
            else {
                
                  let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                   toast.show()
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        }
    }
    func getMenuListAPICallEditProfilePic(strCheckForm : String) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getMenuListAPICall(dictionary: ["action": "getMenuList"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                
                let dicMenuData = response["data"] as! [String: Any]
                
                
                if let strImg = dicMenuData["profile_image"] as? String {
                    
                    self.imgViewProPic.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: ""))
                }
                else {
                    
                    let lblNameInitialize = UILabel()
                    lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
                    lblNameInitialize.textColor = UIColor.white
                    lblNameInitialize.text = String((dicGetData["first_name"] as! String).first!) + String((dicGetData["last_name"] as! String).first!)
                    lblNameInitialize.textAlignment = NSTextAlignment.center
                    lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
                    lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
                    UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
                    lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
                    self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                }
                
                if strCheckForm == "FromAllField"
                {
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    self.GetProfileData()
                }
               
            //    self.navigationController?.popViewController(animated: true)
                
                //dicStore = dicMenuData
               // self.setMenuData(dicMenu: dicMenuData)
                
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


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension MyProfileEditVC : UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if textField == txtContact
        {
            var specifiedChar = true
            let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
            specifiedChar = replacementStringIsLegal
            
            var charLimit = true
            let maxLength = 10
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            charLimit = newString.length <= maxLength
            
            if specifiedChar == true && charLimit == true {
                
                return true
            }
            else {
                return false
            }
        }
        else
        {
            return true
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == txtFirstName
        {
            self.viewBackName.viewTextFieldPrimaryBorder()
            
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
         
        }
        else if textField == txtLastName
        {
            self.viewLastName.viewTextFieldPrimaryBorder()
            
            self.viewBackName.viewTextFieldActiveBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
        }
        else if textField == txtEmail
        {
            self.viewBackEmail.viewTextFieldPrimaryBorder()
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackName.viewTextFieldActiveBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
        }
        else if textField == txtContact
        {
            self.viewBackEmergencyContact.viewTextFieldPrimaryBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackName.viewTextFieldActiveBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
        }
        else if textField == txtBloodGroup
        {
            self.viewBackBloodGroup.viewTextFieldPrimaryBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackName.viewTextFieldActiveBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
        }
        else if textField == txtCurrentPassword
        {
            self.viewBackCurrentPassword.viewTextFieldPrimaryBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackName.viewTextFieldActiveBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
        }
        else if textField == txtNewPassword
        {
            self.viewBackNewPassword.viewTextFieldPrimaryBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackName.viewTextFieldActiveBorder()
            self.viewConfirmPassword.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
        }
        else if textField == txtConfirmPassword
        {
            self.viewConfirmPassword.viewTextFieldPrimaryBorder()
            self.viewBackNewPassword.viewTextFieldActiveBorder()
            self.viewBackCurrentPassword.viewTextFieldActiveBorder()
            self.viewBackBloodGroup.viewTextFieldActiveBorder()
            self.viewBackEmergencyContact.viewTextFieldActiveBorder()
            self.viewBackEmail.viewTextFieldActiveBorder()
            self.viewLastName.viewTextFieldActiveBorder()
            self.viewBackName.viewTextFieldActiveBorder()
            
            self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
        }
    }
}

extension MyProfileEditVC {
    
    func setUIOnScreen()
    {
        
        print(dicGetData)
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtContact.delegate = self
        txtBloodGroup.delegate = self
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtCurrentPassword.delegate = self
        
      /*  txtFirstName.text = dicGetData["firstName"] as? String
        txtLastName.text = dicGetData["lastName"] as? String
        txtEmail.text = dicGetData["email"] as? String
        txtContactNotEdit.text = dicGetData["contact_no"] as? String
        
        if let strImg = dicGetData["photograph"] as? String {
            
            self.imgViewProPic.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: ""))
        }
        else {
            
            let lblNameInitialize = UILabel()
            lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
            lblNameInitialize.textColor = UIColor.white
            lblNameInitialize.text = String((dicGetData["firstName"] as! String).first!) + String((dicGetData["lastName"] as! String).first!)
            lblNameInitialize.textAlignment = NSTextAlignment.center
            lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
            lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
            UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
            lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
            self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }*/
        
        self.viewHeightHighlight(heightConst: viewFirstNameErrorHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewLastNameErrorHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewEmailErrorHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewContactErrorHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewBloodErrorHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewCurrentPasswordHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewNewPaswordHeightConst, val: 0)
        self.viewHeightHighlight(heightConst: viewConfirmPassErrorHeightConst, val: 0)
       // self.viewHeightHighlight(heightConst: viewconta, val: 0)
        
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
        self.consViewBackDetailWidth.constant = self.view.frame.width
        imgViewProPic.layer.cornerRadius = imgViewProPic.frame.size.width / 2
       // imgViewProPic.layer.borderColor = UIColor.white.cgColor
      //  imgViewProPic.layer.borderWidth = 2.0
        btnSubmit.layer.cornerRadius = 8.0
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        //        self.viewBackName.viewBorderWithCornerRadius()
        //        self.viewBackEmail.viewBorderWithCornerRadius()
        //        self.viewBackContactNumber.viewBorderWithCornerRadius()
        //        self.viewBackEmergencyContact.viewBorderWithCornerRadius()
        //        self.viewBackBloodGroup.viewBorderWithCornerRadius()
        //        self.viewBackCurrentPassword.viewBorderWithCornerRadius()
        //        self.viewBackNewPassword.viewBorderWithCornerRadius()
        self.GetProfileData()
    }
    
    func GetProfileData()
    {
        CommonClass.loadProgressHudCycling(viewController: self)
      
        APIService.sharedInstance.getProfileData(dicBannerBodyParama: ["action": "getDetails"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
            
                
                let dataDisp = response["data"] as! [String : Any]
              //  aryListGraph = dataDisp["allRidesData"] as! [AnyObject]
              //  TotalCount = aryListGraph.count
                
                
             //   tmpAryListGraph = dataDisp["allRidesData"] as! [AnyObject]
              //  tmpAryListGraphStored = dataDisp["allRidesData"] as! [AnyObject]
                let dicProfileData = dataDisp["overview"] as! [String : Any]
                
                print(dicProfileData)
                txtFirstName.text = dicProfileData["firstName"] as? String
                 txtLastName.text = dicProfileData["lastName"] as? String
                 txtEmail.text = dicProfileData["email"] as? String
                 txtContactNotEdit.text = dicProfileData["contact_no"] as? String
                 
                 if let strImg = dicProfileData["photograph"] as? String {
                     
                     self.imgViewProPic.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: ""))
                 }
                 else {
                     
                     let lblNameInitialize = UILabel()
                     lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
                     lblNameInitialize.textColor = UIColor.white
                     lblNameInitialize.text = String((dicGetData["firstName"] as! String).first!) + String((dicGetData["lastName"] as! String).first!)
                     lblNameInitialize.textAlignment = NSTextAlignment.center
                     lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
                     lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
                     UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
                     lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
                     self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
                     UIGraphicsEndImageContext()
                 }
               // lbDistance.text =  dataDisp["total_ride_distance"] as? String
                
               // print(dataDisp["totalRides"]!)
               // print(dataDisp["total_ride_duration"]!)
                
               // lbRide.text = "\(dataDisp["totalRides"]!)"
               // lbMyBest.text = "\(dataDisp["total_ride_duration"]!)"
                
              //  lbName.text = dicProfileData["name"] as? String
                
               /*   if let strImg = dicProfileData["photograph"] as? String {
                      
                      self.imgViewProPic.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: ""))
                  }
                  else {
                      
                      let lblNameInitialize = UILabel()
                      lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
                      lblNameInitialize.textColor = UIColor.white
                      lblNameInitialize.text = String((dicProfileData["firstName"] as! String).first!) + String((dicProfileData["lastName"] as! String).first!)
                      lblNameInitialize.textAlignment = NSTextAlignment.center
                      lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
                      lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
                      UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
                      lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
                      self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
                      UIGraphicsEndImageContext()
                  }*/
                
              /*  let datDicWeekWise = tmpAryListGraph[0] as! [String : Any]
                let Graphdata = datDicWeekWise["allDaysDistanceData"] as! Array<AnyObject>
                
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = collGraphData.dequeueReusableCell(withReuseIdentifier: "cellGraphData", for: indexPath) as! cellGraphData
                
                if Graphdata.count == 0
                {
                    cell.lbNoDataFound.isHidden = false
                    cell.viewChart.isHidden = true
                   
                }
                else
                {
                    var GraphValue = [CGFloat]()
                    
                    Graphdata.forEach { value in
                        print(value)
                        let dat = value as! [String : Any]
                        
                        let fl: CGFloat = CGFloat((dat["totalRideDistance"] as! NSString).doubleValue)
                        
                      //  let ConvertFloat = CGFloat(String(format: "%.4f",dat["totalRideDistance"] as! CVarArg))
                        //(dat["totalRideDistance"]).floatValue
                        //(dat["totalRideDistance"] as! String)
                        //"\(dat["totalRideDistance"])" as! CGFloat
                        GraphValue.append(fl)
                       
                    }
                    
                  //  cell.viewChart.reloadInputViews()
                    print(GraphValue)
                 //   let data: [CGFloat] = [0, 0, 2, 0, 10, 0, 5]
                    let data = GraphValue
                    let xLabels: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    
                    
                    cell.lbNoDataFound.isHidden = true
                    cell.viewChart.isHidden = false
                    
                    cell.viewChart.animation.enabled = true
                    cell.viewChart.area = false
                    cell.viewChart.x.labels.visible = true
                    cell.viewChart.x.grid.count = 5
                    cell.viewChart.y.grid.count = 5
                    cell.viewChart.x.labels.values = xLabels
                    cell.viewChart.y.labels.visible = true
                    cell.viewChart.addLine(data)
                
                
                }
               */
                //allDaysDistanceData
               // collGraphData.reloadData()
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
            
        } blockerror: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
}

// ************************************ //
// MARK:- UIImagePicker Delegate
// ************************************ //
extension MyProfileEditVC: ImagePickerDelegate
{
   func didSelect(image: UIImage?,data: Data?)
    {
        //CALL API
        print("API")
        self.imgViewProPic.image = image
        print(data?.count ?? 0)
        //print(image?.imageData?.count as! Int)
        self.EditProfile(data: data, strCheckForm: "FromEditPhoto")
        //FromAllField
        /*
         updateDetails
         photograph

         */
    }
    func ShowAlert(alert: UIAlertController)
    {
        self.present(alert, animated: true) {
            
        }
        //self.imgViewProPic.image = image
    }
}



