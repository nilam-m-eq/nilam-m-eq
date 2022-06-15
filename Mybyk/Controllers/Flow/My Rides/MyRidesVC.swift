//
//  MyRidesVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 26/06/21.
//

import UIKit
import Toaster

class MyRidesVC: CommonViewController
{
    @IBOutlet weak var btnNoRideFind: UIButton!
    @IBOutlet weak var viewNoRideData: UIView!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackSearch: UIView!
    @IBOutlet weak var tblViewMyRide: UITableView!
    
    @IBOutlet var txtSearch: UITextField!
    let rideViewModel = MyRideViewModel()
    let rideModel = MyRideFetchModel()
    
    var intRidePage = 1
    var searching:Bool = false
    var ObjTabbar = TabBarVC()
    var arrTmpAllRides = [AnyObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    //    self.tabBarController?.tabBar.isHidden = false
        
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(ReloadView(_:)),
                         name: NSNotification.Name("ReloadMyRideVc"),object: nil)
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       // ObjTabbar.delegateTabbar = self
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
        super.viewWillAppear(true)
        
        //self.tabBarController?.tabBar.isHidden = false
        rideModel.dataArr.removeAll()
        self.rideViewModel.rawCount = 0
        tblViewMyRide.reloadData()
        intRidePage = 1
        self.setUIOnScreen()
    }
    
    // ********** All textfield delegate ********** //
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        rideModel.dataArr = rideModel.dataArrTmp
        tblViewMyRide.reloadData()
        return true
    }
    @objc func ReloadView(_ notification: Notification)
    {
        self.viewDidLoad()
        self.viewWillAppear(true)
    }
    //MARK: - button action
    
    @IBAction func btnNoRideFindClicked(_ sender: Any)
    {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    deinit {
//      NotificationCenter.default
//       .removeObserver(self, name:  NSNotification.Name("ReloadMyRideVc"), object: nil)
//
//    }
    /*public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
      //input text
      let searchText  = textField.text! + string
     //add matching text to arrya
        //rideModel.dataArr[indexPath.row].duration
        //rideModel.dataArr[indexPath.row].rideID
        
      //  let varSearch = rideModel.dataArr.filter({(($0."\(rideID!)").localizedCaseInsensitiveContains(searchText))})
      //  print("value",varSearch)
        
        print("SEARCH",searchText)
        let varSearch = rideModel.dataArr.filter({$0.rideID == Int(searchText)})
        //rideModel.dataArr.filter({(($0."\(rideID!)").localizedCaseInsensitiveContains(searchText))})
          print("value AARAAAYY",varSearch)
          
       /* if varSearch.count == 0
        {
            rideModel.dataArr = varSearch
        }
        else
        {
            rideModel.dataArr = rideModel.dataArrTmp
        }*/
        
        if searchText.count == 0
        {
            rideViewModel.rowSearch = false
            rideModel.dataArr = rideModel.dataArrTmp
        }
        else
        {
            if varSearch.count == 0
            {
                rideViewModel.rowSearch = true
               // rideModel.dataArr = varSearch
            }
            else
            {
                rideViewModel.rowSearch = false
                rideModel.dataArr = varSearch
            }
          
        }
        tblViewMyRide.reloadData()
        //rideModel.dataArr.filter({ $0.rideID as! String)
   /*   searchArrRes = self.originalArr.filter({(($0["name"] as! String).localizedCaseInsensitiveContains(searchText))})

     if(searchArrRes.count == 0){
       searching = false
     }else{
       searching = true
    }
     self.tableView.reloadData();*/

     return true
   }*/

}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //

extension MyRidesVC : CustomTabBarControllerDelegate
{
    
    func onTabSelected(isTheSame: Bool) {
        print("Tab1ViewController onTabSelected")
        //do something
    }
}
extension MyRidesVC : UITextFieldDelegate{
    
