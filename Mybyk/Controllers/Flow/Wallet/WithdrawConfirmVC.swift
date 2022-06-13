//
//  WithdrawConfirmVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 24/11/21.
//

import UIKit

protocol withdrawConfirmDelegateProtocol
{
    func withdrawConfirm()
}

class WithdrawConfirmVC: CommonViewController {
    
    var delegate: withdrawConfirmDelegateProtocol? = nil
    
    @IBOutlet var viewBankDetailConfirm: UIView!
    @IBOutlet var lblAccountNumber: UILabel!
    @IBOutlet var lblIFSCCode: UILabel!
    @IBOutlet var lblBeneficiaryName: UILabel!
    @IBOutlet var lblBankName: UILabel!
    @IBOutlet var lblBranchName: UILabel!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = true
        
    }
    
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
    
    // ********** All Button Actions ********** //
    @IBAction func ActionCancel(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
    }
    
    @IBAction func ActionConfirm(_ sender: UIButton)
    {
        
        self.delegate?.withdrawConfirm()
        self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
        self.view.removeFromSuperview()
        
    }
    
    
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension WithdrawConfirmVC {
    
    func setUIOnScreen() {
        
        self.viewBankDetailConfirm.layer.cornerRadius = 10.0
        self.btnCancel.layer.cornerRadius = 10.0
        self.btnCancel.shadowSecondaryBtn(frame: self.btnCancel.frame)
        self.btnConfirm.layer.cornerRadius = 10.0
    }
    
}







