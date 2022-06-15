//
//  SelectBikeVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit
import Toaster
import Foundation


class SelectBikeVC: CommonViewController
{
    var delegate: SetindexForTopScrollTable? = nil
    
    @IBOutlet var viewCycleNotFound: UIView!
    @IBOutlet var lbCycleNotFound: UILabel!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackSearch: UIView!
    @IBOutlet weak var tblViewSelectBike: UITableView!
    @IBOutlet var collectViewCategory: UICollectionView!
    @IBOutlet var txtSearch: UITextField!
    
    var strStationID = String()
    
    var arrCategory = NSArray()
    var selectedCat : String = ""
    var selectedCatID = String()
    
    
    var arrCondition = NSArray()
    var arrAllCycleDet = NSArray()
    var arrSubscriptionDetail = NSArray()
    
    var index : Int!
    
    var selectedIndx = -1
    var thereIsCellTapped = false
    //var Arryaindex : NSArray()
    
    var strListCycleCheck: String!
    
    var arySetion = [Bool]()
    
    
    var SubcribedVc = BikeDetailSubscribeVC()
    var UnSubcribedVc = BikeDetailUnsubscribVC()
    
    var strSecuDepo : String!
    var strNote : String!
    
    override func viewDidLoad()
    {
        //print(index!)
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print(index!)
        self.setUIOnScreen()
        
        tblViewSelectBike.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        self.tblViewSelectBike.reloadData()
    }
    
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton)
    {
        let viewControllers = self.navigationController!.viewControllers
        print(index!)
        for aViewController in viewControllers
          {
              print(aViewController)
             if aViewController is HomeVC
             {
                let aVC = aViewController as! HomeVC
                 aVC.FromSelectBike = index
                 aVC.FromSelectCycleVal = true
                _ = self.navigationController?.popToViewController(aVC, animated: true)
             }
          }
        
       
      //  self.delegate?.SetBackTableIndex(RowVal: index)
        
       /* let home = HomeVC()
        home.FromSelectBike = index
        print(home.FromSelectBike!)
        self.navigationController?.popViewController(animated: true)*/
    }
    
    @IBAction func ActionSearch(_ sender: UIButton) {
        
        self.txtSearch.resignFirstResponder()
        self.selectCycleAPICall()
    }
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //


extension SelectBikeVC : MyDataSendingDelegateProtocol
{
    func RemoveViewController(myviewControlle: String)
    {
        if myviewControlle == "Unscribed"
        {
            UnSubcribedVc.willMove(toParent: nil)
            UnSubcribedVc.view.removeFromSuperview()
            UnSubcribedVc.removeFromParent()
        }
        else
        {
         
        }
    }
    
}
extension SelectBikeVC : MyDataSendingDelegateProtocolSubscribed
{
    func RemoveViewControllerDta(myviewControlle: String)
    {
        if myviewControlle == "Subscribed"
        {
            SubcribedVc.willMove(toParent: nil)
            SubcribedVc.view.removeFromSuperview()
            SubcribedVc.removeFromParent()
        }
        else
        {
            
        }
    }
}
extension SelectBikeVC {
    
    func setUIOnScreen() {
        
        viewCycleNotFound.isHidden = true
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackSearch.shadowZ100(frame: viewBackSearch.frame)
        
        self.selectCycleAPICall()
    }
    