    @objc func textFieldDidChange(sender: UITextField)
    {
        print("SEARCH",txtSearch.text!)
       // let varSearch = rideModel.dataArr.filter({$0.rideID == Int(txtSearch.text!)})
        
        rideModel.dataSearchTempFilter = rideModel.dataArr.filter({String(format: "%d",$0.rideID!).localizedCaseInsensitiveContains(txtSearch.text!)})
        
        //rideModel.dataArr.filter({(($0."\(rideID!)").localizedCaseInsensitiveContains(searchText))})
        print(rideModel.dataArr)
        print("value AARAAAYY",rideModel.dataSearchTempFilter)
          
       /* if varSearch.count == 0
        {
            rideModel.dataArr = varSearch
        }
        else
        {
            rideModel.dataArr = rideModel.dataArrTmp
        }*/
        
        if txtSearch.text?.count == 0
        {
            searching = false
            tblViewMyRide.reloadData()
         
        }
        else
        {
            searching = true
            self.rideViewModel.rawCount = (self.rideModel.dataSearchTempFilter.count)
            
            print(self.rideViewModel.rawCount)
            tblViewMyRide.reloadData()
          
        }
//        tblViewMyRide.reloadData()
    }
    func setUIOnScreen() {
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)

        viewNoRideData.isHidden = true
        
        btnNoRideFind.layer.cornerRadius = 4.0

        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackSearch.shadowZ100(frame: viewBackSearch.frame)
        
      //  viewBackSearch.layer.cornerRadius = 8.0
        
        tblViewMyRide.delegate = rideViewModel
        tblViewMyRide.dataSource = rideViewModel
        rideViewModel.sectionCount = 1
        
        rideViewModel.cellRender = { [self] indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellRide") as! MyRidesTblCell
            
          //  viewTextFieldShadowBorder
            cell.viewBackMain.viewTextFieldShadowBorderView()
            
            if searching == false
            {
                print("COUNT",rideModel.dataArr.count)
                cell.lblRideID.text = "\(rideModel.dataArr[indexPath.row].rideID!)"
                
                print(rideModel.dataArr[indexPath.row])
                if rideModel.dataArr[indexPath.row].duration == "-"
                {
                    cell.lblRideDuration.text = ""
                    cell.lblbDuration.text = ""
                }
                else
                {
                    cell.lblRideDuration.text = rideModel.dataArr[indexPath.row].duration
                    cell.lblbDuration.text = "Duration"
                }
                cell.lblRideStatus.setTitle(rideModel.dataArr[indexPath.row].ride_status, for: .normal)
                
                cell.lblRideStatus.backgroundColor = UIColor(named: rideModel.dataArr[indexPath.row].statusBackClr!)
                cell.lblRideStatus.layer.cornerRadius = 4.0
                
                if rideModel.dataArr[indexPath.row].ride_status == "Completed"
                {
                    cell.lblRideAmount.text = "\(rideModel.currencySymbol) \(rideModel.dataArr[indexPath.row].charges!)"
                    cell.lblRideDate.text = rideModel.dataArr[indexPath.row].ride_end_date
                }
                else {
                    cell.lblRideAmount.text = ""
                    cell.lblRideDate.text = rideModel.dataArr[indexPath.row].ride_start_date
                }
                
                if indexPath.row == rideModel.dataArr.count - 5
                {
                        intRidePage = intRidePage + 1
                        self.getMyRideListAPICall(page: "\(intRidePage)")
                }
                
                
            }
            else
            {
                cell.lblRideID.text = "\(rideModel.dataSearchTempFilter[indexPath.row].rideID!)"
                
                print(rideModel.dataSearchTempFilter[indexPath.row])
                if rideModel.dataSearchTempFilter[indexPath.row].duration == "-"
                {
                    cell.lblRideDuration.text = ""
                    cell.lblbDuration.text = ""
                }
                else
                {
                    cell.lblRideDuration.text = rideModel.dataSearchTempFilter[indexPath.row].duration
                    cell.lblbDuration.text = "Duration"
                }
                cell.lblRideStatus.setTitle(rideModel.dataSearchTempFilter[indexPath.row].ride_status, for: .normal)
                
                cell.lblRideStatus.backgroundColor = UIColor(named: rideModel.dataSearchTempFilter[indexPath.row].statusBackClr!)
                cell.lblRideStatus.layer.cornerRadius = 4.0
                
                if rideModel.dataSearchTempFilter[indexPath.row].ride_status == "Completed"
                {
                    cell.lblRideAmount.text = "\(rideModel.currencySymbol) \(rideModel.dataSearchTempFilter[indexPath.row].charges!)"
                    cell.lblRideDate.text = rideModel.dataSearchTempFilter[indexPath.row].ride_end_date
                }
                else {
                    cell.lblRideAmount.text = ""
                    cell.lblRideDate.text = rideModel.dataSearchTempFilter[indexPath.row].ride_start_date
                }
            
            

            }
           
            cell.selectionStyle = .none
            return cell
        }
        
