//
//  SubscriptionPlanVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit
import Toaster

class SubscriptionPlanVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet var viewNoteBack: UIView!
    @IBOutlet var lblNote: UILabel!
    @IBOutlet var tblViewSubscriptionPlan: UITableView!
    @IBOutlet weak var collectViewHeader: UICollectionView!
    @IBOutlet weak var viewBackCollectHeader: UIView!
    @IBOutlet weak var lblPlanMessage: UILabel!
    
    var dicCycleData = [String: Any]()
    var strStationID = String()
    var arrSubscriptionPlan = [Any]()
    var arrSubPlan = [Any]()
    var tmparrSubPlan = [Any]()
    var subDetail : SubscriptionDetailVC!
    
    var strSelectedPlanCategoryIndex: String = "0"
    var isSelectedVal = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = true
        
        print(dicCycleData)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        self.setUIOnScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewNoteBack.layer.shadowPath = UIBezierPath(rect: viewNoteBack.bounds).cgPath
        viewNoteBack.layer.shadowRadius = 5
        viewNoteBack.layer.shadowOffset = .zero
        viewNoteBack.layer.shadowOpacity = 0.3
        viewNoteBack.backgroundColor = UIColor.white
        
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //

extension SubscriptionPlanVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
        self.getSubscriptionPlanAPICall()
    }
    
    func subscriptionDetailView(indexPath: IndexPath)
    {
        print(arrSubPlan)
        
        let dicPlan = arrSubPlan[indexPath.item] as! [String: Any]
        
        subDetail = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionDetailVC") as? SubscriptionDetailVC
       
        subDetail.view.removeFromSuperview()
        subDetail.willMove(toParent: nil)
        subDetail.removeFromParent()
        
        subDetail.dicCycleData = dicCycleData
        subDetail.dicSubscriptionPlan = dicPlan
        subDetail.strStationID = strStationID
        
       // subDetail.view.frame = CGRect.zero
        
        self.addChild(subDetail)
        self.view.addSubview(subDetail.view)
        subDetail.didMove(toParent: self)
        
        let height = view.frame.height
        let width = view.frame.width
        
      //  subDetail.view.frame = CGRect.zero
        subDetail.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
       
    }
    
}

// ******************************************** //
// MARK:- UITableView Delegate & DataSource
// ******************************************** //
extension SubscriptionPlanVC: UITableViewDelegate, UITableViewDataSource {
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //
    ////        return arrSubscriptionPlan.count
    //
    //        return arrSubPlan.count
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        let dicPlan = arrSubscriptionPlan[section] as! [String: Any]
        //        let arrPlan = dicPlan["subscription_plan"] as! [Any]
        //
        //        return arrPlan.count
        
        return arrSubPlan.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.subscriptionDetailView(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! SubscriptionTblCell
        
        let dicPlan = arrSubPlan[indexPath.item] as! [String: Any]
          print(dicPlan)
        
        cell.lblTitle.text = "\(dicPlan["subscriptionNameCapital"] as! String)"
        
        let strData = "\((dicPlan["planTagLine"] as! String).htmlToString)"
        if strData == ""
        {
            cell.lblDescription.isHidden = true
        }
        else
        {
            cell.lblDescription.isHidden = false
            cell.lblDescription.text = "\((dicPlan["planTagLine"] as! String).htmlToString)"
        }
       
        cell.lblAmount.text = "₹\(dicPlan["subscriptionAmount"] as! String)"
        cell.lblDuration.text = "\(dicPlan["subscriptionDuration"] as! String)"
        
        
        if "\(dicPlan["planOriginalValue"] as! String)" == ""
        {
            cell.lblOldAmount.text = ""
            cell.lblOldAmount.isHidden = true
            //cell.lblAmount.text = "₹\(dicPlan["subscriptionAmount"] as! String)"
        }
        else
        {
            cell.lblOldAmount.isHidden = false
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "₹\(dicPlan["planOriginalValue"] as! String)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
            cell.lblOldAmount.attributedText = attributeString
        }
        
       
        
       // cell.lblTitle.sizeToFit()
       // cell.lblTitle.layoutIfNeeded()
        
        cell.selectionStyle = .none
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tblViewSubscriptionPlan.frame.size.width, height: 32))
    //        let cellView = tableView.dequeueReusableCell(withIdentifier: "header") as! SubscriptionPlanHeaderCell
    //        cellView.frame = headerView.bounds
    //
    //        let dicPlan = arrSubscriptionPlan[section] as! [String: Any]
    //        cellView.lblHeader.text = "\(dicPlan["subscriptionCategoryName"] as! String)"
    //        headerView.addSubview(cellView)
    //
    //        return headerView
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 0 {
            
            UIView.animate(withDuration: 0.4) {
                
                self.viewBackCollectHeader.backgroundColor = UIColor.white
                self.viewBackCollectHeader.shadowZ100(frame: self.viewBackCollectHeader.frame)
                self.viewNavi.layer.shadowOpacity = 0.0
            }
            
        }
        else {
            
            UIView.animate(withDuration: 0.4) {
                self.viewBackCollectHeader.backgroundColor = UIColor.clear
                self.viewBackCollectHeader.layer.shadowOpacity = 0.0
                self.viewNavi.shadowZ100(frame: self.viewNavi.frame)
            }
        }
        
        
    }
    
    
}

