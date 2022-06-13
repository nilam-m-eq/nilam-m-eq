//
//  TransactionModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

struct TransactionSomeData {
    
    let amount_refund: String?
    let balance2: String?
    let buy_subscription: String?
    let credit: String?
    let credit2: String?
    let credit_added: String?
    let cycle_charge: String?
    let idTxn: String?
    let money_added_wallet: String?
    let note: String?
    let operatorName: String?
    let payment_method: String?
    let rideID: String?
    let terminalName: String?
    let title: String?
    let total_amount: String?
    let txnDate: String?
    let txnName: String?
    let txnTime: String?
    let wallet_amount: String?
    let withdraw_account_no: String?
    let icon : String?
    
}



typealias TransactionModelBlock = (_ success:Bool,_ status:String) -> Void
class TransactionModel: NSObject {
    
    var dataArr: Array<TransactionSomeData> = []
    
    func getTransactionData(arrTrans: [AnyObject], block: TransactionModelBlock) {
        
        for dic in arrTrans {
            
            let amount_refund = dic["amount_refund"]
            let balance2 = dic["balance2"]
            let buy_subscription = dic["buy_subscription"]
            let credit = dic["credit"]
            let credit2 = dic["credit2"]
            let credit_added = dic["credit_added"]
            let cycle_charge = dic["cycle_charge"]
            let idTxn = dic["idTxn"]
            let money_added_wallet = dic["money_added_wallet"]
            let note = dic["note"]
            let operatorName = dic["operatorName"]
            let payment_method = dic["payment_method"]
            let rideID = dic["rideID"]
            let terminalName = dic["terminalName"]
            let title = dic["title"]
            let total_amount = dic["total_amount"]
            let txnDate = dic["txnDate"]
            let txnName = dic["txnName"]
            let txnTime = dic["txnTime"]
            let wallet_amount = dic["wallet_amount"]
            let withdraw_account_no = dic["withdraw_account_no"]
            var icon = String()
            
            //IC_Credit_Cycle
//            /IC_Credit_Timer
            //IC_Credit_Transaction
            if buy_subscription as! String == "true" {
                icon = "IC_Credit_Timer"
            }
            if money_added_wallet as! String == "true" || credit_added as! String == "true" || money_added_wallet as! String == "false" {
                icon = "IC_Credit_Transaction"
            }
            if cycle_charge as! String == "true" {
                icon = "IC_Credit_Cycle"
            }
            
            let model = TransactionSomeData(amount_refund: (amount_refund as! String), balance2: (balance2 as! String), buy_subscription: (buy_subscription as! String), credit: (credit as! String), credit2: (credit2 as! String), credit_added: (credit_added as! String), cycle_charge: (cycle_charge as! String), idTxn: (idTxn as! String), money_added_wallet: (money_added_wallet as! String), note: (note as! String), operatorName: (operatorName as! String), payment_method: (payment_method as! String), rideID: (rideID as! String), terminalName: (terminalName as! String), title: (title as! String), total_amount: (total_amount as! String), txnDate: (txnDate as! String), txnName: (txnName as! String), txnTime: (txnTime as! String), wallet_amount: (wallet_amount as! String), withdraw_account_no: (withdraw_account_no as! String), icon: icon)
            dataArr.append(model)
            
        }
        block(true, "success")
    }
    

}






