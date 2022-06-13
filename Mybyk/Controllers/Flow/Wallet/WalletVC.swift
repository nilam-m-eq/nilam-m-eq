//
//  WalletVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 28/06/21.
//

import UIKit
import Toaster


class WalletVC: CommonViewController , UITextFieldDelegate
{
    @IBOutlet var viewWallet: UIView!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnWithdrawCancelRequest: UIButton!
    @IBOutlet weak var lbWithdrawConfirmationVal: UILabel!
    @IBOutlet weak var viewWithdrawConfirmation: UIView!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var viewBackWalletBal: UIView!
    @IBOutlet weak var btnAddMoney: UIButton!
    @IBOutlet var lblBalance: UILabel!
    @IBOutlet var lblTermsCondition: UILabel!
    @IBOutlet var lblTransaction: UILabel!
    @IBOutlet var lblTransMessage: UILabel!
    @IBOutlet var lblRefer: UILabel!
    @IBOutlet var lblReferMessage: UILabel!
    @IBOutlet var lblCredit: UILabel!
    @IBOutlet weak var viewBackTransactions: UIView!
    @IBOutlet weak var viewBackRefer: UIView!
    
   
    @IBOutlet var lbAvailableCredit: UILabel!
    @IBOutlet var viewAvailableCredit: UIView!
    @IBOutlet var viewPromoCode: UIView!
    @IBOutlet var txtReferFirst: UITextField!
    @IBOutlet var txtReferSix: UITextField!
    @IBOutlet var txtReferFifth: UITextField!
    @IBOutlet var txtReferFour: UITextField!
    @IBOutlet var txtReferThree: UITextField!
    @IBOutlet var txtReferTwo: UITextField!
    
    @IBOutlet weak var consViewBackMainWidth: NSLayoutConstraint!
    
    @IBOutlet var btnApply: UIButton!
    var strReferCode : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // self.tabBarController?.tabBar.isHidden = false
        
        txtReferFirst.delegate = self
        txtReferTwo.delegate = self
        txtReferThree.delegate = self
        txtReferFour.delegate = self
        txtReferFifth.delegate = self
        txtReferSix.delegate = self
        
        txtReferFirst.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtReferTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtReferThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtReferFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtReferFifth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtReferSix.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
        
        
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(ReloadMyWalletVc(_:)),
                         name: NSNotification.Name("ReloadMyWalletVc"),object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*viewBackRefer.isHidden = true
        viewBackTransactions.isHidden = true
        viewBackWalletBal.isHidden = true
        viewAvailableCredit.isHidden = true
        self.tabBarController?.tabBar.isHidden = true*/
        
