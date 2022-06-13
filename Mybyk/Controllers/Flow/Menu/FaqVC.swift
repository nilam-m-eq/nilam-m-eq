//
//  FaqVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit
import Toaster

class FaqVC: CommonViewController {
    @IBOutlet weak var tblViewFAQ: UITableView!
    
//    var aryUserGuideList1 = NSMutableArray()
//    var aryUserGuideListtmp1 = NSMutableArray()
//    var checkIsUserDataAvailable = false
    
  //  var arrFaqList = [String]()
    
    var arrFaqList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
      //  arrFaqList = ["Regarding previous rides", "I am not able to lock my bike", "Wallet Related", "Refund Related", "Subscription Plan Related", "KYC and document Related", "Legal Terms and conditions", "Other"]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
        
        // WsFAQList = "WsFAQsCategories.php?\(strVersion)"
    }
    
    
    // ********** All Button Actions ********** //
    @IBAction func ActionChatFloating(_ sender: UIButton) {
        
        
    }
    
    
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension FaqVC {
    
    func setUIOnScreen() {
        
        tblViewFAQ.delegate = self
        tblViewFAQ.dataSource = self
        self.ApiGetFAQList()
        
    }
    func ApiGetFAQList()
    {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.GetFAQ(dictionary: ["faqscategories": "true"]) { [self] response in
           CommonClass.removeProgressHudCycling(viewController: self)
            
           // print(response)
            
            if response["is_error"] as! String == "false"
            {
               let DtDic = response["data"] as! NSDictionary
                let aryofFAQData = DtDic.value(forKey: "faqs_categories") as! NSArray
                ///print(aryofFAQData)
                arrFaqList = NSMutableArray(array: aryofFAQData as! [Any], copyItems: true)
                tblViewFAQ.reloadData()
                
               
                
            }
            else {
                
                CommonClass.removeProgressHudCycling(viewController: self)
                    
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
             
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
}

//********** UITableView Delegate & DataSource ********** //
extension FaqVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrFaqList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FaqTblCell
        
        let dataDic = arrFaqList[indexPath.row] as! NSDictionary
        print(dataDic)
        cell.lblFaqName.text = dataDic.value(forKey: "faqCategoryName") as? String
        cell.viewBackMain.shadowZ100(frame: cell.viewBackMain.frame)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let faqDet = self.storyboard?.instantiateViewController(identifier: "FaqDetailVC") as! FaqDetailVC
        let faqDet = self.storyboard?.instantiateViewController(withIdentifier: "FaqDetailVC") as! FaqDetailVC
        let dataDic = arrFaqList[indexPath.row] as! NSDictionary
        print(dataDic)
        faqDet.FAQID = dataDic.value(forKey: "idFAQCategories") as? String
        faqDet.strFAQTitle = dataDic.value(forKey: "faqCategoryName") as? String
        self.navigationController?.pushViewController(faqDet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}



