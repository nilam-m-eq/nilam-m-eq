//
//  WithdrawMoneyVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit
import Toaster

protocol WithdrawMoneyVCDelegateProtocol
{
    func withdrawDataSend(strMsg : String,strHideView : Bool)
}

class WithdrawMoneyVC: CommonViewController {
    @IBOutlet weak var viewNoteHeightConst: NSLayoutConstraint!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var btnWithdrawMoney: UIButton!
    @IBOutlet weak var viewBackAccountNumber: UIView!
    @IBOutlet var txtAccountNumber: UITextField!
    @IBOutlet weak var viewBackReAccountNumber: UIView!
    @IBOutlet var txtReAccountNumber: UITextField!
    @IBOutlet weak var viewBackIFSCCode: UIView!
    @IBOutlet var txtIFSCCode: UITextField!
    @IBOutlet weak var viewBackBankName: UIView!
    @IBOutlet var txtBankName: UITextField!
    @IBOutlet weak var viewBackBeneficiaryName: UIView!
    @IBOutlet var txtBeneficiaryName: UITextField!
    @IBOutlet weak var viewBackBankBranch: UIView!
    @IBOutlet var txtBankBranch: UITextField!
    @IBOutlet weak var viewBackNote: UIView!
    @IBOutlet var txtNote: UITextField!
    
    @IBOutlet var lbBeneficiary: UILabel!
 
    @IBOutlet var lbBankBranch: UIView!
    @IBOutlet var viewBeneficiaryHeightConst: NSLayoutConstraint!
   // @IBOutlet var viewBeneficiaryHeightConst: UIView!
    @IBOutlet var lbBankNAme: UILabel!
    @IBOutlet var viewBankNameHeightConst: NSLayoutConstraint!
   
    @IBOutlet var ViewBankBranchHeightConst: NSLayoutConstraint!
    @IBOutlet var viewReConfAccntHeightConst: NSLayoutConstraint!
    @IBOutlet var viewAccntHeightConst: NSLayoutConstraint!
    
    @IBOutlet var viewIFSCHeightConst: NSLayoutConstraint!
    @IBOutlet var lbIFSC: UILabel!
    @IBOutlet var lbReconfiAccnt: UILabel!
    @IBOutlet var lbAccntHeightConst: UILabel!
    @IBOutlet weak var consViewBackMainWidth: NSLayoutConstraint!
    
    var delegate: WithdrawMoneyVCDelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionWithdrawMoney(_ sender: UIButton) {
        
        if validateRefundDetails()
        {
            
            let WithdrawCon = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawConfirmVC") as! WithdrawConfirmVC
            self.addChild(WithdrawCon)
            self.view.addSubview(WithdrawCon.view)
            WithdrawCon.didMove(toParent: self)
            WithdrawCon.delegate = self
            WithdrawCon.lblAccountNumber.text = "\(txtAccountNumber.text!)"
            WithdrawCon.lblIFSCCode.text = "\(txtIFSCCode.text!)"
            WithdrawCon.lblBeneficiaryName.text = "\(txtBeneficiaryName.text!)"
            WithdrawCon.lblBankName.text = "\(txtBankName.text!)"
            WithdrawCon.lblBranchName.text = "\(txtBankBranch.text!)"
            
        }
        
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension WithdrawMoneyVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnWithdrawMoney.layer.cornerRadius = 10.0
        
        self.consViewBackMainWidth.constant = self.view.frame.width
        
        self.viewBackAccountNumber.viewBorderWithCornerRadius()
        self.viewBackReAccountNumber.viewBorderWithCornerRadius()
        self.viewBackIFSCCode.viewBorderWithCornerRadius()
        self.viewBackBankName.viewBorderWithCornerRadius()
        self.viewBackBeneficiaryName.viewBorderWithCornerRadius()
        self.viewBackBankBranch.viewBorderWithCornerRadius()
        self.viewBackNote.viewBorderWithCornerRadius()
        
        self.ErrorLable()
        
    }
    func ErrorLable() -> Void
    {
        viewAccntHeightConst.constant = 0
        viewReConfAccntHeightConst.constant = 0
        viewIFSCHeightConst.constant = 0
        viewBankNameHeightConst.constant = 0
        viewBeneficiaryHeightConst.constant = 0
        ViewBankBranchHeightConst.constant = 0
        viewNoteHeightConst.constant = 0
    }
    func validateRefundDetails() -> Bool {
        
        if (txtAccountNumber.text?.count)! <= 0
        {
            /*
             /*  self.viewBackAccountNumber.viewTextFieldPrimaryBorder()
               self.ValidationofHeight(view: viewAccntHeightConst, val: 15)
               self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
               self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
               self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
               self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
               self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)*/
             */
              self.viewBackAccountNumber.viewTextFieldErrorBorder()
              self.ValidationofHeight(view: viewAccntHeightConst, val: 15)
              self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
              self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
              self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
              self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
              self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
              self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
           /* lbAccntHeightConst.text = ""
            let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            return false
            
        }
        if (txtReAccountNumber.text?.count)! <= 0
        {
           /* let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            self.viewBackReAccountNumber.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 15)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
            return false
            
        }
        if txtAccountNumber.text != txtReAccountNumber.text
        {
           /* let toast = Toast(text: "Account number does not match.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            self.viewBackReAccountNumber.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 15)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
            lbReconfiAccnt.text = "Account number does not match."
            
            return false
        }
        if (txtIFSCCode.text?.count)! <= 0
        {
            self.viewBackIFSCCode.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 15)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
            return false
           /* let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
        }
        let nameValue: String = txtIFSCCode.text!
        
        let set_alphabetic = CharacterSet(charactersIn: "ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        let set_mix = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        
        let START_4_CHAR = String(nameValue.prefix(4))
        let END_6_CHAR = String(nameValue.suffix(6))
        
        print(txtIFSCCode.text!.count)
        if (txtIFSCCode.text!.count) == 11
        {
            
            if START_4_CHAR.rangeOfCharacter(from: set_alphabetic.inverted) != nil
            {
                /*let toast = Toast(text: "IFSC Code First 4 Letter should be Alphabet.", delay: 0.0, duration: Delay.long)
                toast.show()*/
                self.viewBackIFSCCode.viewTextFieldErrorBorder()
                self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
                self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
                self.ValidationofHeight(view: viewIFSCHeightConst, val: 15)
                self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
                self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
                self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
                self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
               // lbIFSC.text = "IFSC Code First 4 Letter should be Alphabet."
                lbIFSC.text = "IFSC code is invalid"
                return false
            }
            
            if END_6_CHAR.rangeOfCharacter(from: set_mix.inverted) != nil {
                
                /*let toast = Toast(text: "IFSC code last six characters(usually numeric,but can be alphabetic", delay: 0.0, duration: Delay.long)
                toast.show()*/
                self.viewBackIFSCCode.viewTextFieldErrorBorder()
                self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
                self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
                self.ValidationofHeight(view: viewIFSCHeightConst, val: 35)
                self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
                self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
                self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
                self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
                lbIFSC.text = "IFSC code last six characters(usually numeric,but can be alphabetic"
                return false
            }
           
        }
        else
        {
            //IFSC Code length should be 11
            
           /* let toast = Toast(text: "IFSC Code length should be 11", delay: 0.0, duration: Delay.long)
            toast.show()*/
           
            if txtIFSCCode.text!.count <= 11
            {
                self.viewBackIFSCCode.viewTextFieldErrorBorder()
                self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
                self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
                self.ValidationofHeight(view: viewIFSCHeightConst, val: 15)
                self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
                self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
                self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
                self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
                lbIFSC.text = "IFSC Code length should be 11"
                return false
            }
            else
            {
               self.viewBackIFSCCode.viewTextFieldErrorBorder()
               self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
               self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
               self.ValidationofHeight(view: viewIFSCHeightConst, val: 15)
               self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
               self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
               self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
                self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
               lbIFSC.text = "IFSC code is invalid"
               return false
             }
        }
        
        if (txtBankName.text?.count)! <= 0 {
            
           /* let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            self.viewBackBankName.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 15)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
            return false
        }
        if (txtBeneficiaryName.text?.count)! <= 0 {
            
           /* let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            self.viewBackBeneficiaryName.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 15)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
            return false
        }
        if (txtBankBranch.text?.count)! <= 0 {
            
           /* let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            self.viewBackBankBranch.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 15)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
            return false
        }
        if (txtNote.text?.count)! <= 0 {
            
           /* let toast = Toast(text: "Please fill all the details marked compulsory and try again.", delay: 0.0, duration: Delay.long)
            toast.show()*/
            self.viewBackNote.viewTextFieldErrorBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
            self.ValidationofHeight(view: viewNoteHeightConst, val: 15)
            return false
        }
        return true
        
    }
    
    
}


// ************************************ //
// MARK:- UITextField Delegate Methods
// ************************************ //
extension WithdrawMoneyVC : UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if textField == txtIFSCCode {
//
//            let maxLength = 4
//            let currentString: NSString = textField.text as! NSString
//            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
//
//        return true
//
//    }
    