        self.setUIOnScreen()
    }
    @objc func ReloadMyWalletVc(_ notification: Notification)
    {
       // self.viewDidLoad()
        
        self.viewWillAppear(true)
      //  self.view.layoutIfNeeded()
    }
    override func viewDidLayoutSubviews()
    {
        self.viewBackRefer.viewTextFieldShadowBorderView()
        self.viewBackTransactions.viewTextFieldShadowBorderView()
       // self.viewBackWalletBal.viewTextFieldShadowBorderView()
        self.viewPromoCode.viewTextFieldShadowBorderView()
        self.viewAvailableCredit.viewTextFieldShadowBorderView()
        self.viewBackWalletBal.shadowZ100(frame: self.viewBackWalletBal.frame)
        
       /* self.viewBackRefer.shadowZ100(frame: self.viewBackRefer.frame)
        self.viewBackTransactions.shadowZ100(frame: self.viewBackTransactions.frame)
       
        self.viewPromoCode.shadowZ100(frame: self.viewPromoCode.frame)
        self.viewAvailableCredit.shadowZ100(frame: self.viewAvailableCredit.frame)*/
        
      //  self.viewBackDetails.shadowSecondaryView(frame: self.viewBackDetails.frame)
    }
    
    // ********** All Button Actions ********** //
    @IBAction func btnHelpClicked(_ sender: Any)
    {
        let help = self.storyboard?.instantiateViewController(withIdentifier: "HelpAnfFaqVC") as! HelpAnfFaqVC
        self.navigationController?.pushViewController(help, animated: true)
    }
    @IBAction func btnCancelRequestClicked(_ sender: Any)
    {
        
         OngoingRideCancelRequestAlert.instance.showMsg(txtmsg: "You are trying to cancel your refund request.")
         
         OngoingRideCancelRequestAlert.instance.ActionYes =
         {
             self.cancelRefundRequestAPICall()
            // self.cancelVideoRequestAPICall()
         }
         OngoingRideCancelRequestAlert.instance.ActionNo =
         {
             OngoingRideCancelRequestAlert.instance.HidePopup()
         }
         
       // self.viewWithdrawConfirmation.isHidden = true
    }
    @IBAction func ActionWithdraw(_ sender: UIButton)
    {
        
        self.getRefundDetailsAPICall()
    }
    
    @IBAction func ActionAddMoney(_ sender: UIButton)
    {
        let addMon = self.storyboard?.instantiateViewController(withIdentifier: "AddMoneyVC") as! AddMoneyVC
        self.navigationController?.pushViewController(addMon, animated: true)
    }
    
    @IBAction func ActionTransactions(_ sender: UIButton)
    {
        let trans = self.storyboard?.instantiateViewController(withIdentifier: "TransactionsVC") as! TransactionsVC
        self.navigationController?.pushViewController(trans, animated: true)
    }
    
    @IBAction func ActionReferAFriend(_ sender: Any)
    {
        let refer = self.storyboard?.instantiateViewController(withIdentifier: "ReferFriendVC") as! ReferFriendVC
        refer.strRefer = strReferCode
        
        refer.strReferMessage = self.lblReferMessage.text!
        self.addChild(refer)
        self.view.addSubview(refer.view)
        refer.didMove(toParent: self)
        
        let height = view.frame.height
        let width = view.frame.width
        refer.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    @IBAction func btnApplyClicked(_ sender: Any)
    {
        self.applyPromoCodeAPICall()
    }
    
    //MARK: - Textfield Delagted
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        let text = textField.text
        
        print((text?.utf16.count)! as Int)
        if (text?.utf16.count)! >= 1
        {
            
            switch textField
            {
            case txtReferFirst:
                txtReferTwo.becomeFirstResponder()
            case txtReferTwo:
                txtReferThree.becomeFirstResponder()
            case txtReferThree:
                txtReferFour.becomeFirstResponder()
            case txtReferFour:
                txtReferFifth.becomeFirstResponder()
            case txtReferFifth:
                txtReferSix.becomeFirstResponder()
            case txtReferSix:
                txtReferSix.resignFirstResponder()
                
            default:
                break
            }
        }
       else
       {
            switch textField
            {
            case txtReferSix:
                txtReferFifth.becomeFirstResponder()
            case txtReferFifth:
                txtReferFour.becomeFirstResponder()
            case txtReferFour:
                txtReferThree.becomeFirstResponder()
            case txtReferThree:
                txtReferTwo.becomeFirstResponder()
            case txtReferTwo:
                txtReferFirst.becomeFirstResponder()

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
    }
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension WalletVC : WithdrawMoneyVCDelegateProtocol
{
    func withdrawDataSend(strMsg: String, strHideView: Bool)
    {
        lbWithdrawConfirmationVal.text = strMsg
        viewWithdrawConfirmation.isHidden = strHideView
        self.view.bringSubviewToFront(viewWithdrawConfirmation)
    }
    
}
extension WalletVC {
    
    func setUIOnScreen()
    {
        viewWallet.isHidden = true
       // self.tabBarController?.tabBar.isHidden = true
        self.viewNavi.isHidden = true
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        self.viewBackWalletBal.layer.cornerRadius = 6.0
        self.btnAddMoney.layer.cornerRadius = 6.0
        
        self.viewBackTransactions.layer.cornerRadius = 10.0
        self.viewBackRefer.layer.cornerRadius = 10.0
        self.viewPromoCode.layer.cornerRadius = 10.0
        self.viewAvailableCredit.layer.cornerRadius = 10.0
         //self.viewBackDetails.viewTextFieldShadowBorderView()
        
        txtReferFifth.viewTextFieldPrimaryBorder()
        txtReferTwo.viewTextFieldPrimaryBorder()
        txtReferThree.viewTextFieldPrimaryBorder()
        txtReferFour.viewTextFieldPrimaryBorder()
        txtReferFifth.viewTextFieldPrimaryBorder()
        txtReferSix.viewTextFieldPrimaryBorder()
        txtReferFirst.viewTextFieldPrimaryBorder()
        
        btnHelp.layer.cornerRadius = 5.0
        btnWithdrawCancelRequest.layer.cornerRadius = 5.0
        btnHelp.shadowZ100(frame: btnHelp.frame)
        btnWithdrawCancelRequest.shadowZ100(frame: btnWithdrawCancelRequest.frame)
        
        btnApply.layer.cornerRadius = 8.0
      
        viewWithdrawConfirmation.isHidden = true
       
        self.getReferCodeDetails()
    }
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension WalletVC {
    
    func  applyPromoCodeAPICall() {
        
        /*
         promo_code
         deviceType
         */
        
        let strPromo = String(format: "%@%@%@%@%@%@",txtReferFirst.text!,txtReferFirst.text!,txtReferTwo.text!,txtReferThree.text!,txtReferFour.text!,txtReferFifth.text!,txtReferFifth.text!)
        
        if strPromo == ""
        {
            let toast = Toast(text: "Please enter promo code", delay: 0.0, duration: Delay.long)
           // let toast = Toast()
            toast.show()
            return
        }
        //"\(txtReferFirst)" + "\(txtReferTwo) + "\(txtReferThree)" + "\(txtReferFour)" + "\(txtReferFifth)" + "\(txtReferSix)"
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getWalletBalanceAPICall(dictionary: ["promo_code": strPromo,"deviceType" : "iOS"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                _ = response["data"] as! [String: Any]
             
            }
            else {
                
                if response["error_code"] as! String == "404" {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else {
                    
                  
                        viewInternetConnection.instance.showMsg(strmsg: response["message"] as! String)
                        
                        viewInternetConnection.instance.ActionOkay =
                        {
                            OngoingRideCancelRequestAlert.instance.HidePopup()
                        }
                        //  Do something
                  
                   // let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                  //  toast.show()
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func getBalanceAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getWalletBalanceAPICall(dictionary: ["getBalance": "1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            let dicData = response["data"] as! [String : Any]
            
            if response["is_error"] as! String == "false" {
                
                let dicWalletData = response["data"] as! [String: Any]
                self.lblBalance.text = "\(dicWalletData["currency_symbol"] as! String)\(dicWalletData["balance"] as! Int)"
                self.lblTermsCondition.text = "\(dicWalletData["maintain_balance_msg"] as! String)"
                self.lblTransaction.text = "\(dicWalletData["transactions_title"] as! String)"
                self.lblTransMessage.text = "\(dicWalletData["transactions_msg"] as! String)"
                self.lblRefer.text = "\(dicWalletData["refer_friend"] as! String)"
                self.lblReferMessage.text = "\(dicWalletData["refer_and_earn"] as! String)"
                self.lblCredit.text = "\(dicWalletData["currency_symbol"] as! String)\(dicWalletData["referralPoints"] as! Int)"
                self.scrollView.isHidden = false
                viewWallet.isHidden = false
                self.tabBarController?.tabBar.isHidden = false
                self.viewNavi.isHidden = false
            }
            else {
                
                if response["error_code"] as! String == "404"
                {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else if response["error_code"] as! String == "403"
                {
                    /*viewBackRefer.isHidden = true
                    viewBackTransactions.isHidden = true
                    viewBackWalletBal.isHidden = true
                    viewAvailableCredit.isHidden = true*/
                    
                    viewWallet.isHidden = true
                   // self.tabBarController?.tabBar.isHidden = true
                    self.viewNavi.isHidden = true
                    
                    viewWithdrawConfirmation.isHidden = false
                    self.view.bringSubviewToFront(viewWithdrawConfirmation)
                    lbWithdrawConfirmationVal.text = dicData["received_request"] as? String
                  //  CommonClass.moveToLogOut(viewController: self)
                }
                else
                {
                   /* viewBackRefer.isHidden = false
                    viewBackTransactions.isHidden = false
                    viewBackWalletBal.isHidden = false
                    viewAvailableCredit.isHidden = false
                    self.tabBarController?.tabBar.isHidden = false*/
                    viewWallet.isHidden = false
                    self.tabBarController?.tabBar.isHidden = false
                    self.viewNavi.isHidden = false
                    
                    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func getRefundDetailsAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getRefundDetailsAPICall(dictionary: ["getDetails": "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let withDraw = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawMoneyVC") as! WithdrawMoneyVC
                self.navigationController?.pushViewController(withDraw, animated: true)
            }
            else {
                
                if response["error_code"] as! String == "404" {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else if response["error_code"] as! String == "405" {
                    
                    let dicRefundDetailData = response["data"] as! [String: Any]
                    
                    MalFunction.instance.showMalFunction(title: "", message: "\(dicRefundDetailData["received_request"] as! String)", imgName: "IC_ErrorIcon", strFirstBtn: "CANCEL REQUEST", strSecondBtn: "HEL", strIssueName: "")
                    MalFunction.instance.ActionProceed = {
                        
                        self.cancelRefundRequestAPICall()
                    }
                    
                    MalFunction.instance.ActionHelp = {
                        
                        let help = self.storyboard?.instantiateViewController(withIdentifier: "HelpAnfFaqVC") as! HelpAnfFaqVC
                        self.navigationController?.pushViewController(help, animated: true)
                    }
                    
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
    
    func cancelRefundRequestAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.cancelRefundRequestAPICall(dictionary: ["cancelRefund": "1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                viewWithdrawConfirmation.isHidden = true
                OngoingRideCancelRequestAlert.instance.HidePopup()
                self.getReferCodeDetails()
                
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
    func getReferCodeDetails()
    {
            CommonClass.loadProgressHudCycling(viewController: self)
            APIService.sharedInstance.ReferDetail(dictionary: ["getReferralDetails": "true"]) { [self] response in
                CommonClass.removeProgressHudCycling(viewController: self)
                
                print(response)
               
                
                if response["is_error"] as! String == "false" {
                    
                    let dicCurrentData = response["data"] as! [String: Any]
                    print(dicCurrentData["referralCode"] as! String)
                    lblReferMessage.text = dicCurrentData["referralCodeMessage"] as? String
                    strReferCode = dicCurrentData["referralCode"] as? String
                    
                    self.getBalanceAPICall()
//
//                    lbReferCode.text = dicCurrentData["referralCode"] as? String
//                    lbReferCredit.text = dicCurrentData["referralCodeMessage"] as? String
//                    lbReferSchemeSubject.text = dicCurrentData["referralCodeNotice"] as? String
                        lbAvailableCredit.text = String(format: " %@", dicCurrentData["credit"] as! String)
//                    lbAvailableCredit.text = "\(dicCurrentData["credit"] as? String ?? "")"
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



