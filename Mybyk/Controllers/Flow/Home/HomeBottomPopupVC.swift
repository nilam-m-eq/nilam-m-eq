//
//  HomeBottomPopupVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/06/21.
//

import UIKit

protocol SetindexForTop
{
    func SetBackIndex(RowVal : Int)
}
class HomeBottomPopupVC: CommonViewController
{
    @IBOutlet var tblHeightConst: NSLayoutConstraint!
    @IBOutlet weak var btnExpandMore: UIButton!
    @IBOutlet weak var tblViewHub: UITableView!
    
    let delegate : SetindexForTop? = nil
    
    var consMapViewBottom: NSLayoutConstraint!
    var didSelectRow: ((_ indexPath: IndexPath,_ fromIndex : Bool?) -> Void)?
    
    var didSelectRowTop: ((_ indexPath: IndexPath) -> Void)?
    
    var ActionMapDirection: ((_ index: Int) -> Void)?
    
    var arrHubList = NSArray()
    var strRestrictedHubMessage = String()
    
    
    var selectedHub = 0
    
    //let fullView: CGFloat = 280
    let fullView: CGFloat = 335
    var partialView: CGFloat = UIScreen.main.bounds.height
    
    var index: Int!
    var ChangeIndex: Int!
    
    var strongoingRide : String!
    // var homeVc = HomeVC()
    var checkDEviceWise = false
    var window : UIWindow?
    var topPadding : CGFloat!
    var bottomPadding : CGFloat!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
         window = UIApplication.shared.windows.first
         topPadding = window!.safeAreaInsets.top
         bottomPadding = window!.safeAreaInsets.bottom
        
        //332
        //196
        
//        for obj in tblViewHub.visibleCells {
//            if let cell = obj as? HomeBottomTblCell {
//                let height = cell.bounds.height
//                print("HEIGHT",height)
//            }
//        }
//
        /*  let indexVl = IndexPath(row: 0, section: 0)
         let row = tblViewHub.cellForRow(at: indexVl)
         print("ROW",row!)
         
         let cellHeight = (row?.bounds.height)!
         print("cellHeight",cellHeight)*/
        
        print(UIScreen.main.bounds.height)
        print(self.view.frame.height)
        
        //  self.tabBarController?.tabBar.isHidden = false
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        // print(index!)
        if index == nil
        {
            index = 0
        }
        
        // print(ChangeIndex!)
        //   print(consMapViewBottom!.constant)
        
        //  let indexPath = IndexPath(row: 4, section: 0)
        //  self.tblViewHub.scrollToRow(at: indexPath, at: .top, animated: true)
        
        
        
