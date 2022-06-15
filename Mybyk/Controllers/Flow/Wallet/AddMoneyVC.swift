//
//  AddMoneyVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 28/06/21.
//

import UIKit
import Toaster
import PlugNPlay
import Lottie

protocol PaymentBackToProceedToUnlockDelegateProtocol
{
    func sendSearchLocationLatLong(DicPass : [String:Any])
}


class AddMoneyVC: CommonViewController
{
    var delegate: PaymentBackToProceedToUnlockDelegateProtocol? = nil
    
    @IBOutlet var viewPaymentSucess: UIView!
    @IBOutlet weak var viewLottieConfirm: AnimationView!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet var btn100: UIButton!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var btnMakePayment: UIButton!
    @IBOutlet weak var viewBackAvaiBal: UIView!
    @IBOutlet weak var viewWallet100: UIView!
    @IBOutlet weak var viewWallet200: UIView!
    @IBOutlet weak var viewWallet500: UIView!
    @IBOutlet weak var viewWallet600: UIView!
    @IBOutlet weak var viewWallet1000: UIView!
    @IBOutlet weak var viewBackEnterValue: UIView!
    @IBOutlet weak var txtEnterValue: UITextField!
    @IBOutlet weak var btnUPI: UIButton!
    @IBOutlet weak var btnPayTm: UIButton!
    @IBOutlet weak var btnCreditDebitCard: UIButton!
    @IBOutlet weak var btnNetBanking: UIButton!
    @IBOutlet var viewMoneyLimitErrorConst: NSLayoutConstraint!
    @IBOutlet var lbError: UILabel!
    
    var timer : Timer?
    @IBOutlet weak var consViewBackMainWidth: NSLayoutConstraint!
    
    var strFrwdAmount = String()
    
    var modelBalance: WalletBalanceData!
    var modelPayment: PaymentData!
    
    var utils : Utils = Utils()
    
    var moneyVal = 0
    
    var IdSubscription = String()
    var strForPaymentBack = String()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      //  self.tabBarController?.tabBar.isHidden = true
        txtEnterValue.delegate = self
        self.txtEnterValue.text = strFrwdAmount
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
        self.getBalanceAPICall()
    }
    
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionSelectWalletAmount(_ sender: UIButton)
    {
        
        switch sender.tag
        {
        case 1:
            self.txtEnterValue.resignFirstResponder()
          //  self.txtEnterValue.text = "100"
            
            if txtEnterValue.text?.count != 0
            {
                moneyVal = Int(String(txtEnterValue.text!))!
                //String(format: "%@", txtEnterValue.text)
            }
            moneyVal = moneyVal + 100
            self.txtEnterValue.text = "\(moneyVal)"
            
            // 5000 - 4700 = 300
            
//            if moneyVal > 5001
//            {
//                viewMoneyLimitErrorConst.constant = 15
//                viewBackEnterValue.viewTextFieldErrorBorder()
//                lbError.text = "You can't add more then 5000."
//            }
//            else
//            {
//                viewMoneyLimitErrorConst.constant = 0
//                viewBackEnterValue.viewTextFieldActiveBorder()
//                self.txtEnterValue.text = "\(moneyVal)"
//            }
            self.viewWallet100.backgroundColor = UIColor(named: Color_Primary)
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    // perform your task here...
                self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
                }
          //  UIButton.animate(withDuration: 0.2, animations: {
          //      self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
          //      self.view.layoutIfNeeded()
          //    })
            
           // self.viewWallet100.backgroundColor = UIColor(named: Color_Primary)
          //  self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
          //  self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
          //  self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
          //  self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)
        case 2:
            self.txtEnterValue.resignFirstResponder()
          //  self.txtEnterValue.text = "200"
            
            if txtEnterValue.text?.count != 0
            {
                moneyVal = Int(String(txtEnterValue.text!))!
                //String(format: "%@", txtEnterValue.text)
            }
            
            moneyVal = moneyVal + 200
            self.txtEnterValue.text = "\(moneyVal)"
//            if moneyVal > 5001
//            {
//                viewMoneyLimitErrorConst.constant = 15
//                viewBackEnterValue.viewTextFieldErrorBorder()
//                lbError.text = "You can't add more then 5000."
//            }
//            else
//            {
//                viewMoneyLimitErrorConst.constant = 0
//                viewBackEnterValue.viewTextFieldActiveBorder()
//                self.txtEnterValue.text = "\(moneyVal)"
//            }
            
            self.viewWallet200.backgroundColor = UIColor(named: Color_Primary)
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    // perform your task here...
                self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
                }
           /* self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet200.backgroundColor = UIColor(named: Color_Primary)
            self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)*/
        case 3:
            self.txtEnterValue.resignFirstResponder()
           // self.txtEnterValue.text = "500"
            if txtEnterValue.text?.count != 0
            {
                moneyVal = Int(String(txtEnterValue.text!))!
                //String(format: "%@", txtEnterValue.text)
            }
            moneyVal = moneyVal + 500
            self.txtEnterValue.text = "\(moneyVal)"
            
