//
//  TransactionsVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit
import Toaster

class TransactionsVC: CommonViewController {
    @IBOutlet weak var tblViewTransaction: UITableView!
    @IBOutlet weak var viewNavi: UIView!
    
    let transViewModel = TransactionViewModel()
    let transModel = TransactionModel()
    
    var intTransPage = 1
    var dicTransParam = [String:Any]()
    
    var currentcySymbl : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        transModel.dataArr.removeAll()
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension TransactionsVC {
    
    func setUIOnScreen()
    {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
        tblViewTransaction.delegate = transViewModel
        tblViewTransaction.dataSource = transViewModel
        transViewModel.sectionCount = 1
        
        /*
         when {
             data.buy_subscription == "true" ->
         {
                 holder.imgTransactions.setImageResource(R.drawable.ic_clock)
             }
             data.money_added_wallet == "true" || data.credit_added == "true" ->
         {
                 holder.imgTransactions.setImageResource(R.drawable.ic_wallet_active)
                 holder.txtSubCharge.setTextColor(
                     ContextCompat.getColor(
                         context,
                         R.color.colorPrimary
                     )
                 )
             }
             data.cycle_charge == "true" ->
         {
                 holder.imgTransactions.setImageResource(R.drawable.ic_cycle_plus)
             }
         }
         if buy_subscription = true { ic_clock }
         if money_added_wallet= true  || credit_added = true { ic_wallet_active}
         if cycle_charge = true  {ic_cycle_plus}
         
         
         if buy_subscription as! String == "true" {
             icon = "IC_Credit_Timer"
         }
         else if money_added_wallet as! String == "true" || credit_added as! String == "true" {
             icon = "IC_Credit_Transaction"
         }
         else {
             icon = "IC_Credit_Cycle"
         }

         */
        transViewModel.cellRender = { [self] indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "transCell") as! TransactionTblCell
          //  print(transModel.dataArr)
         //   dump(transModel.dataArr)
            cell.lblTitle.text = transModel.dataArr[indexPath.row].title
            cell.lblDate.text = transModel.dataArr[indexPath.row].txnDate
            cell.lblAmount.text = String(format: "%@ %@", currentcySymbl,transModel.dataArr[indexPath.row].total_amount!)
            //"\(currentcySymbl )" + transModel.dataArr[indexPath.row].total_amount!
            print(transModel.dataArr[indexPath.row].icon!)
            print("WALLET",transModel.dataArr[indexPath.row].money_added_wallet!)
            cell.imgViewIcon.image = UIImage(named: transModel.dataArr[indexPath.row].icon!)
            
            /*
             data.buy_subscription == "true" -> {
                 holder.imgTransactions.setImageResource(R.drawable.ic_clock)
             }
             --------------------------------------------------------------------------------------------------------------------------------------
             data.money_added_wallet == "true" || data.credit_added == "true" -> {
                 holder.imgTransactions.setImageResource(R.drawable.ic_wallet_active)
                 holder.txtSubCharge.setTextColor(
                     ContextCompat.getColor(
                         context,
                         R.color.colorPrimary
                     )
                 )
             }

             -------------------------------------------------------

             data.cycle_charge == "true" -> {
                 holder.imgTransactions.setImageResource(R.drawable.ic_cycle_plus)
             }
             */
            //transModel.dataArr[indexPath.row].cycle_charge! == "true"
            
            if transModel.dataArr[indexPath.row].buy_subscription! == "true"
            {
                //cell.imgViewIcon.image = UIImage(named: "IC_Credit_Timer")
                cell.lblAmount.textColor = UIColor(named: Color_N_Dark500)
            }
            else if transModel.dataArr[indexPath.row].money_added_wallet! == "true" || transModel.dataArr[indexPath.row].credit_added! == "true"
            {
                //cell.imgViewIcon.image = UIImage(named: "IC_Credit_Transaction")
                cell.lblAmount.textColor = UIColor(named: Color_Primary)
            }
            else
            {
                //cell.imgViewIcon.image = UIImage(named: "IC_Credit_Cycle")
                cell.lblAmount.textColor = UIColor(named: Color_N_Dark500)
            }
            
          /*  if transModel.dataArr[indexPath.row].money_added_wallet! == "true" || transModel.dataArr[indexPath.row].credit_added! == "true"
            {
                cell.lblAmount.textColor = UIColor(named: Color_Primary)
            }
            else
            {
                cell.lblAmount.textColor = UIColor(named: Color_N_Dark500)
            }
            */
            
            if indexPath.row == transModel.dataArr.count - 5
            {
                intTransPage = intTransPage + 1
                self.loadTransactionListAPICall(dicParam: dicTransParam)
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        transViewModel.cellSelect = { [self] indexPath, tableView in
            
            if transModel.dataArr[indexPath.row].buy_subscription! == "true" || transModel.dataArr[indexPath.row].cycle_charge == "true" || transModel.dataArr[indexPath.row].money_added_wallet == "true" || transModel.dataArr[indexPath.row].amount_refund == "true" {
                
                if transModel.dataArr[indexPath.row].cycle_charge! == "true" || transModel.dataArr[indexPath.row].buy_subscription! == "true" {
                    self.addTransactionDetailPaidViaView(indexPath: indexPath)
                }
                else if transModel.dataArr[indexPath.row].amount_refund! == "true" {
                    self.addTransactionDetailWithdrawView(indexPath: indexPath)
                }
                else if transModel.dataArr[indexPath.row].money_added_wallet! == "true" {
                    self.addTransactionDetailMoneyAddedView(indexPath: indexPath)
                }
                else {
                    self.addTransactionDetailPaidViaView(indexPath: indexPath)
                }
                
            }
            
        }
        
        self.loadTransactionListAPICall(dicParam: ["page": intTransPage, "final_balance": 0, "final_credit": 0, "last_date":"", "last_credit":0, "last_balance":0])
        
    }
    
    func addTransactionDetailWithdrawView(indexPath: IndexPath) {
        
        let detWithdraw = self.storyboard?.instantiateViewController(withIdentifier: "TransDetailWithdrawVC") as! TransDetailWithdrawVC
        detWithdraw.indexPath = indexPath
        detWithdraw.transModel = transModel
        self.addChild(detWithdraw)
        self.view.addSubview(detWithdraw.view)
        detWithdraw.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        detWithdraw.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    func addTransactionDetailPaidViaView(indexPath: IndexPath) {
        
        let detPaidVia = self.storyboard?.instantiateViewController(withIdentifier: "TransDetailPaidViaVC") as! TransDetailPaidViaVC
        detPaidVia.indexPath = indexPath
        detPaidVia.transModel = transModel
        self.addChild(detPaidVia)
        self.view.addSubview(detPaidVia.view)
        detPaidVia.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        detPaidVia.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    func addTransactionDetailMoneyAddedView(indexPath: IndexPath) {
        
        let detMoneyAdded = self.storyboard?.instantiateViewController(withIdentifier: "TransDetailMoneyAddedVC") as! TransDetailMoneyAddedVC
        detMoneyAdded.indexPath = indexPath
        detMoneyAdded.transModel = transModel
        self.addChild(detMoneyAdded)
        self.view.addSubview(detMoneyAdded.view)
        detMoneyAdded.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        detMoneyAdded.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension TransactionsVC {
    
    func loadTransactionListAPICall(dicParam: [String: Any]) {
        
        if intTransPage == 1 {
            
            CommonClass.loadProgressHudCycling(viewController: self)
        }
        
        APIService.sharedInstance.loadTransactionListAPICall(dictionary: dicParam) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        //    print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicTransactionData = response["data"] as! [String: Any]
                let arrTrans = dicTransactionData["financial_txn_details"] as! [AnyObject]
                currentcySymbl = dicTransactionData["currency_symbol"] as? String
                
                if arrTrans.count != 0 {
                    
                    intTransPage = intTransPage + 1
                    self.dicTransParam = ["page": intTransPage, "final_balance": dicTransactionData["final_balance"] as! Int, "final_credit": dicTransactionData["final_credit"] as! Int, "last_date":"\(dicTransactionData["last_date"] as! String)", "last_credit":"\(dicTransactionData["last_credit"] as! Int)", "last_balance":dicTransactionData["last_balance"] as! Int]
                    
                    transModel.getTransactionData(arrTrans: arrTrans) { status, success in
                        
                        self.transViewModel.rawCount = (self.transModel.dataArr.count)
                        DispatchQueue.main.async {
                            self.tblViewTransaction.reloadData()
                        }
                         
                    }
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