        if strongoingRide == "OngoingRide"
        {
            // print(strongoingRide!)
            //   self.tblViewHub.isUserInteractionEnabled = false
        }
        else
        {
            //  print("BASIC")
            //  self.tblViewHub.isUserInteractionEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.tabBarController?.tabBar.isHidden = false
        
        //        homeVc.strNearHubUserInteractionDisable = { (strCheckCondition) in
        //
        //            if strCheckCondition == "OngoingRide"
        //            {
        //                print("ONGoing")
        //            }
        //            else
        //            {
        //                print("Home")
        //            }
        //        }
        /*
         strNearHubUserInteractionDisable!("OngoingRide")
         strNearHubUserInteractionDisable!("HomeScreen")
         
         botomPop.didSelectRow = { (indexPath) in
         
         */
        self.setUIOnScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.view.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // self.consMapViewBottom.constant = 0
        
        CommonClass.loadProgressHudCycling(viewController: self)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            
            if self!.index == nil
            {
                self!.index = 0
            }
            print(self!.index!)
            let indexPath = IndexPath(row: 0, section: 0)
            let tblHeight = self?.tblViewHub.rectForRow(at: indexPath)
            
            //  self!.tblViewHub.scrollToRow(at: indexPath, at: .top, animated: true)
            
            // let indexPath = IndexPath(row: 0, section: 0)
            // let tblHeight = self?.tblViewHub.rectForRow(at: indexPath)
            
            // self!.tblViewHub.scrollToRow(at: indexPath, at: .top, animated: true)
            
            //self!.tblViewHub.reloadData()
            
            let frame = self?.view.frame
            
            print("TAB HEIGHT",self?.tabBarController?.tabBar.frame.height ?? 0)
            print("TABLE HEIGHT",tblHeight?.height ?? 0)
            
            print(tblHeight?.height)
            
            /*   if self!.index == 0
             {
             print((tblHeight!.height) + (82))
             
             let bottomSpace = (self?.tabBarController?.tabBar.frame.height)! + tblHeight!.height + 88
             
             self!.partialView = self!.partialView - bottomSpace
             let yComponent = self!.partialView
             self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height - 200)
             
             self!.consMapViewBottom.constant = tblHeight!.height + 88
             }
             else if self!.index == 1
             {
             print((Int(tblHeight!.height) * self!.index) + (82))
             
             let bottomSpace = Int((self?.tabBarController?.tabBar.frame.height)!) + (Int(tblHeight!.height) * self!.index!)  + (88 * 2)
             
             self!.partialView = self!.partialView - CGFloat(bottomSpace)
             let yComponent = self!.partialView
             self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height - 200)
             
             self!.consMapViewBottom.constant = CGFloat((Int(tblHeight!.height) * self!.index)  + (88 * 2))
             }
             else
             {
             
             
             print((Int(tblHeight!.height) * self!.index) + (82))
             print(self!.view.frame.height)
             
             
             let bottomSpace = Int((self?.tabBarController?.tabBar.frame.height)!) + (Int(tblHeight!.height) * self!.index!)  + (88 * self!.index)
             
             print(bottomSpace)
             self!.partialView = self!.partialView - CGFloat(bottomSpace)
             
             print(self!.partialView)
             let yComponent = self!.partialView
             print(yComponent)
             self?.view.frame = CGRect(x: 0, y: 120, width: frame!.width, height: frame!.height - 200)
             //CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height - 200)
             print(frame!.height - 200)
             
             self!.consMapViewBottom.constant = CGFloat(Int(tblHeight!.height) + (88 * self!.index))
             }
             */
            
            /*  DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
             self!.consMapViewBottom.constant = tblHeight!.height + 88
             }
             */
            
            var bottomSpace: CGFloat!
            if self?.tabBarController?.tabBar.frame.height == nil
            {
                bottomSpace = (48) + tblHeight!.height + 88
            }
            else
            {
                
                bottomSpace = (self?.tabBarController?.tabBar.frame.height)! + tblHeight!.height + 88
            }
            
            self?.tabBarController?.tabBar.backgroundColor = .white
            self!.partialView = self!.partialView - bottomSpace
            self!.view.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 20.0)
            //roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 8.0)
            
            let yComponent = self!.partialView
            
            
            //- (72 * 4)
            
            //  self?.view.frame = CGRect(x: 0, y: yComponent - 5, width: frame!.width, height: frame!.height - 300)
            //  400-173
            
            // 70+24+24+10+10+70+70
            //  self!.tblViewHub.scrollToRow(at: indexPath, at: .top, animated: true)
            
            print(self!.arrHubList.count)
            self!.tblViewHub.reloadData()
            print(self!.arrHubList.count)
            