//            if moneyVal > 5001
//            {
//                viewMoneyLimitErrorConst.constant = 15
//                viewBackEnterValue.viewTextFieldErrorBorder()
//                lbError.text = "You can't add more then 5000."
//            }
//            else
//            {
//                viewMoneyLimitErrorConst.constant = 0
//                viewBackEnterValue.viewTextFieldActiveBorder()
//                self.txtEnterValue.text = "\(moneyVal)"
//            }
            self.viewWallet500.backgroundColor = UIColor(named: Color_Primary)
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    // perform your task here...
                self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
                }
            /*self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet500.backgroundColor = UIColor(named: Color_Primary)
            self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)*/
        case 4:
            self.txtEnterValue.resignFirstResponder()
           // self.txtEnterValue.text = "600"
            
            if txtEnterValue.text?.count != 0
            {
                moneyVal = Int(String(txtEnterValue.text!))!
                //String(format: "%@", txtEnterValue.text)
            }
            moneyVal = moneyVal + 600
            self.txtEnterValue.text = "\(moneyVal)"
            
//            if moneyVal > 5001
//            {
//                viewMoneyLimitErrorConst.constant = 15
//                viewBackEnterValue.viewTextFieldErrorBorder()
//                lbError.text = "You can't add more then 5000."
//            }
//            else
//            {
//                viewMoneyLimitErrorConst.constant = 0
//                viewBackEnterValue.viewTextFieldActiveBorder()
//                self.txtEnterValue.text = "\(moneyVal)"
//            }
            
            self.viewWallet600.backgroundColor = UIColor(named: Color_Primary)
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    // perform your task here...
                self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
                }
           /* self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet600.backgroundColor = UIColor(named: Color_Primary)
            self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)*/
        case 5:
            self.txtEnterValue.resignFirstResponder()
           // self.txtEnterValue.text = "1000"
            if txtEnterValue.text?.count != 0
            {
                moneyVal = Int(String(txtEnterValue.text!))!
                //String(format: "%@", txtEnterValue.text)
            }
            moneyVal = moneyVal + 1000
            self.txtEnterValue.text = "\(moneyVal)"
            
