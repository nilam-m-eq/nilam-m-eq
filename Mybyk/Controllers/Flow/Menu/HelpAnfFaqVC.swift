//
//  HelpAnfFaqVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit

class HelpAnfFaqVC: UIViewController {
    @IBOutlet weak var viewBackTopTab: UIView!
    @IBOutlet weak var TabBottomBar: UIView!
    @IBOutlet weak var tabBottomBarLeadingConstarints: NSLayoutConstraint!
    @IBOutlet weak var tabBottomBarWidthConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectViewTab: UICollectionView!
    @IBOutlet weak var collectViewViews: UICollectionView!
    
    @IBOutlet weak var viewNavi: UIView!
    
    var userGuide = UserGuideVC()
    
    let tabBarName = ["FAQ", "USER GUIDE"]
    var selectedIndex = 0
    var views = [UIView]()
    
    var pageMenu : CAPSPageMenu?
    
    
    var aryUserGuideList1 = NSMutableArray()
    var aryUserGuideListtmp1 = NSMutableArray()
    var checkIsUserDataAvailable = false
    
    var forUserGuidAPICallFirstWhile = false
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
            //    self.setupPages()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
      
      //  self.ApiGetUserGuide()
       // self.navigationController?.isNavigationBarHidden = false
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension HelpAnfFaqVC {
    
   
    
    func setUIOnScreen() {
        
       
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        print(self.viewBackTopTab.frame.width)
        print(self.viewBackTopTab.frame.width / 2)
        self.tabBottomBarLeadingConstarints.constant =  0
        self.tabBottomBarWidthConstraints.constant = self.viewBackTopTab.frame.width / 2 - 20
        self.collectViewViews.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let faq = self.storyboard?.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
         userGuide = self.storyboard?.instantiateViewController(withIdentifier: "UserGuideVC") as! UserGuideVC
  //      let request = self.storyboard?.instantiateViewController(withIdentifier: "RequestVC")
        
        let viewControllers = [faq, userGuide]
//        var i = 0
        for vc in viewControllers
        {
//            let xPos = Int(self.view.bounds.width) * i
            self.addChild(vc)
            vc.didMove(toParent: self)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 44)
            self.views.append(vc.view)
//            i += 1
        }
        if forUserGuidAPICallFirstWhile == false
        {
            self.ApiGetUserGuide()
        }
        else
        {
            
        }
       
      //  CommonClass.loadProgressHudCycling(viewController: self)
      
    }
    func ApiGetUserGuide()
    {
        //GetFAQDetails
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.GetUserGuide(dictionary: ["userguide": "1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            
            if response["is_error"] as! String == "false"
            {
                forUserGuidAPICallFirstWhile = true
                let dicAdd = response["data"] as? NSDictionary
                
                print("USER VAL",dicAdd!)
                
                aryUserGuideList1 = NSMutableArray(array:dicAdd!.value(forKey: "userguide_list") as! NSArray)
                aryUserGuideListtmp1 = NSMutableArray(array:dicAdd!.value(forKey: "userguide_list") as! NSArray)
                
                userGuide.aryUserGuideList = aryUserGuideList1
                userGuide.aryUserGuideListtmp = aryUserGuideListtmp1
                userGuide.checkUSerData = true
                
                print(aryUserGuideListtmp1[0])
               // aryUserGuideList.add(aryUserGuideListtmp[0])
                print(aryUserGuideList1)
               
                
                //dicAdd.value(forKey: "userguide_list")
                //(dicAdd?.value(forKey: "userguide_list") as? NSMutableArray)!
                //(response["userguide_list"] as? NSMutableArray)!
                
               /* for i in 0..<aryUserGuideList.count
                {
                    let dicData = aryUserGuideList[i] as! NSDictionary
                    arrUserGuide.append(dicData.value(forKey: "userGuideTitle") as! String)
                    //arrUserGuide
                    //arrUserGuideList
                }
                txtFindJob.text = arrUserGuide[0]
                
                let dicData = aryUserGuideList[0] as! NSDictionary
                
                //"\(dicSubscriptionPlan["description"] as! String)".htmlToAttributedString
                
                let strAtt = "\(dicData["description"] as! String)".htmlToAttributedString
                let Conver = NSMutableAttributedString(attributedString: strAtt!)
                let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
                Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
                
               // headerCell.lbHeaderTitle.attributedText = Conver
                
                lbDetails.attributedText = Conver
                //(dicData.value(forKey: "description") as! String).htmlToAttributedString
                lbHeader.text = "\(dicData["screenTitle"] as! String)"
                
                 self.dropDownFAQ.anchorView = self.btnDropDownFAQ
                 
                 self.dropDownFAQ.selectionAction = { (index: Int, item: String) in
                      
                      print("Selected item: \(item) at index: \(index)")
                     // self.strSelectedStateIndex = "\(index)"
                     // self.txtCity.text = ""
                      self.txtFindJob.text = item
                     
                     self.aryUserGuideList.removeAllObjects()
                     self.aryUserGuideList.add(self.aryUserGuideListtmp[index])
                     
                     let dicData = self.aryUserGuideList[0] as! NSDictionary
                     
                     //"\(dicSubscriptionPlan["description"] as! String)".htmlToAttributedString
                     
                     let strAtt = "\(dicData["description"] as! String)".htmlToAttributedString
                     let Conver = NSMutableAttributedString(attributedString: strAtt!)
                     let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
                     Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
                     
                     self.lbDetails.attributedText = Conver
                     
                  //   self.lbDetails.attributedText = "\(dicData["description"] as! String)".htmlToAttributedString
                     
                     self.lbHeader.text = "\(dicData["screenTitle"] as! String)"
                     
                   
                   //  self.aryUserGuideList = self.aryUserGuideListtmp[index] as! NSMutableArray
                     
                     self.CollSliderImage.reloadData()
                  }
                  
                 self.dropDownFAQ.dataSource = self.arrUserGuide
               //  PreviVal = self.arrUserGuide.count
                
                CollSliderImage.reloadData()*/
                 
            }
            else {
                
               /* viewNoUserGuideData.isHidden = false
                self.view.bringSubviewToFront(viewNoUserGuideData)*/
                
                print("USER VAL NOT FOUND")
                forUserGuidAPICallFirstWhile = true
                userGuide.checkUSerData = false
                CommonClass.removeProgressHudCycling(viewController: self)
                    
               // let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                 //   toast.show()
             
            }
           // self.setUIOnScreen()
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    func setupPages() {
        
        var pageControllerArray : [UIViewController] = []
        
        let faq = self.storyboard?.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
        faq.title = "FAQ"
        
        let userGuide = self.storyboard?.instantiateViewController(withIdentifier: "UserGuideVC") as! UserGuideVC
        userGuide.title = "USER GUIDE"
        
     //   let request = self.storyboard?.instantiateViewController(withIdentifier: "RequestVC") as! RequestVC
      //  request.title = "REQUESTS"
        
        
        pageControllerArray.append(faq)
        pageControllerArray.append(userGuide)
     //   pageControllerArray.append(request)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor(named: Color_Primary)!),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont(name: "Rubik-Bold", size: 14.0)!),
            .menuHeight(40.0),
            .menuItemWidth(90.0),
            .centerMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: pageControllerArray, frame: CGRect(x: 0.0, y: self.viewNavi.frame.size.height + self.viewNavi.frame.origin.y + 10, width: self.view.frame.width, height: self.view.frame.height - 40), pageMenuOptions: parameters)
        
        self.view.addSubview((pageMenu?.view)!)
        
    }
    
    
    @objc func animateMenu() {
        
        print(selectedIndex)
        print(TabBottomBar.bounds.width)
        self.tabBottomBarLeadingConstarints.constant = self.TabBottomBar.bounds.width * CGFloat(selectedIndex)
        self.tabBottomBarWidthConstraints.constant = self.viewBackTopTab.frame.width / 2
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            
//            let parameters: [CAPSPageMenuOption] = [
//                .scrollMenuBackgroundColor(UIColor.white),
//                .viewBackgroundColor(UIColor.white),
//                .selectionIndicatorColor(UIColor(named: Color_Primary)!),
//                .bottomMenuHairlineColor(UIColor.white),
//                .menuItemFont(UIFont(name: "Rubik-Bold", size: 14.0)!),
//                .menuHeight(40.0),
//                .menuItemWidth(90.0),
//                .centerMenuItems(true)
//            ]
//            pageMenu = CAPSPageMenu(viewControllers: pageControllerArray, frame: CGRect(x: 0.0, y: self.viewNavi.frame.size.height + self.viewNavi.frame.origin.y + 10, width: self.view.frame.width, height: self.view.frame.height - 40), pageMenuOptions: parameters)
        }
      //  self.scrollViewDidScroll(self)
        self.collectViewTab.reloadData()
     //   self.collectViewViews.reloadData()
        
    }
    
    
}

// ********** UICollectionView Delegate & DataSource ********** //
extension HelpAnfFaqVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectViewViews {
            return self.views.count
        }
        if collectionView == collectViewTab
        {
            return self.tabBarName.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectViewViews {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.contentView.addSubview(self.views[indexPath.row])
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TabBarCollectCell
            
            if self.selectedIndex == indexPath.item {
                cell.lblTabName.textColor = UIColor(named: Color_Primary)
            }
            else {
                cell.lblTabName.textColor = UIColor(named: Color_N_Dark500)
            }
            
            cell.lblTabName.text = tabBarName[indexPath.item]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectViewViews {
            return CGSize.init(width: self.collectViewViews.bounds.width, height: (self.collectViewViews.bounds.height + 22))
        }
        else {
            
            return CGSize.init(width: collectionView.bounds.width / 2, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.collectViewViews
        {
            
        }
        else
        {
            
            if self.selectedIndex != indexPath.item
            {
                self.selectedIndex = indexPath.item
                
                
                self.collectViewViews.isScrollEnabled = true
                self.collectViewViews.layoutIfNeeded()

                let collectionBounds = self.collectViewViews.bounds.size.width * CGFloat(indexPath.item)
                print(collectionBounds)
                let contentOffset = CGFloat(floor(collectionBounds))
                let frame: CGRect = CGRect(x : contentOffset ,y : self.collectViewViews.contentOffset.y ,width : self.collectViewViews.frame.width,height : self.collectViewViews.frame.height)
                print(frame)
                self.collectViewViews.scrollRectToVisible(frame, animated: true)
                
                self.animateMenu()
            }
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
        
        if scrollIndex == 0.0 || scrollIndex == 1.0
        {
            
            self.selectedIndex = Int(scrollIndex)
            self.animateMenu()
            
        }
        
    }
    
    
}