            // fullview - 180
            // 24+24++70+10+30
            if  self!.index! == 0
            {
                /*
                 
                 //332
                 //196
                 */
                
                // 10+24+10+24+8+88+88+88 = 340
                
                //10+24+10+24+8+88+44 = 208
                
                // UIApplication.shared.keyWindow?.safeAreaInsets.top
                
                // self!.view.frame = CGRect(x: 0, y: self!.partialView - 35, width: self!.view.frame.width, height: self!.view.frame.height - 335)
               // print("TOP",UIApplication.shared.keyWindow?.safeAreaInsets.top)
               // print(self!.view.safeAreaInsets.top)
                
                
                
               // print("TOP PAdding",topPadding)
               // print("Bottom Padding",bottomPadding)
                
               // print("TOP LAYOUT",self!.view.safeAreaInsets.top)
                
              //  print("SAFE AREA",self!.view.frame.height - self!.topLayoutGuide.length - self!.bottomLayoutGuide.length)
                
                
                if  self!.topPadding >= 44
                {
                   // CommonClass.loadProgressHudCycling(viewController: self!)
                    self!.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 50 - 208 - self!.bottomPadding), width: self!.view.frame.width, height: 350)
                    self!.checkDEviceWise = true
                }
                else
                {
                  //  CommonClass.loadProgressHudCycling(viewController: self!)
                    self!.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 50 - 208), width: self!.view.frame.width, height: 350)
                    
                    self!.checkDEviceWise = false
                }
                    
                
                //   self!.tblHeightConst.constant = 170
                self!.tblHeightConst.constant = 264
                self!.btnExpandMore.isSelected = false
                self?.tblViewHub.isScrollEnabled = false
                CommonClass.removeProgressHudCycling(viewController: self!)
            } else {
                //      self!.view.frame = CGRect(x: 0, y: self!.fullView, width: self!.view.frame.width, height: self!.view.frame.height - 335)
                
                
               /* if #available(iOS 11.0, *)
                {
                    self!.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 340 - 50 - 34, width: self!.view.frame.width, height: 350)
                    
                    self!.checkDEviceWise = true
                }
                else
                {
                    self!.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 340 - 50, width: self!.view.frame.width, height: 350)
                    
                    self!.checkDEviceWise = false
                }*/
                //let window = UIApplication.shared.windows.first
              //  let topPadding = window!.safeAreaInsets.top
               // let bottomPadding = window!.safeAreaInsets.bottom
                
               // print("TOP PAdding",topPadding)
               // print("Bottom Padding",bottomPadding)
                
               // print("TOP LAYOUT",self!.view.safeAreaInsets.top)
                
              //  print("SAFE AREA",self!.view.frame.height - self!.topLayoutGuide.length - self!.bottomLayoutGuide.length)
                
                
                if self!.topPadding >= 44
                {
                  //  CommonClass.loadProgressHudCycling(viewController: self!)
                    self!.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 340 - 50 - self!.bottomPadding), width: self!.view.frame.width, height: 350)
                    self!.checkDEviceWise = true
                }
                else
                {
                   // CommonClass.loadProgressHudCycling(viewController: self!)
                    self!.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 340 - 50 ), width: self!.view.frame.width, height: 350)
                    self!.checkDEviceWise = false
                }
                    
               
                self!.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                self!.btnExpandMore.isSelected = true
                
                self?.tblViewHub.isScrollEnabled = false
                CommonClass.removeProgressHudCycling(viewController: self!)
                
            }
            self!.view.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 20.0)
            
            
        })
        
        
        /*   UIView.animate(withDuration: 0.3) { [weak self] in
         
         let indexPath = IndexPath(row: 0, section: 0)
         let tblHeight = self!.tblViewHub.rectForRow(at: indexPath)
         
         let frame = self?.view.frame
         self!.consMapViewBottom.constant = tblHeight.height + 82
         let bottomSpace = (self?.tabBarController?.tabBar.frame.height)! + tblHeight.height + 82
         let yComponent = UIScreen.main.bounds.height - bottomSpace
         self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: tblHeight.height + 82)
         }*/
        //        UIView.animate(withDuration: 0.6, animations: { [weak self] in
        //
        //            let indexPath = IndexPath(row: 0, section: 0)
        //            let tblHeight = self?.tblViewHub.rectForRow(at: indexPath)
        //
        //            let frame = self?.view.frame
        //            self!.consMapViewBottom.constant = tblHeight!.height + 82
        //
        //            let bottomSpace = (self?.tabBarController?.tabBar.frame.height)! + tblHeight!.height + 82
        //
        //            self!.partialView = self!.partialView - bottomSpace
        //            let yComponent = self!.partialView
        //            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height - 200)
        //        })
    }
    
    func ReloadTable(indexVal : Int)
    {
        print(indexVal)
        
        print(arrHubList)
        let indexpath = IndexPath(row: indexVal, section: 0)
        tblViewHub.reloadRows(at: [indexpath], with: UITableView.RowAnimation.fade)
        
        //        let indexPath = IndexPath(row: indexVal, section: 0)
        //        self.tblViewHub.scrollToRow(at: indexPath, at: .top, animated: true)
        
    }
    // ********** All Button Actions ********** //
    @IBAction func ActionExpandMore(_ sender: UIButton) {
        
        
        print(self.btnExpandMore.isSelected )
        if btnExpandMore.isSelected == true
        {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
                
                // self.view.frame = CGRect(x: 0, y: self.partialView - 35, width: self.view.frame.width, height: self.view.frame.height)
                
                //   self.view.frame = CGRect(x: 0, y: self.view.frame.height - 190, width: self.view.frame.width, height: self.view.frame.height)
                if self.checkDEviceWise == true
                {
                    self.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 208 - 50 - self.bottomPadding), width: self.view.frame.width, height: 350)
                }
                else
                {
                    self.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - 208 - 50 ), width: self.view.frame.width, height: 350)
                }
                self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                self.tblViewHub.isScrollEnabled = false
                
                print(self.partialView - 50)
                print(self.view.frame.height)
                
                
            }, completion: { [weak self] _ in
                
                self!.btnExpandMore.isSelected = false
            })
            
        }
        else {
            
            // print(fullView)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
                
                //   self.view.frame = CGRect(x: 0, y: self.fullView , width: self.view.frame.width, height: self.view.frame.height)
                
                //self.view.frame = CGRect(x: 0, y: self.view.frame.height - 330 , width: self.view.frame.width, height: self.view.frame.height)
                
                // print(self.fullView)
                // print(self.view.frame.height)
                if self.checkDEviceWise == true
                {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 340 - 50 - self.bottomPadding, width: self.view.frame.width, height: 350)
                }
                else
                {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 340 - 50 , width: self.view.frame.width, height: 350)
                }
                
                self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                self.tblViewHub.isScrollEnabled = false
                
                
            }, completion: { [weak self] _ in
                
                self!.btnExpandMore.isSelected = true
            })
            
        }
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension HomeBottomPopupVC {
    
    func setUIOnScreen()
    {
        self.view.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 8.0)
        
        //        if arrHubList.count != 0 {
        //
        //            let indexPath = IndexPath(row: 0, section: 0)
        //            didSelectRow!(indexPath)
        //
        //        }
        
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer)
    {
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        let MainViewHeight = UIScreen.main.bounds.height - 50
        
        print("VELOCITY",velocity.y)
        print("TRANSLATION",translation.y)
        print("View Y Pos",y)
        print("View 3List",UIScreen.main.bounds.height - 340 - 50)
        print("View 1.5List",UIScreen.main.bounds.height - 208 - 50)
        
        /*if (y + translation.y >= fullView) && (y + translation.y <= partialView)
         {
         self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
         recognizer.setTranslation(CGPoint.zero, in: self.view)
         }*/
        
        if self.checkDEviceWise == true
        {
            if velocity.y < 0
            {
                if y > UIScreen.main.bounds.height - 340 - 50 - self.bottomPadding
                {
                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: 350)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                    
                    self.btnExpandMore.isSelected = true
                }
                else
                {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 340 - 50 - self.bottomPadding, width: view.frame.width, height: 350)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                    
                    self.btnExpandMore.isSelected = true
                }
            }
           /* if velocity.y == 0.0
            {
               self.view.frame = CGRect(x: 0, y: y + translation.y, width: self.view.frame.width, height: 350)
                
                self.btnExpandMore.isSelected = true
                
               
                // self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                // self.tblViewHub.isScrollEnabled = false
                
                /*self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                 recognizer.setTranslation(CGPoint.zero, in: self.view)*/
            }*/
            if velocity.y > 0
            {
             //   self.view.frame = CGRect(x: 0, y: y + translation.y, width: self.view.frame.width, height: 340)
                
               // self.btnExpandMore.isSelected = true
                
               
              /*  self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: 340)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
                
                self.btnExpandMore.isSelected = false*/
                
                
                if y >  UIScreen.main.bounds.height - 208 - 50 - self.bottomPadding
                {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 208 - 50 - self.bottomPadding, width: self.view.frame.width, height: 350)
                    self.tblHeightConst.constant = 264
                    //  self!.tblHeightConst.constant = 128
                    // self!.btnExpandMore.isSelected = true
                    
                    self.tblViewHub.isScrollEnabled = false
                    self.btnExpandMore.isSelected = false
                  
                   
                  
                }
                else
                {
                    
                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: 350)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                    
                    self.btnExpandMore.isSelected = false
                  //  self.btnExpandMore.isSelected = true
                }
                
               
                
                // self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                // self.tblViewHub.isScrollEnabled = false
            }
        }
        else
        {
            if velocity.y < 0
            {
                if y > UIScreen.main.bounds.height - 340 - 50
                {
                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: 350)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                    
                    self.btnExpandMore.isSelected = true
                }
                else
                {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 340 - 50, width: view.frame.width, height: 350)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                    
                    self.btnExpandMore.isSelected = true
                }
            }
           /* if velocity.y == 0.0
            {
               self.view.frame = CGRect(x: 0, y: y + translation.y, width: self.view.frame.width, height: 350)
                
                self.btnExpandMore.isSelected = true
                
               
                // self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                // self.tblViewHub.isScrollEnabled = false
                
                /*self.viewBackDetail.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: viewBackDetail.frame.height)
                 recognizer.setTranslation(CGPoint.zero, in: self.view)*/
            }*/
            if velocity.y > 0
            {
             //   self.view.frame = CGRect(x: 0, y: y + translation.y, width: self.view.frame.width, height: 340)
                
               // self.btnExpandMore.isSelected = true
                
               
              /*  self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: 340)
                recognizer.setTranslation(CGPoint.zero, in: self.view)
                
                self.btnExpandMore.isSelected = false*/
                
                
                if y >  UIScreen.main.bounds.height - 208 - 50
                {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 208 - 50, width: self.view.frame.width, height: 350)
                    self.tblHeightConst.constant = 264
                    //  self!.tblHeightConst.constant = 128
                    // self!.btnExpandMore.isSelected = true
                    
                    self.tblViewHub.isScrollEnabled = false
                    self.btnExpandMore.isSelected = false
                  
                   
                  
                }
                else
                {
                    
                    self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: 350)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                    
                    self.btnExpandMore.isSelected = false
                  //  self.btnExpandMore.isSelected = true
                }
                
               
                
                // self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                // self.tblViewHub.isScrollEnabled = false
            }
        }
        
        
       /* if recognizer.state == .ended
        {
            if velocity.y > 0
            {
                
                
                UIView.animate(withDuration: 1.0) {
                    
                   
                    print("TOUCH ENDED")
                    //   self.view.layoutIfNeeded()
                    
                    //  self.view.removeFromSuperview()
                    
                    // self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
                    //  self.view.frame.origin.y = self.view.frame.height
                    
                    print("TOUCH ENDED Completion")
                    
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 208 - 50, width: self.view.frame.width, height: 340)
                    self.tblHeightConst.constant = 264
                    //  self!.tblHeightConst.constant = 128
                    // self!.btnExpandMore.isSelected = true
                    
                    self.tblViewHub.isScrollEnabled = false
                    self.btnExpandMore.isSelected = false
                    
                } completion: { status in
                    
                   
                    //  self.view.removeFromSuperview()
                }
                
            }
            else
            {
               /* print("TOUCH ENDED Else")
                self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 208 - 50, width: self.view.frame.width, height: 340)
                self.tblHeightConst.constant = 264
                //  self!.tblHeightConst.constant = 128
                // self!.btnExpandMore.isSelected = true
                
                self.tblViewHub.isScrollEnabled = false
                self.btnExpandMore.isSelected = false*/
                
                //self.btnExpandMore.isSelected = true
            }
            /* var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y)
             
             duration = duration > 1.3 ? 1 : duration
             
             UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations:
             {
             if  velocity.y >= 0
             {
             //self.view.frame = CGRect(x: 0, y: self.partialView - 35, width: self.view.frame.width, height: self.view.frame.height)
             self.view.frame = CGRect(x: 0, y:self.view.frame.height - 190, width: self.view.frame.width, height: self.view.frame.height)
             
             // print(self.partialView - 50)
             // print(self.view.frame.height)
             self.btnExpandMore.isSelected = false
             } else {
             // self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
             self.view.frame = CGRect(x: 0, y: self.view.frame.height - 330, width: self.view.frame.width, height: self.view.frame.height)
             
             //  print(self.fullView)
             //  print(self.view.frame.height)
             self.btnExpandMore.isSelected = true
             }
             
             }, completion: { [weak self] _ in
             if (velocity.y < 0) {
             //                        self?.tableView.isScrollEnabled = true
             }
             })*/
        }*/
    }
    
}

