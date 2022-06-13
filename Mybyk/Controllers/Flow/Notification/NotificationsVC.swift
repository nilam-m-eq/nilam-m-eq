//
//  NotificationsVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit
import Toaster
import SDWebImage
import SafariServices

class NotificationsVC: CommonViewController {
    @IBOutlet var viewNotiHeader: UIView!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet var viewBannerBack: UIView!
    @IBOutlet var collectViewBanner: UICollectionView!
    @IBOutlet var pageView: UIPageControl!
    @IBOutlet weak var tblViewNotif: UITableView!
    @IBOutlet var viewNotFoundPreview: UIView!
    @IBOutlet var lblNotFoundText: UILabel!
    @IBOutlet var scrollMain: UIScrollView!
    
    @IBOutlet var viewSliderHeight: NSLayoutConstraint!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    var arrBanner = NSArray()
    
    
    let notifViewModel = NotificationViewModel()
    let notifModel = NotificationModel()
    
    var intNotifPage = 1
    
    var timer = Timer()
    var counter = 0
    
    var checkflag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = false
        
    //    NotificationCenter.default.removeObserver(self)
        viewNotFoundPreview.isHidden = true
        self.setUIOnScreen()
        
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(ReloadNotification(_:)),
                         name: NSNotification.Name("ReloadNotification"),object: nil)
        

        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
     //   notifModel.dataArr.removeAll()
        print("VIEW WILL")
    }
    @objc func ReloadNotification(_ notification: Notification)
    {
        notifModel.dataArr.removeAll()
        
        intNotifPage = 1
        
        self.loadNotificationAPICall(page: "\(intNotifPage)")
        //
        
        // self.viewDidLoad()
       // self.viewWillAppear(true)
        
      //  self.view.layoutIfNeeded()
       // self.setUIOnScreen()
        
    }
    // ********** All Button Actions ********** //
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension NotificationsVC {
    
    func setUIOnScreen() {
        
    
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
        viewNotiHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
       
      //  viewBannerBack.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
       // viewNotiHeader.backgroundColor = .red
       
        
        
        
      //  tableHeight.constant = self.view.frame.height-(viewSliderHeight.constant - 44)
       // self.tblViewNotif.isScrollEnabled = false
        //self.scrollMain.bounces = false
       // self.tblViewNotif.bounces = true
       
        
        tblViewNotif.delegate = notifViewModel
        tblViewNotif.dataSource = notifViewModel
        
        collectViewBanner.delegate = notifViewModel
        collectViewBanner.dataSource = notifViewModel
        
//        if notifModel.dataArr.count == 0
//        {
//            self.view.bringSubviewToFront(viewNotFoundPreview)
//            viewNotFoundPreview.isHidden = false
//        }
//        else
//        {
//
//        }
        
     
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[3]
            tabItem.badgeValue = nil
        }
        
        // ************* UITableView Methods ******************
        
        
        notifViewModel.sectionCount = 1
        
//        if notifModel.dataArr.count == 0
//        {
//            notifViewModel.cellRender = {  indexPath, tableView in
//                let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell") as! NotificationTblCell
//                cell.selectionStyle = .none
//                return cell
//            }
//        }
//        else
//        {
            notifViewModel.cellRender = { [self] indexPath, tableView in
                let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell") as! NotificationTblCell
                print("NOTIFICATION ARRAY",notifModel.dataArr)
                if notifModel.dataArr.count == 0
                {
                   
                }
                else
                {
                   cell.lblTitle.text = notifModel.dataArr[indexPath.row].strNotifTitle
                   cell.lblDescription.text = notifModel.dataArr[indexPath.row].strNotifMessage
                   cell.lblDate.text = notifModel.dataArr[indexPath.row].strNotifDays
                   cell.imgViewIcon.image = UIImage(named: notifModel.dataArr[indexPath.row].strNotifIcon!)
                   cell.viewBackMain.viewBorderWithCornerRadiusNoti()
                   
                   if indexPath.row == notifModel.dataArr.count - 5
                   {
                       intNotifPage = intNotifPage + 1
                     //  if checkflag == false
                     //  {
                           self.loadNotificationAPICall(page: "\(intNotifPage)")
                      // }
                      
                   }
                }
    
                cell.selectionStyle = .none
                return cell
            //}
        }
        
        
        notifViewModel.cellSelect = { indexPath, tableView in
            
//            if indexPath.row == 0 {
//
//                let notifDetail = self.storyboard?.instantiateViewController(withIdentifier: "NotificationDetailVC") as! NotificationDetailVC
//                self.navigationController?.pushViewController(notifDetail, animated: true)
//            }
            
        }
        
        // ************* UICollectionView Methods ******************
        
       
        notifViewModel.cellCollectRender = { indexPath, collectionView in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! collectNotifBannerCell
            print(self.arrBanner[indexPath.item])
            
            
            if self.arrBanner.count == 0
            {
               
            }
            else
            {
                let dicBanner = self.arrBanner[indexPath.item] as! [String: Any]
                
                cell.imgViewBanner.sd_setImage(with: URL(string: "\(dicBanner["bannerImage"] as! String)"), placeholderImage: UIImage(named: ""))
                
                
            }
            return cell
        }
        
        notifViewModel.cellCollectSelect = { indexPath, collectionView in
            
            if self.arrBanner.count == 0
            {
               
            }
            else
            {
                let dicBanner = self.arrBanner[indexPath.item] as! [String: Any]
                print(dicBanner)
                
                guard let url = URL(string: "\(dicBanner["bannerURL"] as! String)") else {
                    return
                }
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true, completion: nil)
            }
            
            
        }
        
        self.loadNotificationAPICall(page: "\(intNotifPage)")
        
    }
    
    @objc func changeImage()
    {
        
        if counter < arrBanner.count
        {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectViewBanner.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        }
        else
        {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectViewBanner.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
    
}


// ****************************************** //
// MARK:- UIScrollView Delegate Methods
// ****************************************** //
extension NotificationsVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
//        if scrollView == self.scrollMain {
//            tblViewNotif.isScrollEnabled = (self.scrollMain.contentOffset.y >= (viewSliderHeight.constant - 44))
//        }
//
//        if scrollView == self.tblViewNotif {
//            self.tblViewNotif.isScrollEnabled = (tblViewNotif.contentOffset.y > 0)
//        }
    }
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension NotificationsVC {
    
    func loadNotificationAPICall(page: String) {
        
        if page == "1" {
            
            CommonClass.loadProgressHudCycling(viewController: self)
        }
        
     //   CommonClass.loadProgressHudCycling(viewController: self)
        
        APIService.sharedInstance.notificationFetchAPICall(dictionary: ["page": page, "getnotifications": "true"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            print("PAGE",page)
            if response["is_error"] as! String == "false"
            {
                
                let dicNotifData = response["data"] as! [String: Any]
                let arrNotif = dicNotifData["notifications"] as! [AnyObject]
               
               if arrNotif.count != 0
                {
                  //  checkflag = true
                    self.viewNotFoundPreview.isHidden = true
                 //   self.scrollMain.isHidden = false
                        
                 
                       self.notifModel.getNotificationData(arrNotif: arrNotif) { status, success in
                        
                        print("NOTIFICATION COUNT",arrNotif.count)
                        self.notifViewModel.rawCount = (self.notifModel.dataArr.count)
                           
                           DispatchQueue.main.async
                           {
                                self.tblViewNotif.reloadData()
                           }
                       
                    }
                   
                    
                    if page == "1"
                    {
                
                        if arrBanner.count == 0
                        {
                            tblViewNotif.tableHeaderView = UIView()
                        }
                        else
                        {
                            self.arrBanner = dicNotifData["banner_images"] as! NSArray
                            self.notifViewModel.itemCount = (self.arrBanner.count)
                            
                            pageView.numberOfPages = self.arrBanner.count
                            pageView.currentPage = 0
                           
                                self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                            tblViewNotif.tableHeaderView = viewNotiHeader
                            self.collectViewBanner.reloadData()
                        }
                        
                    }
                    
                }
                else
                {
                //    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                 //   toast.show()
                }
                /*else
                {
                   
                    
                    if page == "1"
                    {
                        self.view.bringSubviewToFront(viewNotFoundPreview)
                        viewNotFoundPreview.isHidden = false
                      //  self.scrollMain.isHidden = true
                    }
                }*/
                
            }
            else
            {
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