//            if moneyVal > 5001
//            {
//                viewMoneyLimitErrorConst.constant = 15
//                viewBackEnterValue.viewTextFieldErrorBorder()
//                lbError.text = "You can't add more then 5000."
//            }
//            else
//            {
//                viewMoneyLimitErrorConst.constant = 0
//                viewBackEnterValue.viewTextFieldActiveBorder()
//                self.txtEnterValue.text = "\(moneyVal)"
//            }
            
          /*  self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet1000.backgroundColor = UIColor(named: Color_Primary)*/
            self.viewWallet1000.backgroundColor = UIColor(named: Color_Primary)
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                    // perform your task here...
                self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)
                }
        default:
            self.txtEnterValue.resignFirstResponder()
            self.txtEnterValue.text = ""
            moneyVal = 0
            self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)
        }
    }
    
    @IBAction func ActionUPI(_ sender: UIButton) {
        
        btnUPI.isSelected = true
        btnPayTm.isSelected = false
        btnCreditDebitCard.isSelected = false
        btnNetBanking.isSelected = false
    }
    
    @IBAction func ActionPayTm(_ sender: UIButton) {
        
        btnUPI.isSelected = false
        btnPayTm.isSelected = true
        btnCreditDebitCard.isSelected = false
        btnNetBanking.isSelected = false
    }
    
    @IBAction func ActionCreditDebitCard(_ sender: UIButton) {
        
        btnUPI.isSelected = false
        btnPayTm.isSelected = false
        btnCreditDebitCard.isSelected = true
        btnNetBanking.isSelected = false
    }
    
    @IBAction func ActionNetBanking(_ sender: UIButton) {
        
        btnUPI.isSelected = false
        btnPayTm.isSelected = false
        btnCreditDebitCard.isSelected = false
        btnNetBanking.isSelected = true
    }
    func validatiohHeight(txtField : NSLayoutConstraint,val : Int)
    {
        txtField.constant = CGFloat(val)
    }
    @IBAction func ActionMakePayment(_ sender: UIButton)
    {
        /*
         if moneyVal > 5000
         {
             viewMoneyLimitErrorConst.constant = 15
             viewBackEnterValue.viewTextFieldErrorBorder()
             lbError.text = "You can't add more then 5000."
         }
         else
         {
             self.txtEnterValue.text = "\(moneyVal)"
         }
         */
        if txtEnterValue.text!.isEmpty
        {
            self.validatiohHeight(txtField: viewMoneyLimitErrorConst, val: 15)
            viewBackEnterValue.viewTextFieldErrorBorder()
            lbError.text = "Field cannot be empty."
            return
        }
        if Int((txtEnterValue.text)!)! == 0
        {
            viewMoneyLimitErrorConst.constant = 15
            viewBackEnterValue.viewTextFieldErrorBorder()
            lbError.text = "Invalid amount"
            return
        }
        if Int((txtEnterValue.text)!)! > 4800
        {
            viewMoneyLimitErrorConst.constant = 15
            viewBackEnterValue.viewTextFieldErrorBorder()
            lbError.text = "You can't add more then 4800."
            return
        }
        print(modelBalance.isPaytmShow)
        print(modelBalance.isPayuShow)
        
//        if modelBalance.isPaytmShow == "0" {
//            self.paytm()
//            print("PAYTM")
//
//        }
      
        if modelBalance.isPayuShow == "1"
        {
            print("PAYUMONEY")
            
            self.addPaymentWithPayUMoneyAPICall()
            
//            let txnParam = PUMTxnParam()
//            txnParam.phone = "8866308886"
//            txnParam.email = "gaurav.patel@equestsolutions.net"
//            txnParam.amount = "123"
//            txnParam.environment = .test
//            txnParam.firstname = "Gaurav"
//            txnParam.key = "merchantKey"
//            txnParam.merchantid = "MerchantID"
//            txnParam.txnID = "txnID123"
//            txnParam.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
//            txnParam.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
//            txnParam.productInfo = "\(UIDevice.current.name)"
//            txnParam.udf1 = "userDefinedField1"
//            txnParam.hashValue = "HashFromServer"
//
//            PlugNPlay.setTopBarColor(UIColor(named: Color_Primary))
//            PlugNPlay.setButtonColor(UIColor(named: Color_Primary))
//            PlugNPlay.presentPaymentViewController(withTxnParams: txnParam, on: self) { paymentResponse, error, id in
//
//            }
        }
       else
        {
           self.paytm()
       }
        
    }
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //

extension AddMoneyVC : PGTransactionDelegate
{
    @objc func timerHideUnlockSucccess()
    {
    //    self.isUnlock = false
       // self.isUnlock = true
        
        self.timer?.invalidate()
        
        /*
         print(dicSubscriptionPlan)
         //idUserSubscriptions
         //recharge_amount
         //self.txtEnterValue.text
         
         //deviceType = "2"
         //subscription_details object ne replace kravano
         //WsAddBalance
         addMoney.strForPaymentBack = "BackToChangeUnlock"
         */
        
        print(strForPaymentBack)
        if strForPaymentBack == "BackToChangeUnlock"
        {
            self.UpdateBalanceAPICall()
        }
        else
        {
            for vc in self.navigationController!.viewControllers
            {
                if let myViewCont = vc as? WalletVC
                {
                    self.viewLottieConfirm.stop()
                    self.viewPaymentSucess.removeFromSuperview()
                    
                  //  DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                   // {
                        self.navigationController?.popToViewController(myViewCont, animated: true)
                   // }
                   
                }
            }
        }
        
        
       /* let ongoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
        ongoing.isHome = true
      //  UserDefaults.standard.setValue("RideOngoing", forKey: "RideStatus")
      //  UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(ongoing, animated: true)*/
    }
    //MARK: - update Balance Proceed to pay
    
    func UpdateBalanceAPICall() {
        
        //  @Field("idUserSubscriptions") idUserSubscriptions: Int,  == je plan select karyo hse eni id pass kravani
      //  @Field("recharge_amount") rechargeAmount: Float, == user je payment karyu hoy e pass thse
      //  @Field("deviceType") deviceType: String, == as per flow
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getWalletBalanceAPICall(dictionary: ["idUserSubscriptions": IdSubscription,"recharge_amount" : self.txtEnterValue.text!,"deviceType" : "2"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let dicWalletData = response["data"] as! [String: Any]
                
                print(dicWalletData)
                
               
            //    self.delegate?.sendSearchLocationLatLong(strLat: "", strLong: "", strAddress: "", strCheckFromSearchLocation: "FromCurrentLocation")
                
                for vc in self.navigationController!.viewControllers
                {
                    if let myViewCont = vc as? SubscriptionPlanVC
                    {
                        self.viewLottieConfirm.stop()
                        self.viewPaymentSucess.removeFromSuperview()
                        
                      //  DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                       // {
                        self.delegate?.sendSearchLocationLatLong(DicPass: dicWalletData["subscription_details"] as! [String : Any])
                        
                            self.navigationController?.popToViewController(myViewCont, animated: true)
                       // }
                       
                    }
                }
                
               /* do {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: dicWalletData, options: .prettyPrinted)
                    print(jsonData)
                    
                    let decoder = JSONDecoder()
                    modelBalance = try decoder.decode(WalletBalanceData.self, from: jsonData)
                    
                    self.lblBalance.text = "\(modelBalance.currencySymbol) \(modelBalance.balance)"
                    
                    
                } catch {
                    print(error.localizedDescription)
                }*/
                
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
    
    //MARK: - Transaction method
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func didFinishedResponse(_ controller: PGTransactionViewController!, response responseString: String!)
    {
        print(responseString!)
        
       
        
        let dict = convertToDictionary(text: responseString)
        
        print(dict!)
        
        //STATUS":"TXN_SUCCESS
        let statusSucc = dict!["STATUS"] as! String
        
        if statusSucc == "TXN_SUCCESS"
        {
           // controller.dismiss(animated: true)
            self.dismiss(animated: true)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
//            { [self] in
                self.viewPaymentSucess.isHidden = false
                self.view.bringSubviewToFront(self.viewPaymentSucess)
                
               // controller.view.addSubview(viewPaymentSucess)
                
               // controller.view.addSubview(viewPaymentSucess)
                
                self.viewLottieConfirm.contentMode = .scaleAspectFit
                self.viewLottieConfirm.loopMode = .playOnce
                self.viewLottieConfirm.animationSpeed = 0.8
                self.viewLottieConfirm.play()
               
                self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerHideUnlockSucccess), userInfo: nil, repeats: false)//  self.navigationController?.popToViewController(myViewCont, animated: true)
          //  }
            
        }
        else
        {
            print(statusSucc)
            self.dismiss(animated: true)
           
           
            /*for vc in self.navigationController!.viewControllers
            {
                if let myViewCont = vc as? AddMoneyVC
                {
                    print(myViewCont)
                   // self.viewLottieConfirm.stop()
                   // self.viewPaymentSucess.removeFromSuperview()
                    
                  //  DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                   // {
                        self.navigationController?.popToViewController(myViewCont, animated: true)
                   // }
                   
                }
            }*/
        }
       /* self.viewPaymentSucess.frame = (self.view.bounds)
        self.view.addSubview(viewPaymentSucess)
       // self.view.window?.addSubview(viewPaymentSucess)*/
        
      
        
      //  self.navigationController?.popViewController(animated: true)
       // print("Helo")
    }
    func didCancelTrasaction(_ controller: PGTransactionViewController!)
    {
        print("Transaction Cancel")
       // print("Hiii")
    }
    
    func errorMisssingParameter(_ controller: PGTransactionViewController!, error: Error!)
    {
        print("Transaction Error")
       // print("Hiii1")
    }
    
    
}
extension AddMoneyVC {
    