extension HomeBottomPopupVC: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        //        if (y == fullView && tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
        //            tableView.isScrollEnabled = false
        //        } else {
        //            tableView.isScrollEnabled = true
        //        }
        
        return false
    }
    
}


// ****************************************** //
// MARK:- UITableView Delegate & DataSource
// ****************************************** //
extension HomeBottomPopupVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(arrHubList.count)
        if arrHubList.count > 3
        {
            return 3
        }
        else
        {
            return arrHubList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! HomeBottomTblCell
        
        let dicHubData = arrHubList[indexPath.row] as! [String: Any]
        print(dicHubData)
        
        print(indexPath.row)
        
        print(selectedHub)
        print(index!)
        
        // cell.viewMainBack.shadowZ100(frame: cell.viewMainBack.frame)
        
        /*
         bReferCode.layer.masksToBounds = false
         lbReferCode.layer.shadowRadius = 2.0
         lbReferCode.layer.shadowOpacity = 0.2
         lbReferCode.layer.shadowOffset = CGSize(width: 1, height: 1)
         
         lbReferCode.viewTextFieldActiveBorder()
         */
        if indexPath.row == index
        //  if indexPath.row == selectedHub
        {
            index = indexPath.row
            cell.viewMainBack.viewTextFieldPrimaryBorderForSelect()
            let home = HomeVC()
            home.FromSelectBike = indexPath.row
            //  cell.viewMainBack.shadowZ100(frame: cell.viewMainBack.frame)
            //viewNavi.shadowZ100(frame: viewNavi.frame)
        }
        else
        {
            // cell.viewMainBack.layer.borderColor = UIColor.clear.cgColor
            cell.viewMainBack.viewTextFieldShadowBorder()
            
        }
        
        /* if indexPath.row == selectedHub
         {
         cell.viewMainBack.viewTextFieldPrimaryBorder()
         
         }
         else {
         cell.viewMainBack.layer.borderColor = UIColor.clear.cgColor
         }*/
        
        
        cell.lblHubName.text = "\(dicHubData["stationName"] as! String)"
        
        if (dicHubData["allCycleCount"] as! Int == 0)
        {
            cell.lblAvailableCycle.text = "No cycle available"
        }
        else
        {
            cell.lblAvailableCycle.text = "\(dicHubData["allCycleCount"] as! Int) cycles available"
        }
        
        cell.lblDistance.text = "\(dicHubData["hub_distance"] as! Int) \(dicHubData["distance_unit"] as! String)"
        cell.lblWalkTime.text = "\(dicHubData["total_time"] as! Int) \(dicHubData["time_unit"] as! String)"
        
        //        cell.viewMainBack.shadowZ100(frame: cell.viewMainBack.frame)
        
        if dicHubData["terminalIsPrivate"] as! Int == 1 {
            
            //   cell.viewBackRestrictedHub.isHidden = false
            // cell.viewBackRestrictedHub.layer.cornerRadius = 4.0
            //cell.lblRestrictedHub.text = strRestrictedHubMessage
            cell.imgRestrictedHub.isHidden = false
            cell.imgRestrictedHub.image = cell.imgRestrictedHub.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            cell.imgRestrictedHub.tintColor = UIColor.red
        }
        else
        {
            cell.imgRestrictedHub.isHidden = true
            //cell.viewBackRestrictedHub.isHidden = true
        }
        
        cell.btnDirection.tag = indexPath.row
        cell.btnDirection.addTarget(self, action: #selector(self.ActionHubMapDirection(sender:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //  print(strongoingRide!)
        //        if strongoingRide == "OngoingRide"
        //        {
        //            print(indexPath.row)
        //            didSelectRow!(indexPath)
        //           // self.delegate?.SetBackIndex(RowVal:indexPath.row)
        //
        //            //SetBackTableIndex
        //           // didSelectRow!(indexPath)
        //           // self.delegate.
        //
        //        }
        //        else
        //        {
        //            didSelectRow!(indexPath)
        //        }
        
        print(indexPath)
        print(arrHubList.count)
        print(indexPath.row)
        print(index!)
        
        //let indexPath = IndexPath(row: 0, section: 0)
        print(arrHubList[indexPath.row])
        tblViewHub.reloadData()
        
        let home = HomeVC()
        home.FromSelectBike = indexPath.row
        if index == indexPath.row
        {
            didSelectRow!(indexPath, true)
        }
        else
        {
            didSelectRow!(indexPath, false)
        }
        
        
        
        //print(home.FromSelectBike)
        //  selectedHub = indexPath.row
        index = indexPath.row
        print(selectedHub)
        //indexPath.row
        // self.delegate?.sendSearchLocationLatLong(strLat: "", strLong: "", strAddress: "")
        //SetBackTableIndex
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    @objc func ActionHubMapDirection(sender: UIButton) {
        
        //        didSelectRow!(indexPath)
        ActionMapDirection!(sender.tag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //        let y = 300 - (scrollView.contentOffset.y + 300)
        //        let height = min(max(y, 60), 400)
        //        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        
        
        //        let y = 300 - (scrollView.contentOffset.y + 300)
        //        let height = min(max(y, 60), 400)
        //        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        //        lblName.frame = CGRect(x: 20, y: height - 30, width: 200, height: 22)
    }
    
}