    func addUnsubscribDetailView(dicCycleData: [String: Any]) {
        
        /*
         var SubcribedVc = BikeDetailSubscribeVC()
         var UnSubcribedVc = BikeDetailUnsubscribVC()
         */
        UnSubcribedVc = self.storyboard?.instantiateViewController(withIdentifier: "BikeDetailUnsubscribVC") as! BikeDetailUnsubscribVC
        UnSubcribedVc.delegate = self
        UnSubcribedVc.dicCycleData = dicCycleData
        UnSubcribedVc.strStationID = strStationID
        self.addChild(UnSubcribedVc)
        self.view.addSubview(UnSubcribedVc.view)
        UnSubcribedVc.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        UnSubcribedVc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    func addSubscribDetailView(dicCycleData: [String: Any], arrSubscriptionDetails: NSArray) {
        
        SubcribedVc = self.storyboard?.instantiateViewController(withIdentifier: "BikeDetailSubscribeVC") as! BikeDetailSubscribeVC
        SubcribedVc.delegate = self
        SubcribedVc.dicCycleData = dicCycleData
        SubcribedVc.arrSubscriptionDetail = arrSubscriptionDetail
        SubcribedVc.strTerminalID = strStationID
        SubcribedVc.strNote = strNote
        SubcribedVc.strSecurityDepoVal = strSecuDepo
        self.addChild(SubcribedVc)
        self.view.addSubview(SubcribedVc.view)
        SubcribedVc.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        SubcribedVc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
}

// ******************************************** //
// MARK:- UITableView Delegate & DataSource
// ******************************************** //
extension SelectBikeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrCondition.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if arySetion[section] == true
        {
            return (arrAllCycleDet[section] as! NSArray).count
        }
        else
        {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print((arrAllCycleDet[indexPath.section] as! NSArray).object(at: indexPath.row) as! [String: Any])
        
        print(strListCycleCheck!)
        
      
        let dicCycleData = (arrAllCycleDet[indexPath.section] as! NSArray).object(at: indexPath.row) as! [String: Any]
        
        print(dicCycleData)
        if let unwrappedName = dicCycleData["no_cycle"] {
            print("Your username is \(unwrappedName)")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectBikeNoDataCell") as! SelectBikeNoDataCell
            cell.lbNoData.text = dicCycleData["goodCycleErrorMsg"] as? String
            cell.viewNoDataBorder.roundCornersWithoutRect(corners: [UIRectCorner.bottomLeft,UIRectCorner.bottomRight], radius: 7.0)
           
            cell.selectionStyle = .none
            
            return cell
        }
        else
        {
            if (dicCycleData["isBlock"] as! String) == "false"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! SelectBikeTblCell
                cell.lblLockNumber.text = "\(dicCycleData["QRCode"] as! String)"
                cell.imgViewCycleIcon.image = UIImage(named: getDynamicCycleName(strCycleType: "\(dicCycleData["categoryName"] as! String)"))
             
                cell.selectionStyle = .none
                
                if  indexPath.row == (arrAllCycleDet[indexPath.section] as! NSArray).count - 1
                {
                    
                    cell.viewBackMain.clipsToBounds = true
                    cell.viewBackMain.layer.cornerRadius = 8
                    cell.viewBackMain.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
                   
                    cell.viewBottomGray.isHidden = true
                    cell.viewBottomGrayConstant.constant = 5
                    cell.viewBackMain.viewTextFieldShadowBorderView()
                  
                }
                else
                {
                    cell.viewBackMain.layer.cornerRadius = 0
                    cell.viewBottomGray.isHidden = false
                    cell.viewBottomGrayConstant.constant = 0
                    cell.viewBackMain.viewTextFieldShadowBorderViewNone()
                 
                }
               
                return cell
                
            }
            else
            {
                print(dicCycleData["QRCode"] as! String)
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SelectBikeBlockCycleCell") as! SelectBikeBlockCycleCell
                cell.lbLockNumber.text = "\(dicCycleData["QRCode"] as! String)"
                cell.imgCycle.image = UIImage(named: getDynamicCycleName(strCycleType: "\(dicCycleData["categoryName"] as! String)"))
           
                cell.selectionStyle = .none
                
                print((arrAllCycleDet[indexPath.section] as! NSArray).count - 1)
                print((arrAllCycleDet[indexPath.section] as! NSArray).count)
                if  indexPath.row == (arrAllCycleDet[indexPath.section] as! NSArray).count - 1
                {
                   
                    cell.viewMain.clipsToBounds = true
                    cell.viewMain.layer.cornerRadius = 8
                    cell.viewMain.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
                    
                    cell.viewBottomGray.isHidden = true
                    cell.viewBottomGrayConstant.constant = 5
                    cell.viewMain.viewTextFieldShadowBorderView()
                 
                }
                else
                {
                 
                    cell.viewMain.layer.cornerRadius = 0
                  
                    cell.viewBottomGray.isHidden = false
                    cell.viewBottomGrayConstant.constant = 0
                    cell.viewMain.viewTextFieldShadowBorderViewNone()
                  
                }
                
                return cell
                
            }
        }

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tblViewSelectBike.frame.size.width, height: 60))
        let cellView = tableView.dequeueReusableCell(withIdentifier: "header") as! SelectBikeTblHeaderCell
        cellView.frame = headerView.bounds
        print(arrCondition[section])
        cellView.lblTblHeaderName.text = "\(arrCondition[section] as! String)"
        
        if arrCondition[section] as! String == "Good Condition Bikes"
        {
            cellView.btnArrowExpand.tag = section
            cellView.imgLikeDislikeThumb.image = UIImage(named:"IC_Thumbup")
         
            cellView.viewSectionMainCorner.clipsToBounds = true
            cellView.viewSectionMainCorner.layer.cornerRadius = 8
            
            /*
             IC_TopArrow_Select
             IC_Forward_Select
             IC_Down_Select
             */
            if arySetion[section] == true
            {
                cellView.viewSectionMainCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                cellView.imgArrowImageChanged.image = UIImage(named: "IC_TopArrow_Select")
                
              //  cellView.btnArrowImageChange.setImage(UIImage(named: "IC_TopArrow_Select"), for: UIControl.State.normal)
               // cellView.viewSectionMainCorner.viewTextFieldShadowBorderView()
            }
            else
            {
                cellView.viewSectionMainCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
                cellView.imgArrowImageChanged.image = UIImage(named: "IC_Down_Select")
               // cellView.btnArrowImageChange.setImage(UIImage(named: "IC_Down_Select"), for: UIControl.State.normal)
            }
           
          
        }
        else
        {
        
            cellView.btnArrowExpand.tag = section
            cellView.imgLikeDislikeThumb.image = UIImage(named:"IC_DownGray")
       
            cellView.viewSectionMainCorner.clipsToBounds = true
            cellView.viewSectionMainCorner.layer.cornerRadius = 8
          
            if arySetion[section] == true
            {
                cellView.viewSectionMainCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                cellView.imgArrowImageChanged.image = UIImage(named: "IC_TopArrow_Select")
               // cellView.btnArrowImageChange.setImage(UIImage(named: "IC_TopArrow_Select"), for: UIControl.State.normal)
               
            }
            else
            {
                cellView.viewSectionMainCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
                cellView.imgArrowImageChanged.image = UIImage(named: "IC_Down_Select")
              //  cellView.btnArrowImageChange.setImage(UIImage(named: "IC_Down_Select"), for: UIControl.State.normal)
            }
           
        }
       
        cellView.btnArrowExpand.addTarget(self, action: #selector(SelectBikeVC.backAction(_sender:)), for: UIControl.Event.touchUpInside)
        headerView.addSubview(cellView)
        return headerView
    }
   
    @objc public func backAction(_sender: UIButton)
    {
       // let section = _sender.tag
        
        
        //IC_ExpandMoreGreen
        //IC_ArrowTop
        
        print(self.arySetion[_sender.tag])
        
        print("selected index",_sender.tag)
           if selectedIndx != _sender.tag
        {
               self.thereIsCellTapped = true
               self.selectedIndx = _sender.tag
           }
           else
        {
               // there is no cell selected anymore
               self.thereIsCellTapped = false
               self.selectedIndx = -1
           }
  
//        var i = 0
//        self.arySetion.forEach { status in
//            self.arySetion[i] = false
//            i += 1
//        }
      //  self.arySetion[_sender.tag] = true
        
       
        
        if self.arySetion[_sender.tag] == true
         {
            self.arySetion[_sender.tag] = false
            
            var i = 0
            self.arySetion.forEach { stat in
                
                if _sender.tag == i
                {
                  
                }
                else
                {
                    if self.arySetion[i] == true
                    {
                        self.arySetion[i] = false
                    }
                }
                i += 1
            }
        }
        else
        {
            self.arySetion[_sender.tag] = true
            
            var i = 0
            self.arySetion.forEach { stat in
                
                if _sender.tag == i
                {
                  
                }
                else
                {
                    if self.arySetion[i] == true
                    {
                        self.arySetion[i] = false
                    }
                }
                i += 1
            }
        }
        print(self.arySetion)
        UIView.transition(with: tblViewSelectBike,
                          duration: 0.40,
                          options: .transitionCrossDissolve,
                          animations: { self.tblViewSelectBike.reloadData() })
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
            return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let dicCycleData = (arrAllCycleDet[indexPath.section] as! NSArray).object(at: indexPath.row) as! [String: Any]
        print(arrCondition[indexPath.section])
        
        
        print(arrSubscriptionDetail)
        
        if let unwrappedName = dicCycleData["no_cycle"] {
            
        }
        else if "\(dicCycleData["isBlock"] as! String)" == "true" {
            
            print("Block True")
            print("Bicycle blocked for maintenance. Please unlock any other cycle.")
            AlertView.instance.showAlert(message: "\(dicCycleData["blockCycleMessage"] as! String)", image: "IC_Warning", alertType: .success)
        }
        else if "\(dicCycleData["isMalfunction"] as! String)" == "true"
        {
            
           
            let string2 = dicCycleData["MalfunctionIssue"] as! String
            let fullNameArr = string2.components(separatedBy:"<br>")
        
            var i = 0
            var concateStr : String!
            var FirstStr : String!
            var concat : String? = ""
            var valu: String? = nil
            
            fullNameArr.forEach { value in
                
                if i == 0
                {
                    FirstStr = fullNameArr[i]
                }
                else
                {
                    valu = fullNameArr[i]
                    
                    if valu == ""
                    {
                        
                    }
                    else
                    {
                        concat = concat! + valu!
                    }
                    
                    concateStr =  concat
                    
                }
                i += 1
            }
            let strMsg = FirstStr.htmlToString
            
            MalFunction.instance.showMalFunction(title: "Reconfirmation", message: strMsg, imgName: "IC_ThumpsDownBig", strFirstBtn: "PROCEED ANYWAY", strSecondBtn: "SELECT ANOTHER BIKE", strIssueName: concateStr)
            
            MalFunction.instance.ActionProceed =
            {
                
                if self.arrSubscriptionDetail.count == 0
                {
                    
                    self.addUnsubscribDetailView(dicCycleData: dicCycleData)
                }
                else {
                    self.addSubscribDetailView(dicCycleData: dicCycleData, arrSubscriptionDetails: self.arrSubscriptionDetail)
                }
            }
        }
        else
        {
            if self.arrSubscriptionDetail.count == 0
            {
                self.addUnsubscribDetailView(dicCycleData: dicCycleData)
            }
            else
            {
                self.addSubscribDetailView(dicCycleData: dicCycleData, arrSubscriptionDetails: self.arrSubscriptionDetail)
            }
        }
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableView.automaticDimension
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
      //  return UITableView.automaticDimension
       let dicCycleData = (arrAllCycleDet[indexPath.section] as! NSArray).object(at: indexPath.row) as! [String: Any]
        
        if let unwrappedName = dicCycleData["no_cycle"]
        {
            print("Your username is \(unwrappedName)")
          return UITableView.automaticDimension
        }
        else
        {
            return UITableView.automaticDimension
        }
      // return 0
    }
    
}