    func setUIOnScreen() {
        
        print(IdSubscription)
        viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnMakePayment.layer.cornerRadius = 8.0
        
        viewMoneyLimitErrorConst.constant = 0
        
        self.consViewBackMainWidth.constant = self.view.frame.width
        
        //self.viewBackAvaiBal.viewBorderWithCornerRadius()
        
        self.viewBackEnterValue.viewBorderWithCornerRadius()
        self.viewBackAvaiBal.viewTextFieldShadowBorderView()
        
     /*   self.viewWallet100.viewTextFieldShadowBorderView()
        self.viewWallet200.viewTextFieldShadowBorderView()
        self.viewWallet500.viewTextFieldShadowBorderView()
        self.viewWallet600.viewTextFieldShadowBorderView()
        self.viewWallet1000.viewTextFieldShadowBorderView()*/
        
       
        
        self.viewWallet100.shadowZ100(frame: viewWallet100.frame)
        self.viewWallet200.shadowZ100(frame: viewWallet200.frame)
        self.viewWallet500.shadowZ100(frame: viewWallet500.frame)
        self.viewWallet600.shadowZ100(frame: viewWallet600.frame)
        self.viewWallet1000.shadowZ100(frame: viewWallet1000.frame)
        
        viewPaymentSucess.isHidden = true
        
    }
    
   /* func getPayUTxnParam() -> PUMTxnParam {
        
        let txnParam = PUMTxnParam()
        
        txnParam.phone = modelPayment.payudetails.mobile
        txnParam.email = modelPayment.payudetails.email
        txnParam.amount = txtEnterValue.text!
        txnParam.environment = .test
        txnParam.firstname = modelPayment.payudetails.username
        txnParam.key = modelPayment.payudetails.key
        txnParam.merchantid = modelPayment.payudetails.merchantID
        txnParam.txnID = String(format: "%d", modelPayment.idOnlinePaymentTxnDetails)
        txnParam.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
        txnParam.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
        txnParam.productInfo = modelPayment.payudetails.productinfo
        txnParam.udf1 = String(format: "%d", modelPayment.idUsers)
        txnParam.udf2 = ""
        txnParam.udf3 = ""
        txnParam.udf4 = "2"
        txnParam.udf5 = ""
        txnParam.udf6 = ""
        txnParam.udf7 = ""
        txnParam.udf8 = ""
        txnParam.udf9 = ""
        txnParam.udf10 = ""
        txnParam.hashValue = getHashForPayUPaymentParams(txnParam)
        
        return txnParam
    }*/
    