    func ValidationofHeight(view : NSLayoutConstraint,val : Int ) -> Void
    {
        view.constant = CGFloat(val)
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField == txtAccountNumber
        {
            self.viewBackAccountNumber.viewTextFieldPrimaryBorder()
            
            self.viewBackReAccountNumber.viewTextFieldActiveBorder()
            self.viewBackIFSCCode.viewTextFieldActiveBorder()
            self.viewBackBankName.viewTextFieldActiveBorder()
            self.viewBackBeneficiaryName.viewTextFieldActiveBorder()
            self.viewBackBankBranch.viewTextFieldActiveBorder()
            self.ValidationofHeight(view: viewAccntHeightConst, val: 0)
        }
        else if textField == txtReAccountNumber
        {
            self.viewBackAccountNumber.viewTextFieldActiveBorder()
            self.viewBackReAccountNumber.viewTextFieldPrimaryBorder()
            self.viewBackIFSCCode.viewTextFieldActiveBorder()
            self.viewBackBankName.viewTextFieldActiveBorder()
            self.viewBackBeneficiaryName.viewTextFieldActiveBorder()
            self.viewBackBankBranch.viewTextFieldActiveBorder()
            self.ValidationofHeight(view: viewReConfAccntHeightConst, val: 0)
        }
        else if textField == txtIFSCCode {
            
            self.viewBackAccountNumber.viewTextFieldActiveBorder()
            self.viewBackReAccountNumber.viewTextFieldActiveBorder()
            self.viewBackIFSCCode.viewTextFieldPrimaryBorder()
            self.viewBackBankName.viewTextFieldActiveBorder()
            self.viewBackBeneficiaryName.viewTextFieldActiveBorder()
            self.viewBackBankBranch.viewTextFieldActiveBorder()
            self.ValidationofHeight(view: viewIFSCHeightConst, val: 0)
        }
        else if textField == txtBankName
        {
            
            self.viewBackAccountNumber.viewTextFieldActiveBorder()
            self.viewBackReAccountNumber.viewTextFieldActiveBorder()
            self.viewBackIFSCCode.viewTextFieldActiveBorder()
            self.viewBackBankName.viewTextFieldPrimaryBorder()
            self.viewBackBeneficiaryName.viewTextFieldActiveBorder()
            self.viewBackBankBranch.viewTextFieldActiveBorder()
            self.ValidationofHeight(view: viewBankNameHeightConst, val: 0)
        }
        else if textField == txtBeneficiaryName {
            
            self.viewBackAccountNumber.viewTextFieldActiveBorder()
            self.viewBackReAccountNumber.viewTextFieldActiveBorder()
            self.viewBackIFSCCode.viewTextFieldActiveBorder()
            self.viewBackBankName.viewTextFieldActiveBorder()
            self.viewBackBeneficiaryName.viewTextFieldPrimaryBorder()
            self.viewBackBankBranch.viewTextFieldActiveBorder()
            self.ValidationofHeight(view: viewBeneficiaryHeightConst, val: 0)
        }
        else if textField == txtBankBranch
        {
            
            self.viewBackAccountNumber.viewTextFieldActiveBorder()
            self.viewBackReAccountNumber.viewTextFieldActiveBorder()
            self.viewBackIFSCCode.viewTextFieldActiveBorder()
            self.viewBackBankName.viewTextFieldActiveBorder()
            self.viewBackBeneficiaryName.viewTextFieldActiveBorder()
            self.viewBackBankBranch.viewTextFieldPrimaryBorder()
            self.ValidationofHeight(view: ViewBankBranchHeightConst, val: 0)
        }
        else if textField == txtNote
        {
            
            self.viewBackAccountNumber.viewTextFieldActiveBorder()
            self.viewBackReAccountNumber.viewTextFieldActiveBorder()
            self.viewBackIFSCCode.viewTextFieldActiveBorder()
            self.viewBackBankName.viewTextFieldActiveBorder()
            self.viewBackBeneficiaryName.viewTextFieldActiveBorder()
            self.viewBackBankBranch.viewTextFieldActiveBorder()
            self.viewBackNote.viewTextFieldPrimaryBorder()
            self.ValidationofHeight(view: viewNoteHeightConst, val: 0)
           
        }
        
      /*  if textField == txtBeneficiaryName
        {
            
            let toast = Toast(text: "Please enter the name as per your bank details.", delay: 0.0, duration: Delay.long)
            toast.show()
            
        }*/
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
//        if textField == txtReAccountNumber {
//
//            if txtAccountNumber.text != txtReAccountNumber.text {
//                let toast = Toast(text: "Account number does not match.", delay: 0.0, duration: Delay.long)
//                toast.show()
//            }
//        }
    }
    
    
}

// ****************************************** //
// MARK:- Confirm Bank Details Delegate
// ****************************************** //
extension WithdrawMoneyVC: withdrawConfirmDelegateProtocol
{
    
    func withdrawConfirm()
    {
        print("Confirm Details")
        
        self.refundRequestAPICall()
    }
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension WithdrawMoneyVC {
    
    func refundRequestAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.refundRequestAPICall(dictionary: ["refundType": "NEFT", "bankACNo": "\(txtAccountNumber.text!)", "ifscCode":"\(txtIFSCCode.text!)", "userbankName":"\(txtBankName.text!)", "userbankACName":"\(txtBeneficiaryName.text!)", "bankBranch":"\(txtBankBranch.text!)", "note":"\(txtNote.text!)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicRefundData = response["data"] as! [String: Any]
                print(dicRefundData)
                self.delegate?.withdrawDataSend(strMsg: dicRefundData["received_request"] as! String,strHideView : false)
                self.navigationController?.popViewController(animated: true)
                
//                let strMessage = dicRefundData["balance_transfer"] as! String
                
               /* AlertView.instance.showAlert(message: "\(dicRefundData["balance_transfer"] as! String)", image: "IC_ErrorIcon", alertType: .success)
                AlertView.instance.ActionOk = {
                    print("Work")
                    self.navigationController?.popViewController(animated: true)
                }
                */
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



