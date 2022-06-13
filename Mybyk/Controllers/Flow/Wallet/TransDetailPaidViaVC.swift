//
//  TransDetailPaidViaVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

class TransDetailPaidViaVC: CommonViewController {
    @IBOutlet weak var viewBackDetail: UIView!
    @IBOutlet var lblTransactionID: UILabel!
    @IBOutlet var lblRideID: UILabel!
    @IBOutlet var lblCredit: UILabel!
    @IBOutlet var lblWallet: UILabel!
    @IBOutlet var lblTotalAmount: UILabel!
    
    var indexPath = IndexPath()
    var transModel = TransactionModel()
    
    
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
    @IBAction func ActionClose(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.0)
            self.view.frame.origin.y = self.view.frame.height
            
        } completion: { status in
            
            self.view.removeFromSuperview()
            
        }
    }
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension TransDetailPaidViaVC {
    
    func setUIOnScreen() {
        
        viewBackDetail.roundCorners(corners: [.topLeft, .topRight], radius: 8.0, rect: self.view.frame)
        
        print(transModel.dataArr[indexPath.row])
        lblTransactionID.text = transModel.dataArr[indexPath.row].idTxn
        lblRideID.text = transModel.dataArr[indexPath.row].rideID
        lblCredit.text = transModel.dataArr[indexPath.row].credit
        lblWallet.text = transModel.dataArr[indexPath.row].wallet_amount
        lblTotalAmount.text = "₹ \(transModel.dataArr[indexPath.row].total_amount ?? "")"
        //String(format: "₹ %@",transModel.dataArr[indexPath.row].total_amount)
        //transModel.dataArr[indexPath.row].total_amount
    }
    
}
