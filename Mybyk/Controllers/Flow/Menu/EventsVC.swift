//
//  EventsVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit
import Toaster
import CoreLocation

class EventsVC: CommonViewController {
    @IBOutlet var viewNoEvent: UIView!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackSearch: UIView!
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet weak var tblViewEvent: UITableView!
    
    var locationManager = CLLocationManager()
    
    let eventViewModel = EventListViewModel()
    let eventModel = EventListModel()
    
    var intEventPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventModel.dataArr.removeAll()
        self.eventViewModel.rawCount = 0
        tblViewEvent.reloadData()
        intEventPage = 1
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    //MARK: - button action
    
    @IBAction func btnSearchClicked(_ sender: Any)
    {
        
        if txtSearch.text == ""
        {
            self.getEventListAPICall(page: "\(1)", strSearch: "")
        }
        else
        {
            self.getEventListAPICall(page: "\(1)", strSearch: txtSearch.text!)
        }
    }
    @IBAction func ActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EventsVC {
    
    func setUIOnScreen() {
        
        viewNoEvent.isHidden = true
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewBackSearch.shadowZ100(frame: viewBackSearch.frame)
        
        tblViewEvent.delegate = eventViewModel
        tblViewEvent.dataSource = eventViewModel
        eventViewModel.sectionCount = 1
        weak var weakSelf = self
        
        eventViewModel.cellRender = {[self] indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTblCell
            cell.lblTitle.text = weakSelf?.eventModel.dataArr[indexPath.row].strEventTitle
            cell.lblDescription.attributedText = weakSelf?.eventModel.dataArr[indexPath.row].strEventDescription?.htmlToAttributedString
//            cell.lblDate.text = weakSelf?.eventModel.dataArr[indexPath.row].strEventDate
//            cell.imgViewIcon.image = UIImage(named: (weakSelf?.eventModel.dataArr[indexPath.row].strEventIcon)!)
            cell.viewBackMain.viewBorderWithCornerRadi()
            
            
            if indexPath.row == eventModel.dataArr.count - 5 {
                intEventPage = intEventPage + 1
                self.getEventListAPICall(page: "\(intEventPage)", strSearch: "")
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        eventViewModel.cellSelect = { [self] indexPath, tableView in
            
            let eventDet = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as! EventDetailVC
            print(eventModel.dataArr[indexPath.row].IdEvent!)
            eventDet.strEventID = eventModel.dataArr[indexPath.row].IdEvent!
          //  eventDet.dataArrFrom =
            // let model = EventListSomeData(strEventTitle: title, strEventDescription: desc, IdEvent: ID)eventModel.dataArr[indexPath.row]
            self.navigationController?.pushViewController(eventDet, animated: true)
        }
        
//        eventModel.getEventData { status, success in
//            weakSelf?.eventViewModel.rawCount = (weakSelf?.eventModel.dataArr.count)!
//            weakSelf?.tblViewEvent.reloadData()
//        }
        
        self.getEventListAPICall(page: "\(intEventPage)", strSearch: "")
        
        
    }
    
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension EventsVC {
    
    func getEventListAPICall(page: String,strSearch : String)
    {
        
        if CLLocationManager.locationServicesEnabled() {
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways {
                
                print("Access")
                var currentLocation = CLLocation()
                currentLocation = locationManager.location!
                print(currentLocation.coordinate.latitude)
                print(currentLocation.coordinate.longitude)
                print(page)
                /*
                 userplace_lat : 23.036714
                 userplace_long : 72.511493
                 page : 1
                 */
                if page == "1" {
                    
                    CommonClass.loadProgressHudCycling(viewController: self)
                }
                APIService.sharedInstance.getEventListAPICall(dictionary: ["userplace_lat": "\(currentLocation.coordinate.latitude)", "userplace_long":"\(currentLocation.coordinate.longitude)", "page": page,"searchevent" : strSearch]) { [self] response in
              //  APIService.sharedInstance.getEventListAPICall(dictionary: ["userplace_lat": "23.036714", "userplace_long":"72.511493", "page": "1","searchevent" : strSearch]) { [self] response in
                    CommonClass.removeProgressHudCycling(viewController: self)
                    
                    print(response)
                    
                    if response["is_error"] as! String == "false" {
                        
                        let dicEventData = response["data"] as! [String: Any]
                        let arrEventList = dicEventData["events"] as! [AnyObject]
                        
                        if arrEventList.count == 0
                        {
                            viewBackSearch.isHidden = true
                            self.view.bringSubviewToFront(viewNoEvent)
                            viewNoEvent.isHidden = false
                        }
                        else
                        {
                            viewBackSearch.isHidden = false
                            viewNoEvent.isHidden = true
                            print(arrEventList)
                            eventModel.getEventData(arrEvent: arrEventList) { status, success in
                                print(eventModel.dataArr)
                                self.eventViewModel.rawCount = (self.eventModel.dataArr.count)
                                self.tblViewEvent.reloadData()
                            }
                            
                        }
                       
//                        eventModel.currencySymbol = dicMyRideData["currency_symbol"] as! String
//                        eventModel.getData(arrRide: arrAllRides) { success, status in
//                            self.rideViewModel.rawCount = (self.eventModel.dataArr.count)
//                            self.tblViewMyRide.reloadData()
//                        }
                        
                    }
                    else {
                        
                        if response["error_code"] as! String == "404" {
                            
                            CommonClass.moveToLogOut(viewController: self)
                        }
                        else if response["error_code"] as! String == "403" {
                            
                            viewBackSearch.isHidden = true
                            self.view.bringSubviewToFront(viewNoEvent)
                            viewNoEvent.isHidden = false
                          //  CommonClass.moveToLogOut(viewController: self)
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
            else {
                print("No Access")
                AlertView.instance.showAlert(message: strLocationPrivacy, image: "IC_ErrorIcon", alertType: .success)
            }
            
        }
        else {
            
            print("Location services are not enabled")
            AlertView.instance.showAlert(message: strLocationEnable, image: "IC_ErrorIcon", alertType: .success)
        }
        
    }
    
}