// *********************************************** //
// MARK:- UICollectionView Delegate & DataSource
// *********************************************** //
extension SelectBikeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath as IndexPath) as! SelectBikeCollectCell
        let dicCat = arrCategory[indexPath.item] as! [String: Any]
        
        cell.lblCategoryName.text = "\(dicCat["cycleType"] as! String)"
        
        cell.viewMainBack.layer.cornerRadius = cell.viewMainBack.frame.height / 2
        cell.viewMainBack.layer.shadowColor = UIColor.lightGray.cgColor
        cell.viewMainBack.layer.shadowOpacity = 0.5
        cell.viewMainBack.layer.shadowOffset = CGSize(width: -1, height: 3)
        cell.viewMainBack.layer.shadowRadius = 1
        
        if selectedCat == "\(indexPath.item)" {
            
            cell.viewMainBack.backgroundColor = UIColor(named: Color_Primary)
            cell.lblCategoryName.textColor = UIColor(named: Color_N_Light00)
        }
        else {
            cell.viewMainBack.backgroundColor = UIColor.white
            cell.lblCategoryName.textColor = UIColor(named: Color_N_Dark900)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dicCat = arrCategory[indexPath.item] as! [String: Any]
        print(dicCat)
        
        selectedCatID = "\(dicCat["id"] as! Int)"
        
        selectedCat = "\(indexPath.item)"
        self.collectViewCategory.reloadData()
        self.selectCycleCategoryWiseAPICall()
    }
    
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension SelectBikeVC {
    
    func selectCycleAPICall() {
        
        print(strStationID)
        print(selectedCat)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.selectCycleAPICall(dictionary: ["idStations": strStationID, "cyclelockQRcode": "\(txtSearch.text!)", "cyclecategoryID":"\(selectedCat)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            
            print(response)
            
            // balanceNote = "Note: Your security deposit is less than the required amount.";
            //securityDeposit
            
            if response["is_error"] as! String == "false"
            {
                let CovertID: String!
                
                viewCycleNotFound.isHidden = true
                
                let dicSelectCycleData = response["data"] as! [String: Any]
                
                if let SecureDepo = dicSelectCycleData["securityDeposit"]
                {
                    if let StrStationID = dicSelectCycleData["securityDeposit"] as? String
                    {
                        CovertID = StrStationID
                    }
                    else
                    {
                        let StrStationIDCovert = dicSelectCycleData["securityDeposit"]
                        CovertID  = "\(StrStationIDCovert as! Int)"
                    }
                    strSecuDepo = CovertID
                }
                if let Strnote = dicSelectCycleData["balanceNote"]
                {
                    strNote = dicSelectCycleData["balanceNote"] as! String
                }
//                if strStationID == dicSelectCycleData["idStations"] as! String
//                {
//                    self.arrCategory = dicSelectCycleData["cycleCategory"] as! NSArray
//                    self.arrCondition = dicSelectCycleData["cycleConditionList"] as! NSArray
//                    self.arrAllCycleDet = dicSelectCycleData["allcycleDetails"] as! NSArray
//
//                    print(dicSelectCycleData)
//                    self.arrSubscriptionDetail = dicSelectCycleData["subscriptionDetails"] as! NSArray
//                    self.selectedCat = "0"
//
//                    print(self.strStationID)
//                    print(self.arrCategory)
//                    print(self.arrCondition)
//                    print(self.arrAllCycleDet)
//
//                    self.collectViewCategory.reloadData()
//                    self.tblViewSelectBike.reloadData()
//                }
//                else
//                {
                    self.arrCategory = dicSelectCycleData["cycleCategory"] as! NSArray
                    self.arrCondition = dicSelectCycleData["cycleConditionList"] as! NSArray
                    self.arrAllCycleDet = dicSelectCycleData["allcycleDetails"] as! NSArray
                
                //cycleConditionList
//                /cycleCategory
                //allcycleDetails
                
                if self.arySetion.count > 0
                {
                    self.arySetion.removeAll()
                }
               
                self.arrCondition.forEach { value in
                    print(value)
                    self.arySetion.append(false)
                }
              
                    
                
                    print(dicSelectCycleData)
                    self.arrSubscriptionDetail = dicSelectCycleData["subscriptionDetails"] as! NSArray
                    self.selectedCat = "0"
                    strListCycleCheck = response["message"] as? String
                    print(self.strStationID)
                
                    print(self.arrCategory)
                    print(self.arrCondition)
                    print(self.arrAllCycleDet)
                    
                   
                    self.arySetion[0] = true
                    self.tblViewSelectBike.reloadData()
                    self.collectViewCategory.reloadData()
        
                let dicCycleData = (arrAllCycleDet[0] as! NSArray).object(at: 0) as! [String: Any]
                
               // let dicCycleData = (arrAllCycleDet[0] as! NSArray).object(at: 0) as! [String: Any]
                
                if let unwrappedName = dicCycleData["no_cycle"]
                {
                    print("Your username is \(unwrappedName)")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.02)
                    {
                      //  self.arySetion[0] = true
                        self.tblViewSelectBike.reloadData()
                    }
                }
                else
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                    {
                      //  self.arySetion[0] = true
                        self.tblViewSelectBike.reloadData()
                    }
                }
                
               
                
                print("ARY",self.arySetion)
                   
//                }
//
                
                /*
                 let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                 */
            }
            else {
                
                if response["error_code"] as! String == "404" {
                    
                    viewCycleNotFound.isHidden = true
                    CommonClass.moveToLogOut(viewController: self)
                }
                else if response["error_code"] as! String == "403"
                {
                    self.view.bringSubviewToFront(viewCycleNotFound)
                    viewCycleNotFound.isHidden = false
                   // txtSearch.text
                    lbCycleNotFound.text = response["message"] as? String
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
    
    func selectCycleCategoryWiseAPICall() {
        
        /*
         selectedCatID = "\(dicCat["id"] as! Int)"
         
         selectedCat = "\(indexPath.item)"
         */
        print(strStationID)
        print(selectedCatID)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.selectCycleAPICall(dictionary: ["idStations": strStationID, "cyclecategoryID":selectedCatID]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                /*self.arrCategory = dicSelectCycleData["cycleCategory"] as! NSArray
                self.arrCondition = dicSelectCycleData["cycleConditionList"] as! NSArray
                self.arrAllCycleDet = dicSelectCycleData["allcycleDetails"] as! NSArray*/
                
                let dicSelectCycleData = response["data"] as! [String: Any]
                self.arrCondition = dicSelectCycleData["cycleConditionList"] as! NSArray
                self.arrAllCycleDet = dicSelectCycleData["allcycleDetails"] as! NSArray
                print(dicSelectCycleData)
                
                DispatchQueue.main.async {
                    
                    self.tblViewSelectBike.reloadData()
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





