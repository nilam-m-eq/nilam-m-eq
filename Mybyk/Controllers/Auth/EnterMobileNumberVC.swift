//
//  EnterMobileNumberVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 22/06/21.
//

import UIKit
import DropDown
import Toaster
import SDWebImage
import SwiftyGif
import Foundation



class EnterMobileNumberVC: CommonViewController
{
    // ***** Enter Mobile Number Outlet ***** //
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackMobileNumberText: UIView!
    @IBOutlet weak var viewBackSliderImage: UIView!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnTermAccept: UIButton!
    @IBOutlet var lblCountryCode: UILabel!
    @IBOutlet var btnSelectCountryCode: UIButton!
    @IBOutlet var btnLoginUsingPassword: UIButton!
    @IBOutlet weak var btnGetOTP: UIButton!
    @IBOutlet var lblMobileNumberError: UILabel!
    @IBOutlet var imgViewMobileNumberError: UIImageView!
    @IBOutlet weak var lblTermAndCondition: UILabel!
    @IBOutlet var constMobileNumberErrorH: NSLayoutConstraint!
    //  @IBOutlet var imgBanner: UIImageView!
    
    @IBOutlet var btnInternetConnectionOkay: UIButton!
    @IBOutlet var imgInternetWarning: UIImageView!
    @IBOutlet var viewInternetWarningRound: UIView!
    @IBOutlet var viewInnerInternetError: UIView!
    @IBOutlet var viewMainInternerError: UIView!
    @IBOutlet var CollBannerImg: UICollectionView!
    let dropDown = DropDown()
    var bannerImageList = [BannerlistModel]()
    
    var otpVerif = OTPVerificationVC()
    
  //  var banner = [String : Any]()
     var bannerImageListData = NSArray()
    
    var bannner = [[String : AnyObject]]()
    
    var begin = false
    
    @IBOutlet var bannerPageControl: UIPageControl!
    var tmpCountOfBanner = 0
    var tmpCountOfBannerVal = 0
    var strTermCondition : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        CollBannerImg.delegate = self
        CollBannerImg.dataSource = self
        