// ******************************************** //
// MARK:- UICollectionView Delegate & DataSource
// ******************************************** //
extension SubscriptionPlanVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrSubscriptionPlan.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: subscriptionPlanCollectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! subscriptionPlanCollectCell
        
        let dicPlan = self.arrSubscriptionPlan[indexPath.item] as! [String: Any]
        print(dicPlan)
        
        cell.lblTitle.text = "\(dicPlan["planTypeName"] as! String)"
        cell.viewBackMain.layer.cornerRadius = cell.viewBackMain.frame.height / 2
        
        print(strSelectedPlanCategoryIndex)
        if strSelectedPlanCategoryIndex == "\(indexPath.row)" {
            
            cell.lblTitle.textColor = UIColor.white
            cell.viewBackMain.backgroundColor = UIColor(named: Color_Primary)
        }
        else {
            
            cell.lblTitle.textColor = UIColor(named: Color_N_Dark900)
            cell.viewBackMain.backgroundColor = UIColor.clear
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dicPlan = self.arrSubscriptionPlan[indexPath.item] as! [String: Any]
        print(dicPlan)
        
        return CGSize(width: "\(dicPlan["planTypeName"] as! String)".size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(strSelectedPlanCategoryIndex)
        strSelectedPlanCategoryIndex = "\(indexPath.row)"
        
        let dicPlan = self.arrSubscriptionPlan[indexPath.item] as! [String: Any]
        self.lblPlanMessage.text = "\((dicPlan["planTypeDetails"] as! String).htmlToString)"
        
        let index = Int(strSelectedPlanCategoryIndex)
        self.arrSubPlan = (arrSubscriptionPlan[index!] as! [String: Any])["subscription_plan"] as! [Any]
        
       
        
         let i = IndexPath(item: indexPath.row, section: 0)
       //
       
        collectViewHeader.isPagingEnabled = false
        collectViewHeader.scrollToItem(at: i, at: .centeredHorizontally, animated: true)
        collectViewHeader.isPagingEnabled = true
        self.collectViewHeader.setNeedsLayout()
        tblViewSubscriptionPlan.reloadData()
        
        collectViewHeader.reloadData()
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension SubscriptionPlanVC {
    
    func getSubscriptionPlanAPICall() {
        
        // APIService.sharedInstance.getSubscriptionPlanAPICall(dictionary: ["idStations": "102"]) { [self] response in
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getSubscriptionPlanAPICall(dictionary: ["idStations": "\(strStationID)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicSubscriptionData = response["data"] as! [String: Any]
                
                self.lblNote.text = "\(dicSubscriptionData["note"] as! String)"
                self.viewNoteBack.isHidden = false
                
                self.arrSubscriptionPlan = dicSubscriptionData["plantypeslist"] as! [Any]
                if self.arrSubscriptionPlan.count == 0
                {
                    
                }
                else
                {
                    let dicPlan = self.arrSubscriptionPlan[0] as! [String: Any]
                    self.lblPlanMessage.text = "\((dicPlan["planTypeDetails"] as! String).htmlToString)"
                    
                    let index = Int(strSelectedPlanCategoryIndex)
                    print(index!)
                    print(strSelectedPlanCategoryIndex)
                    self.arrSubPlan = (arrSubscriptionPlan[index!] as! [String: Any])["subscription_plan"] as! [Any]
                    
                    self.collectViewHeader.reloadData()
                    self.tblViewSubscriptionPlan.reloadData()
                }
                
                
                //                self.lblPlanMessage.text
                
                //                self.arrSubscriptionPlan = dicSubscriptionData["plancategorylist"] as! [Any]
                
                //                print(arrSubscriptionPlan)
                //                self.tblViewSubscriptionPlan.reloadData()
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


// ************** UICollectionViewCell ***************
class subscriptionPlanCollectCell: UICollectionViewCell {
    @IBOutlet weak var viewBackMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
}