        rideViewModel.cellSlect = { [self] indexPath, tableView in
            
            if rideModel.dataArr[indexPath.row].ride_status == "Completed" {
                
                print(arrTmpAllRides[indexPath.row] as! [String:Any])
                
                searching = false
                txtSearch.text = ""
                let detVC = self.storyboard?.instantiateViewController(withIdentifier: "RideDetailsVC") as! RideDetailsVC
                detVC.rideModel = rideModel
                detVC.indexPath = indexPath
                detVC.dataArrRideDetails = (arrTmpAllRides[indexPath.row] as! [String:Any])
                print(rideModel.dataArr[indexPath.row])
               //  =
                self.navigationController?.pushViewController(detVC, animated: false)
            }
            else {
                 
                let onGoing = self.storyboard?.instantiateViewController(withIdentifier: "OngoingRideDetails") as! OngoingRideDetails
                onGoing.isHome = false
                self.navigationController?.pushViewController(onGoing, animated: true)
            }
            
        }
        
        self.getMyRideListAPICall(page: "\(intRidePage)")
        
    }
    
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension MyRidesVC {
    
    func getMyRideListAPICall(page: String)
    {
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
        
        if page == "1" {
            
            CommonClass.loadProgressHudCycling(viewController: self)
        }
        APIService.sharedInstance.getMyRideListAPICall(dictionary: ["action": "allRides", "page": page]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            let dicMyRideData = response["data"] as! [String: Any]
            
            if response["is_error"] as! String == "false"
            {
                
                let arrCurrentRide = dicMyRideData["currentrides"] as! [AnyObject]
                let arrPastRide = dicMyRideData["pastrides"] as! [AnyObject]
                
               // if arrPastRide.count != 0
               // {
                    if let key = dicMyRideData["ble_key"] as? String
                   {
                        strBLEKey = key
                    }
                    else {
                        strBLEKey = "577N6k30"
                    }
                    
                    var arrAllRides = [AnyObject]()
                    if page == "1" {
                        
                        if arrCurrentRide.count != 0 {
                            arrAllRides.append(arrCurrentRide[0])
                        }
                        for obj in arrPastRide {
                            arrAllRides.append(obj)
                            arrTmpAllRides.append(obj)
                        }
                    }
                    else {
                        
                        for obj in arrPastRide {
                            arrAllRides.append(obj)
                            arrTmpAllRides.append(obj)
                        }
                    }
                   
                    rideModel.currencySymbol = dicMyRideData["currency_symbol"] as! String
                    rideModel.getData(arrRide: arrAllRides)
                    { success, status in
                        
                        if rideModel.dataArr.count == 0
                        {
                            viewNoRideData.isHidden = false
                            self.view.bringSubviewToFront(viewNoRideData)
                        }
                        else
                        {
                            self.rideViewModel.rawCount = (self.rideModel.dataArr.count)
                            self.tblViewMyRide.reloadData()
                        }
                        
                    }
                
               // }
               // else
                //{
                    
                  //  viewNoRideData.isHidden = false
                   // self.view.bringSubviewToFront(viewNoRideData)
                    
//                    if dicMyRideData["txnEnd"] as! String == "true"
//                    {
//
//                       // viewNoRideData.isHidden = false
//                      //  self.view.bringSubviewToFront(viewNoRideData)
//                    }
//                    else
//                    {
//
////                        viewNoRideData.isHidden = true
//                    }
               // }
            }
            else
            {
                
                if response["error_code"] as! String == "404"
                {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else
                {
                   // viewNoRideData.isHidden = true
                    
                    if dicMyRideData["txnEnd"] as! String == "true"
                    {
                       // viewNoRideData.isHidden = false
                      //  self.view.bringSubviewToFront(viewNoRideData)
                    }
                    else
                    {
                        viewNoRideData.isHidden = false
                        self.view.bringSubviewToFront(viewNoRideData)
                    }
                    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
}