        self.getCountryCodeAPICall()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    
        self.setUIOnScreen()
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        otpVerif.willMove(toParent: nil)
        otpVerif.view.removeFromSuperview()
        otpVerif.removeFromParent()
    }
    
  
    // ********** All Button Actions ********** //
    
    @IBAction func btnInternetConnectionOkClicked(_ sender: Any)
    {
        self.viewMainInternerError.removeFromSuperview()
    }
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionSelectCountryCode(_ sender: Any) {
        
        if dropDown.dataSource.count == 1 {
        }
        else {
            dropDown.show()
        }
    }
    
    @IBAction func ActionTermsCondition(_ sender: UIButton) {
        
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TearmsConditionVc") as! TearmsConditionVc
        tabVC.strConditionURL = strTermCondition
        self.navigationController?.pushViewController(tabVC, animated: true)
       /* if let url = URL(string: urlTermsAndCondition) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }*/
    }
    
    @IBAction func ActionTermAccept(_ sender: UIButton) {
        
        if btnTermAccept.isSelected == true {
            
            btnTermAccept.isSelected = false
        }
        else {
            btnTermAccept.isSelected = true
        }
    }
    
    @IBAction func ActionLoginUsingPassword(_ sender: UIButton)
    {
        if CommonClass.isConnectedToNetwork() == true
        {
            print("Connected to the internet")
            if isValidationCheck() == true
            {
                //            self.addLoginWithPasswordView()
                self.view.endEditing(true)
                self.isUserExistAPICall(strFrom: "true")
            }
            //  Do something
        } else
        {
         
            viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
            
            viewInternetConnection.instance.ActionOkay =
            {
                OngoingRideCancelRequestAlert.instance.HidePopup()
            }
            
            //  Do something
        }
    }
    
    @IBAction func ActionGetOTP(_ sender: UIButton)
    {
        
        if CommonClass.isConnectedToNetwork() == true
        {
            print("Connected to the internet")
            
            if isValidationCheck() == true {
                //            self.addOTPVerificationView()
                self.view.endEditing(true)
                self.isUserExistAPICall(strFrom: "false")
            }
            //  Do something
        } else
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
extension EnterMobileNumberVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        bannerPageControl.numberOfPages = bannerImageList.count
        return bannerImageList.count
       // return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollSelectBannerImageCollectionViewCell", for: indexPath) as! CollSelectBannerImageCollectionViewCell
        
        let imageType = self.bannerImageList[indexPath.row].bannerMediaType
        let imageGet = self.bannerImageList[indexPath.row].bannerImage
        
//          let dic = self.bannerImageListData[0] as! [String : Any]
//          let imageType = dic["bannerMediaType"] as! String
//          let imageGet = dic["bannerImage"] as! String
        
//bannerImageListData
        
        if imageType == "IMAGE"
        {
            DispatchQueue.main.async {
                cell.imgBanner.sd_setImage(with: URL(string: imageGet! ), placeholderImage: UIImage(named: ""))
            }
        }
        else
        {
            do
            {
                let gif = try UIImage(gifName: imageGet!)
                cell.imgBanner.setGifImage(gif)
            }
            catch
            {
                print("EROR",error)
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: CollBannerImg.frame.size.width, height: CollBannerImg.frame.size.height)
    }
    
    func startTimer()
    {
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector : #selector(EnterMobileNumberVC.scrollToNextCell), userInfo: nil, repeats: true)
    }
    @objc func scrollToNextCell()
    {
        let cellSize = CGSize(width: CollBannerImg.frame.size.width , height: CollBannerImg.frame.size.height)
        let contentOffset = CollBannerImg.contentOffset
        
        //scroll to next cell
        if begin == true
        {
            bannerPageControl.currentPage = 0
            CollBannerImg.scrollRectToVisible(CGRect.zero, animated: true)
            begin = false
        }
        else
        {
            
            if tmpCountOfBannerVal == bannerImageList.count - 1
             {
                  CollBannerImg.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
                  tmpCountOfBannerVal = 0
             }
             else if tmpCountOfBannerVal == 0
             {
                 print(contentOffset.x)
                 print(cellSize.width)
                 CollBannerImg.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
                // CollBannerImg.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
                 
                 tmpCountOfBannerVal = tmpCountOfBannerVal + 1
             }
            else
            {
                print(contentOffset.x)
                print(cellSize.width)
                
                CollBannerImg.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
               // CollBannerImg.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
                
                tmpCountOfBannerVal = tmpCountOfBannerVal + 1
            }
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        // If the scroll animation ended, update the page control to reflect the current page we are on
        
        bannerPageControl.currentPage = Int((CollBannerImg.contentOffset.x / CollBannerImg.contentSize.width) * CGFloat(bannerImageList.count))
        
        //        print("COL WIDTH",CollBannerImg.contentSize.width)
        //        print("COLL OFFSET X",CollBannerImg.contentOffset.x)
        //        print("VIEW FRAM",self.view.frame.width)
        
        if CollBannerImg.contentSize.width == CollBannerImg.contentOffset.x + self.view.frame.width
        {
            begin = true
            
        }
        else
        {
            
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        // Called when manually setting contentOffset
        scrollViewDidEndDecelerating(scrollView)
        
    }
    
}
// ************************************ //
// MARK:- UITextField Delegate Methods
// ************************************ //
extension EnterMobileNumberVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var specifiedChar = true
        let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
        specifiedChar = replacementStringIsLegal
        
        var charLimit = true
        let maxLength = 10
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        charLimit = newString.length <= maxLength
        
        if newString.length >= maxLength
        {
            btnGetOTP.backgroundColor = UIColor(named: Color_Primary)
            constMobileNumberErrorH.constant = 0
            viewBackMobileNumberText.viewBorderWithCornerRadius()
        }
        else
        {
            btnGetOTP.backgroundColor = UIColor(named: Color_N_Dark200)
            if newString.length == 0
            {
                constMobileNumberErrorH.constant = 16
                lblMobileNumberError.text = "Field cannot be empty."
                lblMobileNumberError.textColor = UIColor(named: Color_Error)
                imgViewMobileNumberError.image = UIImage(named: "IC_Error")
                viewBackMobileNumberText.viewTextFieldErrorBorder()
            }
            else
            {
               // constMobileNumberErrorH.constant = 0
                
                //  viewBackMobileNumberText.viewBorderWithCornerRadius()
                
                
            }
        }
        
        if specifiedChar == true && charLimit == true {
            
            return true
        }
        else {
            return false
        }
        
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EnterMobileNumberVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackMobileNumberText.viewBorderWithCornerRadius()
        viewBackSliderImage.layer.cornerRadius = 5.0
        self.btnGetOTP.layer.cornerRadius = 10.0
       // self.btnLoginUsingPassword.layer.cornerRadius = 10.0
      //  self.btnLoginUsingPassword.shadowSecondaryBtn(frame: self.btnLoginUsingPassword.frame)
        
        //By continuing you agree to our Terms of use
        
        let strTermAndCondition = self.lblTermAndCondition.text
        //By continuing you are agree to our Terms of use
        
        let textRange = NSRange(location: 31, length: strTermAndCondition!.count - 31)
        let attributedText = NSMutableAttributedString(string: strTermAndCondition!)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedText.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), range: textRange)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), range: textRange)
        self.lblTermAndCondition.attributedText = attributedText
        
        
        dropDown.anchorView = btnSelectCountryCode
        dropDown.selectionAction = { (index: Int, item: String) in
            
            print("Selected item: \(item) at index: \(index)")
            self.lblCountryCode.text = item
        }
        self.getBannerImagesAPICall()
    }
    
    func addLoginWithPasswordView(strFullNumber: String, strIsRegister: String) {
        
        let loginWithPass = self.storyboard?.instantiateViewController(withIdentifier: "LoginWithPasswordVC") as! LoginWithPasswordVC
        loginWithPass.strCountryCode = lblCountryCode.text!
        loginWithPass.strContactNumber = txtMobileNumber.text!
        loginWithPass.strFullMobileNumber = strFullNumber
        loginWithPass.strIsRegister = strIsRegister
        self.addChild(loginWithPass)
        self.view.addSubview(loginWithPass.view)
        loginWithPass.didMove(toParent: self)
        
        let height = view.frame.height
        let width = view.frame.width
        loginWithPass.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    func addOTPVerificationView(strFullNumber: String, strIsRegister: String) {
        
         otpVerif = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
        otpVerif.strCountryCode = lblCountryCode.text!
        otpVerif.strContactNumber = txtMobileNumber.text!
        otpVerif.strFullMobileNumber = strFullNumber
        otpVerif.strIsRegister = strIsRegister
        self.addChild(otpVerif)
        self.view.addSubview(otpVerif.view)
        otpVerif.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        otpVerif.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    func isValidationCheck() -> Bool {
        
        if txtMobileNumber.text?.count == 0 {
            
            constMobileNumberErrorH.constant = 16
            lblMobileNumberError.text = "Field cannot be empty."
            lblMobileNumberError.textColor = UIColor(named: Color_Error)
            imgViewMobileNumberError.image = UIImage(named: "IC_Error")
            viewBackMobileNumberText.viewTextFieldErrorBorder()
            return false
        }
        else if txtMobileNumber.text!.count < 10 {
            
            constMobileNumberErrorH.constant = 16
            lblMobileNumberError.text = "Enter valid mobile number."
            lblMobileNumberError.textColor = UIColor(named: Color_Warning)
            imgViewMobileNumberError.image = UIImage(named: "IC_Warning")
            viewBackMobileNumberText.viewTextFieldWarningBorder()
            return false
        }
        else {
            return true
        }
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension EnterMobileNumberVC {
    
    func getCountryCodeAPICall()
    {
        
        //WsMobileBannerImage
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getCountryCodeAPICall(dictionary: ["getcountrycode": "1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: [])
                let jsonData = try JSONDecoder().decode(CountryCode.self, from: data)
                
                print(jsonData.data.countrycodelist)
                dropDown.dataSource = (jsonData.data.countrycodelist)
                
            } catch {
                print("error")
            }
            
        } blockError: { error in
            
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
        
    }
    func getBannerImagesAPICall()
    {
        //action : LOGIN
        //WsMobileBannerImage
        //DataBannerImageModel
        // CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getBannerImageMobileOTP(dicBannerBodyParama: ["action": "LOGIN"]) { result in
            
            print(result)
            let dicData = result["data"] as! [String : Any]
            //do {
            if result["error_code"] as! String == "403"
            {
                AlertView.instance.showAlert(message: "\(result["message"] as! String)", image: "IC_ErrorIcon", alertType: .success)
            }
            else
            {
                do{
                  
                    let data = try JSONSerialization.data(withJSONObject: result, options: [])
                    let jsonData = try JSONDecoder().decode(BannnerImageBaseModel.self, from: data)
                    
                    self.strTermCondition = dicData["termsandconditionURL"] as? String
                    self.bannerImageList = (jsonData.dataDisp?.banner_list)!
                    
                  //  self.bannerImageList = self.bannerImageList[0]
                    self.bannerPageControl.numberOfPages = self.bannerImageList.count
                    self.tmpCountOfBanner = self.bannerImageList.count
                    self.tmpCountOfBannerVal = 0
                    
                   // print(dicData["banner_list"] as! NSArray)
                   // self.bannerImageListData = dicData["banner_list"] as! NSArray
                    self.CollBannerImg.reloadData()
                    self.startTimer()
                }
                catch
                {
                    print("error")
                }
                
            }
            /* let data = try JSONSerialization.data(withJSONObject: result, options: [])
             let jsonData = try JSONDecoder().decode(BannnerImageBaseModel.self, from: data)
             
             //  print(jsonData.dataDisp?.banner_list)
             
             if jsonData.error_code == "403"
             {
             //  AlertView.instance.showAlert(message: "Please Enter Valid OTP", image: "IC_ErrorIcon", alertType: .success)
             }
             else
             {
             self.bannerImageList = (jsonData.dataDisp?.banner_list)!
             self.bannerPageControl.numberOfPages = self.bannerImageList.count
             self.tmpCountOfBanner = self.bannerImageList.count
             self.tmpCountOfBannerVal = 0
             self.CollBannerImg.reloadData()
             self.startTimer()
             }*/
            
            
            // } catch
            // {
            //     print("error")
            // }
        } blockerror: { error in
            // print(error)
            //   CommonClass.removeProgressHudCycling(viewController: self)
        }
    }
    func isUserExistAPICall(strFrom: String) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.checkIsUserExistAPICall(dictionary: ["countrycode": "\(lblCountryCode.text!)", "contactnumber": "\(txtMobileNumber.text!)", "completecontactnumber": "\(lblCountryCode.text!)\(txtMobileNumber.text!)", "loginwithpassword": strFrom]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: response, options: [])
                    let jsonData = try JSONDecoder().decode(UserExist.self, from: data)
                    print(jsonData)
                    
                    
                    if jsonData.isError == "false"
                    {
                        
                        if strFrom == "true"
                        {
                            
                            // This is for login with password
                            if jsonData.data.isregistered == "true"
                            {
                                self.addLoginWithPasswordView(strFullNumber: "\(lblCountryCode.text!)\(txtMobileNumber.text!)", strIsRegister: jsonData.data.isregistered)
                            }
                            else
                            {
                                self.addOTPVerificationView(strFullNumber: "\(lblCountryCode.text!)\(txtMobileNumber.text!)", strIsRegister: jsonData.data.isregistered)
                            }
                        }
                        else
                        {
                            
                            // This is for Login with OTP
                            self.addOTPVerificationView(strFullNumber: "\(lblCountryCode.text!)\(txtMobileNumber.text!)", strIsRegister: jsonData.data.isregistered)
                        }
                    }
                    
                } catch {
                    print("error")
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