    func getHashForPayUPaymentParams(_ txnParam: PUMTxnParam ,_ Strsalt : String) -> String? {
        let salt = Strsalt//modelPayment.payudetails.salt
        var hashSequence: String? = nil
        
        if let key = txnParam.key, let txnID = txnParam.txnID, let amount = txnParam.amount, let productInfo = txnParam.productInfo, let firstname = txnParam.firstname, let email = txnParam.email, let udf1 = txnParam.udf1, let udf2 = txnParam.udf2, let udf3 = txnParam.udf3, let udf4 = txnParam.udf4, let udf5 = txnParam.udf5, let udf6 = txnParam.udf6, let udf7 = txnParam.udf7, let udf8 = txnParam.udf8, let udf9 = txnParam.udf9, let udf10 = txnParam.udf10 {
            hashSequence = "\(key)|\(txnID)|\(amount)|\(productInfo)|\(firstname)|\(email)|\(udf1)|\(udf2)|\(udf3)|\(udf4)|\(udf5)|\(udf6)|\(udf7)|\(udf8)|\(udf9)|\(udf10)|\(salt)"
        }
        
        let hash = self.utils.createSHA512(hashSequence)
        
        
        return hash
    }
    
}

// ************************************ //
// MARK:- UITextField Delegate Methods
// ************************************ //

extension AddMoneyVC: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
           let maxLength = 4800
           let currentString: NSString = textField.text! as NSString
           let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
       // print("NEW string",Int(newString as String)!)
        
           
        //   return newString.length <= maxLength
      //  return range.location < 1
        print("NEW",newString)
        if newString == ""
        {
            return true
        }
        else if Int(newString as String)! > maxLength
        {
            viewMoneyLimitErrorConst.constant = 15
            viewBackEnterValue.viewTextFieldErrorBorder()
            lbError.text = "You can't add more then 4800."
            
            return false
        }
        else
        {
            viewMoneyLimitErrorConst.constant = 0
            viewBackEnterValue.viewTextFieldActiveBorder()
            
           /* self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
            self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)*/
           // self.viewBackEnterValue.viewTextFieldPrimaryBorder()
            return true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
            textField.text = ""
       
        
        
//        if moneyVal > 5000
//        {
//            viewMoneyLimitErrorConst.constant = 15
//        }
//        else
//        {
//            self.txtEnterValue.text = "\(moneyVal)"
//        }
        
        viewMoneyLimitErrorConst.constant = 0
        viewBackEnterValue.viewTextFieldActiveBorder()
        
        self.viewWallet100.backgroundColor = UIColor(named: Color_N_Light00)
        self.viewWallet200.backgroundColor = UIColor(named: Color_N_Light00)
        self.viewWallet500.backgroundColor = UIColor(named: Color_N_Light00)
        self.viewWallet600.backgroundColor = UIColor(named: Color_N_Light00)
        self.viewWallet1000.backgroundColor = UIColor(named: Color_N_Light00)
        self.viewBackEnterValue.viewTextFieldPrimaryBorder()
        //txtFirst.viewTextFieldPrimaryBorder()
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension AddMoneyVC
{
    
    func getBalanceAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getWalletBalanceAPICall(dictionary: ["getBalance": "1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicWalletData = response["data"] as! [String: Any]
                
                do {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: dicWalletData, options: .prettyPrinted)
                    print(jsonData)
                    
                    let decoder = JSONDecoder()
                    modelBalance = try decoder.decode(WalletBalanceData.self, from: jsonData)
                    
                    self.lblBalance.text = "\(modelBalance.currencySymbol) \(modelBalance.balance)"
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
                
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
    
    //MARK: - Paytm Integration
    
    func paytm() -> Void
    {
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getWalletBalanceAPICall(dictionary: ["amount": "\(txtEnterValue.text!)", "deviceType": "2", "txnType": "PAYTM"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicPaytmData = response["data"] as! [String: Any]
                let paytmData = dicPaytmData["paytmdetails"] as! [String: Any]
                print(paytmData)
                
                if self.txtEnterValue.text != nil
                {
                    if Double(self.txtEnterValue.text!)! > 1000000.00
                    {
                        AlertView.instance.showAlert(message: "Amount Exceeding the limit 1000000", image: "IC_ErrorIcon", alertType: .success)
                        return
                    }
                }
                
                
                do {
                    /*
                     @Field("MID") mId: String,
                     @Field("ORDER_ID") orderId: String,
                     @Field("CUST_ID") custId: String,
                     @Field("CHANNEL_ID") channelId: String,
                     @Field("TXN_AMOUNT") txnAmount: String,
                     @Field("WEBSITE") website: String,
                     @Field("CALLBACK_URL") callbackUrl: String,
                     @Field("INDUSTRY_TYPE_ID") industryTypeId: String,
                     @Field("MERC_UNQ_REF") merchUnRefId: String,
                     @Field("EMAIL") email: String,
                     @Field("MOBILE_NO") mobileNo: String?
                     */
                    
                    let mc = PGMerchantConfiguration.default() as PGMerchantConfiguration
                    //Step 2: Create the order with whatever params you want to add. But make sure that you include the merchant mandatory params
                    var orderDict = [String: Any]()
                    //Merchant configuration in the order object
                    
                    let CALLBACK_URL = paytmData["CALLBACK_URL"]! as! String;
                    
                    let CUST_ID = NSString(format:"%d",dicPaytmData["idUsers"] as! Int) as String?
                    //     orderDict["PAYTM_BASE_URL"] = paytmdetails["PAYTM_BASE_URL"]! as! String;
                    orderDict["MID"] = paytmData["merchantID"]! as! String
                    orderDict["ORDER_ID"] = NSString(format:"%d",dicPaytmData["idOnlinePaymentTxnDetails"] as! Int) as String?
                    orderDict["CUST_ID"] = CUST_ID
                    orderDict["CHANNEL_ID"] = "WAP"
                    orderDict["TXN_AMOUNT"] = self.txtEnterValue.text
                    orderDict["WEBSITE"] = paytmData["website"]! as! String
                    orderDict["CALLBACK_URL"] = CALLBACK_URL
                    orderDict["INDUSTRY_TYPE_ID"] = "Retail109"
                    orderDict["MERC_UNQ_REF"] = String(format:"channelCode-6_idUsers-%@",CUST_ID!)
                  //  orderDict["REQUEST_TYPE"] = "DEFAULT"
                    
                    orderDict["EMAIL"] = paytmData["email"]! as! String
                    orderDict["MOBILE_NO"] = paytmData["mobile"]! as! String
                    print("orderDict" ,orderDict)
                    
                    
                    CommonClass.loadProgressHudCycling(viewController: self)
                    
                    APIService.sharedInstance.getPaytmCheckSum(dictionary: orderDict, resultHandler: { (results) in
                        
                        CommonClass.removeProgressHudCycling(viewController: self)
                        
                        print(results)
                      //  CommonClass.removeprogresshud(viewController : self)
                     //   RappleActivityIndicatorView.stopAnimation()
                        let CHECKSUMHASH = results["CHECKSUMHASH"] as! String?
                        orderDict["CHECKSUMHASH"] = CHECKSUMHASH
                        let order = PGOrder(params: orderDict)
                        
                        
                        let txnController = PGTransactionViewController.init(transactionFor: order)
                        let sandbox = paytmData["sandbox"] as! Int
                        
                        if sandbox == 1
                        {
                            txnController?.serverType = .init(rawValue: 1)
                        }
                        else
                        {
                            txnController?.serverType = .init(rawValue: 0)
                        }
                        txnController!.merchant = mc
                        txnController?.delegate = self
                        
                        self.present(txnController!, animated: true)
                     
                      //  self.navigationController?.pushViewController(txnController!, animated: true)
                        
                        
                    }) { (error) in
                        CommonClass.removeProgressHudCycling(viewController: self)
                       // CommonClass.removeprogresshud(viewController : self)
                     //   RappleActivityIndicatorView.stopAnimation()
                        
                        
                    }
                
                } catch {
                    print("PRINT",error.localizedDescription)
                }
                
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
    
    //MARK: - PayuMoney Integration
    func addPaymentWithPayUMoneyAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getWalletBalanceAPICall(dictionary: ["amount": "\(txtEnterValue.text!)", "deviceType": "2", "txnType": "PAYUMONEY"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let dicPayUMoneyData = response["data"] as! [String: Any]
                
                print(dicPayUMoneyData)
                if self.txtEnterValue.text != nil
                {
                    if Double(self.txtEnterValue.text!)! > 1000000.00
                    {
                        AlertView.instance.showAlert(message: "Amount Exceeding the limit 1000000", image: "IC_ErrorIcon", alertType: .success)
                        return
                    }
                }
                
                
                do {
                    
                    
                  //  let jsonData = try JSONSerialization.data(withJSONObject: dicPayUMoneyData, options: .prettyPrinted)
                 //   print(jsonData)
                    
                   // let decoder = JSONDecoder()
                   // modelPayment = try decoder.decode(PaymentData.self, from: jsonData)
                    
                    PlugNPlay.setTopBarColor(UIColor(named: Color_Primary))
                    PlugNPlay.setButtonColor(UIColor(named: Color_Primary))
                    
                   // let txnParam = self.getPayUTxnParam()
                    
                    
                    
                     let txnParam = PUMTxnParam()
                    let strId : String!
                    let strUID : String!
                    
                    let payuDetail = dicPayUMoneyData["payudetails"] as! [String:Any]
                    
                     txnParam.phone = payuDetail["mobile"] as? String //modelPayment.payudetails.mobile
                     txnParam.email = payuDetail["email"] as? String//modelPayment.payudetails.email
                     txnParam.amount = txtEnterValue.text!
                     txnParam.environment = .test
                     txnParam.firstname = payuDetail["username"] as? String//modelPayment.payudetails.username
                     txnParam.key = payuDetail["key"] as? String//modelPayment.payudetails.key
                     txnParam.merchantid = payuDetail["merchantID"] as? String//modelPayment.payudetails.merchantID
                    
                    
                    if let StrStationID = dicPayUMoneyData["idOnlinePaymentTxnDetails"] as? String
                    {
                        strId = StrStationID
                    }
                    else
                    {
                        let StrStationIDCovert =  dicPayUMoneyData["idOnlinePaymentTxnDetails"]
                        strId  = "\(StrStationIDCovert as! Int)"
                    }
                    
                     txnParam.txnID = strId
                    //String(format: "%d", dicPayUMoneyData["idOnlinePaymentTxnDetails"] as! String)//String(format: "%d", modelPayment.idOnlinePaymentTxnDetails)
                     txnParam.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
                     txnParam.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
                     txnParam.productInfo = payuDetail["productinfo"] as? String//modelPayment.payudetails.productinfo
                    
                    if let StrStationID = dicPayUMoneyData["idUsers"] as? String
                    {
                        strUID = StrStationID
                    }
                    else
                    {
                        let StrStationIDCovert =  dicPayUMoneyData["idUsers"]
                        strUID  = "\(StrStationIDCovert as! Int)"
                    }
                    
                     txnParam.udf1 = strUID
                    //String(format: "%d", dicPayUMoneyData["idUsers"] as! String)//String(format: "%d", modelPayment.idUsers)
                     txnParam.udf2 = ""
                     txnParam.udf3 = ""
                     txnParam.udf4 = "2"
                     txnParam.udf5 = ""
                     txnParam.udf6 = ""
                     txnParam.udf7 = ""
                     txnParam.udf8 = ""
                     txnParam.udf9 = ""
                     txnParam.udf10 = ""
                    txnParam.hashValue = getHashForPayUPaymentParams(txnParam, (payuDetail["salt"] as? String)!)
                     
                    DispatchQueue.main.async
                    {
                        PlugNPlay.presentPaymentViewController(withTxnParams: txnParam, on: self) { (paymentResponse, error, extraParams) in
                            
                            print("PAy",paymentResponse)
                            print("Erroe",error)
                            print("Param",extraParams)
                            
                            if error != nil {
                                
                                let toast = Toast(text: "\(error!.localizedDescription)", delay: 0.0, duration: Delay.long)
                                toast.show()
                                
                            } else if paymentResponse != nil
                            {
            
                                var message: String?
                                if paymentResponse?["result"] != nil && (paymentResponse?["result"] is [AnyHashable: Any]) {
                                    message = (paymentResponse?["result"] as? NSObject)?.value(forKey: "error_Message") as? String
                                    if message?.isEmpty == false || (message?.count ?? 0) == 0 || (message == "No Error") {
                                        message = (paymentResponse?["result"] as? NSObject)?.value(forKey: "status") as? String
                                    }
                                } else {
                                    message = paymentResponse?["status"] as? String
                                }
                                
                                let toast = Toast(text: message, delay: 0.0, duration: Delay.long)
                                toast.show()
                                
                            }
                            
                        }
                        
                    }
                    
                    
                } catch {
                    print("PRINT",error.localizedDescription)
                }
                
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


