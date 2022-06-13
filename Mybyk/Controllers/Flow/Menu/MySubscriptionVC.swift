//
//  MySubscriptionVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 24/12/21.
//

import UIKit
import Toaster

class MySubscriptionVC: CommonViewController {
    @IBOutlet var viewNavi: UIView!
    @IBOutlet weak var viewBackSearch: UIView!
    @IBOutlet weak var tblViewMySubscription: UITableView!
    @IBOutlet weak var viewNotFoundPreview: UIView!
    @IBOutlet weak var btnGetAride: UIButton!
    @IBOutlet var txtSearch: UITextField!
    
    
    let subscriptionViewModel = MySubscriptionViewModel()
    let subscriptionModel = MySubscriptionFetchModel()
    
    var intMySubscriptionPage = 1
    
    var searching:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
         rideModel.dataArr.removeAll()
         self.rideViewModel.rawCount = 0
         tblViewMyRide.reloadData()
         intRidePage = 1
         */
        subscriptionModel.dataArr.removeAll()
        self.subscriptionViewModel.rawCount = 0
        tblViewMySubscription.reloadData()
        intMySubscriptionPage = 1
        
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionGetARide(_ sender: UIButton) {
        
        
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //

extension MySubscriptionVC : UITextFieldDelegate
{
//    func textFieldShouldClear(_ textField: UITextField) -> Bool
//    {
//        subscriptionModel.dataArr = subscriptionModel.dataArrTmp
//        self.subscriptionViewModel.rawCount = (self.subscriptionModel.dataArr.count)
//
//        print("COUNT",subscriptionModel.dataArr.count)
//        print("COUNT TEMP",subscriptionModel.dataArrTmp.count)
//        tblViewMySubscription.reloadData()
//        return true
//    }
    @objc func textFieldDidChange(sender: UITextField)
    {
        subscriptionModel.dataSearchTempFilter = subscriptionModel.dataArr.filter({String(format: "%d",$0.transaction_id!).localizedCaseInsensitiveContains(txtSearch.text!)})
        
        //rideModel.dataArr.filter({(($0."\(rideID!)").localizedCaseInsensitiveContains(searchText))})
        print(subscriptionModel.dataArr)
        print("value AARAAAYY",subscriptionModel.dataSearchTempFilter)
          
    
        if txtSearch.text?.count == 0
        {
            subscriptionModel.dataArr = subscriptionModel.dataArrTmp
            self.subscriptionViewModel.rawCount = (self.subscriptionModel.dataArr.count)
            
            searching = false
            tblViewMySubscription.reloadData()
         
        }
        else
        {
            searching = true
            self.subscriptionViewModel.rawCount = (self.subscriptionModel.dataSearchTempFilter.count)
            
            print(self.subscriptionViewModel.rawCount)
            tblViewMySubscription.reloadData()
          
        }
//        tblViewMyRide.reloadData()
    }
    func setUIOnScreen()
    {
        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackSearch.shadowZ100(frame: viewBackSearch.frame)
        btnGetAride.layer.cornerRadius = 10.0
        
        tblViewMySubscription.delegate = subscriptionViewModel
        tblViewMySubscription.dataSource = subscriptionViewModel
        subscriptionViewModel.sectionCount = 1
        
        subscriptionViewModel.cellRender = { [self] indexPath, tableView in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSubscription") as! MySubscriptionTblCell
            
            if searching == false
            {
                cell.lblPlanName.text = subscriptionModel.dataArr[indexPath.row].type
                cell.lblSubsciptionAmount.text = String(format: "₹%@", subscriptionModel.dataArr[indexPath.row].subAmount!)
                //"₹\(subscriptionModel.dataArr[indexPath.row].subAmount)"
                
                if let id = subscriptionModel.dataArr[indexPath.row].transaction_id
                {
                    print(id)
                    if id == 0
                    {
                        cell.lblSubscriptionTransID.text = ""
                    }
                    else
                    {
                        cell.lblSubscriptionTransID.text = "\(id)"
                    }
                    
                    //"\(subscriptionModel.dataArr[indexPath.row].transaction_id ?? 0)"
                }
                
                cell.lblSubscriptionEndDate.text = subscriptionModel.dataArr[indexPath.row].end_date
                cell.lblSubscriptionStatus.setTitle(subscriptionModel.dataArr[indexPath.row].subscription_label, for: .normal)
                cell.lblSubscriptionStatus.backgroundColor = UIColor(named: subscriptionModel.dataArr[indexPath.row].statusBackClr!)
                cell.lblSubscriptionStatus.layer.cornerRadius = 3.0
                
                if indexPath.row == subscriptionModel.dataArr.count - 5 {
                    intMySubscriptionPage = intMySubscriptionPage + 1
                    self.getMySubscriptionListAPICall(page: "\(intMySubscriptionPage)")
                }
            }
            else
            {
                cell.lblPlanName.text = subscriptionModel.dataSearchTempFilter[indexPath.row].type
                cell.lblSubsciptionAmount.text = String(format: "₹%@", subscriptionModel.dataSearchTempFilter[indexPath.row].subAmount!)
                //"₹\(subscriptionModel.dataArr[indexPath.row].subAmount)"
                
                if let id = subscriptionModel.dataSearchTempFilter[indexPath.row].transaction_id
                {
                    print(id)
                    if id == 0
                    {
                        cell.lblSubscriptionTransID.text = ""
                    }
                    else
                    {
                        cell.lblSubscriptionTransID.text = "\(id)"
                    }
                    
                    //"\(subscriptionModel.dataArr[indexPath.row].transaction_id ?? 0)"
                }
                
                cell.lblSubscriptionEndDate.text = subscriptionModel.dataSearchTempFilter[indexPath.row].end_date
                cell.lblSubscriptionStatus.setTitle(subscriptionModel.dataSearchTempFilter[indexPath.row].subscription_label, for: .normal)
                cell.lblSubscriptionStatus.backgroundColor = UIColor(named: subscriptionModel.dataSearchTempFilter[indexPath.row].statusBackClr!)
                cell.lblSubscriptionStatus.layer.cornerRadius = 3.0
            }
           
            
            cell.selectionStyle = .none
            return cell
        }
        
        subscriptionViewModel.cellSlect = { [self] indexPath, tableView in
            
            
        }
        
        
        self.getMySubscriptionListAPICall(page: "\(intMySubscriptionPage)")
        
        
    }
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension MySubscriptionVC {
    
    func getMySubscriptionListAPICall(page: String) {
        
        if page == "1" {
            
            CommonClass.loadProgressHudCycling(viewController: self)
        }
        APIService.sharedInstance.getMySubscriptionListAPICall(dictionary: ["allSubscriptions": "1", "page": page]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicMySubscriptionData = response["data"] as! [String: Any]
                let arrSubscriptions = dicMySubscriptionData["subscriptions"] as! [AnyObject]
                
                if arrSubscriptions.count != 0 {
                    
                    self.viewNotFoundPreview.isHidden = true
                    
                    subscriptionModel.currencySymbol = dicMySubscriptionData["currency_symbol"] as! String
                    subscriptionModel.getData(arrRide: arrSubscriptions) { success, status in
                        self.subscriptionViewModel.rawCount = (self.subscriptionModel.dataArr.count)
                        self.tblViewMySubscription.reloadData()
                    }
                }
                else {
                    if page == "1" {
                        self.viewNotFoundPreview.isHidden = false
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




