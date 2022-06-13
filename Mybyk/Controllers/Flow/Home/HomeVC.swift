//
//  HomeVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 23/06/21.
//

import UIKit
import Toaster
import GoogleMaps
import CoreLocation
import DropDown
import CoreText
import CoreImage
import libxml2
import QuartzCore
import CoreGraphics
import Foundation

class HomeVC: CommonViewController, UploadImageDelegateProtocol,UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func Image()
    {
        self.botomPopUploadDoc.willMove(toParent: nil)
        self.botomPopUploadDoc.view.removeFromSuperview()
        self.botomPopUploadDoc.removeFromParent()
        
        
        self.botomPopUplo = self.storyboard?.instantiateViewController(withIdentifier: "HomeUploadDocumentVc") as? HomeUploadDocumentVc
        self.botomPopUplo.delegate = self
        //  botomPopUploadDoc.delegate = self
        self.botomPopUplo.strStationIDGet = self.CovertID
        self.addChild(self.botomPopUplo)
        self.view.addSubview(self.botomPopUplo.view)
        self.botomPopUploadDoc.didMove(toParent: self)
        
        let height = self.view.frame.height
        let width  = self.view.frame.width
        self.botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    @IBOutlet weak var viewTerms: UIView!
    @IBOutlet weak var viewBackSearch: UIView!
    @IBOutlet weak var lbTerms: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnSidePopup: UIButton!
    @IBOutlet weak var lblCurrentAddress: UILabel!
    @IBOutlet weak var consMapViewBottom: NSLayoutConstraint!
    
    @IBOutlet var viewSearchTopConstant: NSLayoutConstraint!
    @IBOutlet var btnRestrictedUploadDocument: UIButton!
    @IBOutlet var btnRestrictedOkay: UIButton!
    @IBOutlet var viewRestricted: UIView!
    @IBOutlet var lbRestrictedHubDesc: UILabel!
    //  var locationManager: CLLocationManager!
    var locationManager = CLLocationManager()
    
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    var arrAllHubList = NSArray()
    var left_popups_latlong = NSDictionary()
    
    @IBOutlet var lbRestrictedTitle: UILabel!
    @IBOutlet var viewRestrictedHubHeightConst: NSLayoutConstraint!
    var dicHomeData = [String: Any]()
    var CovertID  : String!
    
    var path = GMSMutablePath()
    var polyline = GMSPolyline()
    var botomPop = HomeBottomPopupVC()
    var botomPopUploadDoc = HomeDocVc()
    var botomPopUplo : HomeUploadDocumentVc!
    var RequestHub = HomeRequestedHub()
    
    //HomeDocVc
    var isLocationUpdate : Bool? = false
    
    var strTearmsURL : String?
    
    @IBOutlet var viewTermsCondition: UIView!
    @IBOutlet var btnTermsAgree: UIButton!
    
    @IBOutlet var viewNearestMyHub: UIView!
    var selectedMarker = GMSMarker()
    
    var markers = [GMSMarker]()
    
    var RowFromBottomPopupTmpVal = 0
    var RowFromBottomPopupTmpVal1 = 0
    
    var FromSelectBike = 0
    
    var strCurrentSeletedHubID = String()
    
    var Currentindex : Int!
    
    var strFromOngoingRide : String?
    
    var strRequestHubDetail : String!
    
    
    var SearchLocation = String()
    var sidePopupHideShow = String()
    @IBOutlet var viewSelectDoc: UIView!
    
    @IBOutlet var btnSelectDocument: UIButton!
    @IBOutlet var btnDocCenter: UIButton!
    @IBOutlet var btnDocSubmit: UIButton!
    @IBOutlet var viewUploadImageCenter: UIView!
    @IBOutlet var lbDocSecondImage: UILabel!
    @IBOutlet var viewDocSecondImageHeightConst: NSLayoutConstraint!
    @IBOutlet var ViewDocSecondImage: UIView!
    @IBOutlet var lbDocFirstImage: UILabel!
    @IBOutlet var viewFirstImageHeightConst: NSLayoutConstraint!
    @IBOutlet var viewFirstImage: UIView!
    @IBOutlet var btnTopImageUpload: UIButton!
    @IBOutlet var ViewDocTopImageHeightConst: NSLayoutConstraint!
    @IBOutlet var viewDocTopImageUpload: UIView!
    @IBOutlet var viewDocImageInnerHeightConst: NSLayoutConstraint!
    @IBOutlet var viewDocImageInner: UIView!
    @IBOutlet var txtDocIdNumber: UITextField!
    @IBOutlet var txtSelectDoc: UITextField!
    @IBOutlet var viewDocMainHeightConst: NSLayoutConstraint!
    @IBOutlet var viewDocMain: UIView!
    
    var strStationIDGet = String()
    let dropDownDoc = DropDown()
    var selectedImageData = [Data]()
    var selectedImageName = [String]()
    var checkUploadDoc = false
    var arrDocList = [String]()
    var arrDocListID = [String]()
    var strDocId : String!
    var checkFlagGetTypeIdCard = false
    
    var HeightConst : CGFloat!
    
    var BackFromSearck : String!
    
    var strSearchAddress : String!
    var strSearchLat : String!
    var strSearchLog : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
       
        
        self.setUIOnScreen()
        // theView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        
        if checkUploadDoc == false
        {
            viewDocMain.isHidden = true
            viewDocMainHeightConst.constant = 0
        }
        
       
        
        //viewDocMain.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 10.0)
        viewDocMain.roundCorners(corners: [.topLeft, .topRight], radius: 15.0, rect: self.view.frame)
        
        viewSelectDoc.viewTextFieldShadowBorderViewForOngoing()
        txtDocIdNumber.viewTextFieldShadowBorderViewForOngoing()
        viewDocImageInner.viewTextFieldShadowBorderViewForOngoing()
        viewFirstImage.layer.cornerRadius = 3.0
        ViewDocSecondImage.layer.cornerRadius = 3.0
        btnDocSubmit.layer.cornerRadius = 8.0
        txtDocIdNumber.setLeftPaddingPoints(5)
        txtSelectDoc.setLeftPaddingPoints(5)
        
        NotificationCenter.default.removeObserver(self)
        
        
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(ReloadHome(_:)),
                         name: NSNotification.Name("ReloadHome"),object: nil)
        
    }
    @IBAction func btnSubmitClicked(_ sender: Any)
    {
        if txtSelectDoc.text == "SELECT DOCUMENT"
        {
            let toast = Toast(text: "Please select document", delay: 0.0, duration: Delay.long)
             toast.show()
            return
        }
        if txtDocIdNumber.text == ""
        {
            let toast = Toast(text: "Please enter ID proof number", delay: 0.0, duration: Delay.long)
             toast.show()
            return
        }
        if selectedImageName.count == 0
        {
            let toast = Toast(text: "Please select image", delay: 0.0, duration: Delay.long)
             toast.show()
            return
        }
        print("image",selectedImageName.count)
        print("Data",selectedImageData.count)
        
        //WsDocType
        
        /*
         @POST("WsGetDocumentTypes.php$versionCode")
         @Multipart
         fun uploadDocument(
             @Part("action") action: RequestBody, "action": "getTypes","documentType" : "true" ,
             @Part("id") id: RequestBody, (Selected Doc ID)
             @Part("idNumberTrue") idNumberTrue: RequestBody, "true"
             @Part("requestID") requestID: RequestBody, " "
             @Part("idNumber") idNumber: RequestBody, "txtid number"
             @Part docImages: Array<MultipartBody.Part?>, "image"
             @Header("authkey") authKey: String,
         ): Call<ApiResponse>
         */
        self.SubmitDoc(mediaData: selectedImageData)
    }
    func SubmitDoc(mediaData: [Data]) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.submitDocData(media: mediaData, dictionary: ["action":"upload", "id": strDocId!,"idNumberTrue" :"true", "requestID":"", "idNumber": txtDocIdNumber.text!]) {[self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["error_code"] as! String == "404" {
                
                CommonClass.moveToLogOut(viewController: self)
            }
            else
            {
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
             //   print(FromRideSummary)
//                let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
//                self.navigationController?.pushViewController(selectBik, animated: true)
              //  let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
              //  self.navigationController?.pushViewController(homeVC, animated: true)
            }
            
//            if response["is_error"] as! String == "false" {
//
//
//
//            }
//            else {
//
//                if response["error_code"] as! String == "404" {
//
//                    CommonClass.moveToLogOut(viewController: self)
//                }
//                else {
//
//                    let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
//                    toast.show()
//                }
//
//            }
            
        } blockError: { error in
            
            CommonClass.removeProgressHudCycling(viewController: self)
        }
        
    }
    @IBAction func btnDocSecondImageCancelClicked(_ sender: Any)
    {
        print(self.selectedImageName.count)
        print(self.selectedImageName[0])
       // print(self.selectedImageName[1])
        
        if self.selectedImageName.count == 0
        {
           
        }
        if self.selectedImageName.count == 1
        {
            self.selectedImageName.remove(at: 0)
            
            self.viewDocTopImageUpload.isHidden = true
            self.btnTopImageUpload.isUserInteractionEnabled = false
            
            self.viewUploadImageCenter.isHidden = false
            self.btnDocCenter.isUserInteractionEnabled = true
            
            self.ViewDocTopImageHeightConst.constant = 0
            self.viewDocMainHeightConst.constant = 350
           // self.vieewUploadDocImageHeightConst.constant = 350
            
            self.viewDocImageInnerHeightConst.constant = 150
            
            self.viewFirstImageHeightConst.constant = 0
            self.viewFirstImage.isHidden = true
            
            self.ViewDocSecondImage.isHidden = true
            self.viewDocSecondImageHeightConst.constant = 0
            
            self.selectedImageData.removeAll()
            self.selectedImageName.removeAll()
            
        }
        if self.selectedImageName.count == 2
        {
            self.selectedImageName.remove(at: 1)
            
            self.viewDocTopImageUpload.isHidden = false
            self.btnTopImageUpload.isUserInteractionEnabled = true
            
            self.viewUploadImageCenter.isHidden = true
            self.btnDocCenter.isUserInteractionEnabled = false
            
         //   self.viewDocFirstImage.isHidden = false
          //  self.lbDocFirstImage.text = self.selectedImageName[0]
            
            self.ViewDocTopImageHeightConst.constant = 50
            self.viewDocImageInnerHeightConst.constant = 110
            
            
            self.viewDocSecondImageHeightConst.constant = 0
            self.ViewDocSecondImage.isHidden = true
        }
    }
    @IBAction func btnDocFirstImageCancelClicked(_ sender: Any)
    {
        print(self.selectedImageName.count)
        print(self.selectedImageName[0])
     //   print(self.selectedImageName[1])
        if self.selectedImageName.count == 0
        {
            
        }
        if self.selectedImageName.count == 1
        {
            self.selectedImageName.remove(at: 0)
            
            self.viewFirstImageHeightConst.constant = 0
            self.viewFirstImage.isHidden = true
            
            self.viewDocTopImageUpload.isHidden = true
            self.btnTopImageUpload.isUserInteractionEnabled = false
            
            self.viewUploadImageCenter.isHidden = false
            self.btnDocCenter.isUserInteractionEnabled = true
            
            self.ViewDocTopImageHeightConst.constant = 0
            self.viewDocImageInnerHeightConst.constant = 150
            
            self.viewDocMainHeightConst.constant = 350
        }
        if self.selectedImageName.count == 2
        {
            self.selectedImageName.remove(at: 0)
            
            self.viewFirstImageHeightConst.constant = 0
            self.viewFirstImage.isHidden = true
            
            self.viewDocTopImageUpload.isHidden = false
            self.btnTopImageUpload.isUserInteractionEnabled = true
            
            self.viewUploadImageCenter.isHidden = true
            self.btnDocCenter.isUserInteractionEnabled = false
            
            self.ViewDocTopImageHeightConst.constant = 50
            self.viewDocImageInnerHeightConst.constant = 110
        }
        
    }
    @IBAction func btnTopImageClicked(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            
            let img = UIImagePickerController()
            img.delegate = self
            img.sourceType = .camera
            img.mediaTypes = ["public.image"]
            img.allowsEditing = false
            self.checkUploadDoc = true
            self.present(img, animated: true, completion: nil)
        }
    }
    @IBAction func btnSelectDocClicked(_ sender: Any)
    {
        print(dropDownDoc.dataSource)
        if dropDownDoc.dataSource.count == 1
        {
            
        }
        else
        {
            dropDownDoc.show()
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {return}
        
        print(mediaType)
        
        switch mediaType
        {
        case "public.movie":
            // Handle movie here
            let videoUrl = info[UIImagePickerController.InfoKey.mediaURL]
          //  self.lblMediaFileName.text = "\(getCurrentTimeStamp()).mov"
            
            if let videoData = NSData(contentsOf: videoUrl as! URL) {
                
                print(videoData.length)
              //  self.recordedVideoData = videoData
            }
            
            //self.consViewImageBackHeight.constant = 66.0
            break
            
        case "public.image":
            // Handle Image here
            let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
           // self.lblMediaFileName.text = "\(getCurrentTimeStamp()).jpeg"
            
           /* if let data:Data = tempImage.jpegData(compressionQuality: 1.0)
            {
                print(data.count)
            }*/
            let data = tempImage.compress(to: 300)
            print(data.count)
           // let imgData = data as NSData
            
            print("Image COUNT",data.count)
            
            let strName = "\(self.getCurrentTimeStamp()).png"
            print(strName)
            
            
            if self.selectedImageName.count == 2
            {
                viewDocTopImageUpload.isHidden = true
                btnTopImageUpload.isUserInteractionEnabled = false
            }
            else
            {
                viewDocTopImageUpload.isHidden = false
                btnTopImageUpload.isUserInteractionEnabled = true
                self.selectedImageData.append(data)
                self.selectedImageName.append(strName)
            }
           // self.consViewImageBackHeight.constant = 66.0
            break
            
        default:
            break
        }
        self.dismiss(animated: true)
        {
            print("Images DATA",self.selectedImageName)
            /*
             self.viewDocUploadFirstImageHeightConst.constant = 0
             self.viewDocFirstImage.isHidden = true
             self.viewDocUploadSecondImageHeightConst.constant = 0
             self.viewDocUploadSecondImage.isHidden = true
             */
            if self.selectedImageName.count == 0
            {
                self.viewDocTopImageUpload.isHidden = true
                self.btnTopImageUpload.isUserInteractionEnabled = false
                
                self.viewUploadImageCenter.isHidden = false
                self.btnDocCenter.isUserInteractionEnabled = true
                
                self.ViewDocTopImageHeightConst.constant = 0
                self.viewDocImageInnerHeightConst.constant = 150
                
            
            }
            else if self.selectedImageName.count == 1
            {
                self.viewDocTopImageUpload.isHidden = false
                self.btnTopImageUpload.isUserInteractionEnabled = true
                
                self.viewUploadImageCenter.isHidden = true
                self.btnDocCenter.isUserInteractionEnabled = false
                
                self.viewFirstImage.isHidden = false
                self.viewFirstImageHeightConst.constant = 36
                
                self.lbDocFirstImage.text = self.selectedImageName[0]
                
                self.ViewDocTopImageHeightConst.constant = 50
                self.viewDocImageInnerHeightConst.constant = 110
                
                
              //  self.viewDocFirstImage.isHidden = false
                
                
            }
            else if self.selectedImageName.count == 2
            {
                self.viewDocTopImageUpload.isHidden = true
                self.btnTopImageUpload.isUserInteractionEnabled = false
                
                self.viewUploadImageCenter.isHidden = true
                self.btnDocCenter.isUserInteractionEnabled = false
                
                self.ViewDocTopImageHeightConst.constant = 0
                self.viewDocImageInnerHeightConst.constant = 120
                
                
                self.viewFirstImage.isHidden = false
                self.ViewDocSecondImage.isHidden = false
                
                self.lbDocFirstImage.text = self.selectedImageName[0]
                self.lbDocSecondImage.text = self.selectedImageName[1]
                
                self.viewFirstImageHeightConst.constant = 36
                self.viewDocSecondImageHeightConst.constant = 36
                
              //  self.viewDocUploadSecondImage.isHidden = false
            }
            else
            {
                self.viewDocTopImageUpload.isHidden = false
                self.btnTopImageUpload.isUserInteractionEnabled = true
                
                self.viewUploadImageCenter.isHidden = true
                self.btnDocCenter.isUserInteractionEnabled = false
                
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true)
        {
          //  self.checkUploadDoc = true
        }
        //self.dismiss(animated: true, completion: nil)
    }
    func appMovedToForeground() {
        print("App moved to ForeGround!")
    }
    @objc func appMovedToBackground() {
        print("App moved to Background!")
    }
    @objc func ReloadHome(_ notification: Notification)
    {
        self.selectedImageName.removeAll()
        self.selectedImageData.removeAll()
        viewDocMain.isHidden = true
        viewDocMainHeightConst.constant = 0
        
      //  mapView.settings.myLocationButton = false
        
        if UserDefaults.standard.value(forKey: "FromSearchLocation") != nil
        {
            RequestHub.willMove(toParent: nil)
            RequestHub.view.removeFromSuperview()
            RequestHub.removeFromParent()
            
            UserDefaults.standard.removeObject(forKey: "FromSearchLocation")
            UserDefaults.standard.synchronize()
        }
        else
        {
            consMapViewBottom.constant = 0
            
            mapView.isMyLocationEnabled = true
          //  mapView.settings.myLocationButton = false
        }
       
        botomPop.willMove(toParent: nil)
        botomPop.view.removeFromSuperview()
        botomPop.removeFromParent()
        
        self.removeChild()
        
//        print("SUPER VIEW",self.view.superview!)
      
        self.FromSelectBike = 0
        
        self.homeAPICall(ValueFrom: "FromBasic", strLt: "", strlog: "")
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        
        self.GetCurrentAddressUsingMarkerLocation(strLat: "\(currentLocation.coordinate.latitude)", strLong: "\(currentLocation.coordinate.longitude)")
       
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
    
        if checkUploadDoc == false
        {
            viewDocMain.isHidden = true
            viewDocMainHeightConst.constant = 0
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        if checkUploadDoc == false
        {
            viewDocMain.isHidden = true
            viewDocMainHeightConst.constant = 0
        }
        if ((self.view.superview?.isKind(of: HomeDocVc.self)) != nil)
        {
            
            botomPopUploadDoc.willMove(toParent: nil)
            botomPopUploadDoc.view.removeFromSuperview()
            botomPopUploadDoc.removeFromParent()
        }
        
        if self.arrAllHubList.count != 0
        {
            if UserDefaults.standard.value(forKey: "ValueRequest") != nil
            {
                self.addRequestHubPopup()
            }
            else
            {
                if  self.checkUploadDoc == true
                {
                    viewDocMain.isHidden = false
                    viewDocMainHeightConst.constant = 350
                }
                else
                {
                    viewDocMain.isHidden = true
                    viewDocMainHeightConst.constant = 0
                    
                    if BackFromSearck == "CurrentLocation"
                    {
                        if strSearchLat == ""
                        {
                            self.mapView.clear()
                            self.locationManager.startUpdatingLocation()
                        }
                    }
                    else if BackFromSearck == "SearchLocation"
                    {
                        if strSearchLat != ""
                        {
                            let lat:CLLocationDegrees = Double(strSearchLat)!
                            let lon:CLLocationDegrees = Double(strSearchLog)!
                            
                            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 18.0)
                            mapView.animate(to: camera)
                            
                            
                            self.lblCurrentAddress.text = strSearchAddress
                            
                            FromSelectBike = Currentindex
                            self.removeChild()
                           
                             self.searchAPICall(strLat: strSearchLat, strLong: strSearchLog)
                        }
                    }
                    else if BackFromSearck == "Back"
                    {
                        if strSearchLat == ""
                        {
                            if Currentindex == nil
                            {
                                Currentindex = 0
                            }
                            FromSelectBike = Currentindex
                            
                          //  botomPop.index = FromSelectBike
                            
                            self.addBottomPopupView()
                        }
                    }
                    else
                    {
                        self.addBottomPopupView()
                    }
                    
                }
               
              //  self.addBottomPopupView()
                
                
              /*  print(SearchLocation)
                
               
                if SearchLocation == ""
                {
                  /*  print(SearchLocation)
                   // print(Currentindex!)
                    if Currentindex == nil
                    {
                        Currentindex = 0
                    }
                    FromSelectBike = Currentindex*/
                    FromSelectBike = 0
                    self.addBottomPopupView()
                    
                   
                }
                else if SearchLocation == "FromSearchLocation"
                {
                   
                    
                  /*  print(SearchLocation)
                    print(Currentindex!)
//                    if Currentindex == nil
//                    {
//                        Currentindex = 0
//                    }
                    FromSelectBike = Currentindex*/
                    if BackFromSearck != nil
                    {
                        print(BackFromSearck!)
                        if BackFromSearck == "Search"
                        {
                            print(BackFromSearck!)
                        }
                        if BackFromSearck == "Back"
                        {
                            if Currentindex == nil
                            {
                                Currentindex = 0
                            }
                            FromSelectBike = Currentindex
                            self.addBottomPopupView()
                            print(BackFromSearck!)
                        }
                    }
                    
                    
                   // self.addBottomPopupView()
                }
                else if SearchLocation == "FromCurrentLocation"
                {
                    FromSelectBike = 0
                    self.addBottomPopupView()
                }
                else
                {
                    if  self.checkUploadDoc == true
                    {
                        viewDocMain.isHidden = false
                        viewDocMainHeightConst.constant = 350
                    }
                    else
                    {
                        viewDocMain.isHidden = true
                        viewDocMainHeightConst.constant = 0
                        
                        self.addBottomPopupView()
                    }
                  //  self.addBottomPopupView()
                }*/
               
            }
            
        }
        else
        {
            
        }
        
        if strFromOngoingRide == "OngoingRide"
        {
            viewNearestMyHub.isHidden = false
            btnSidePopup.isHidden = true
            viewSearchTopConstant.constant = 100
        }
        else
        {
            viewNearestMyHub.isHidden = true
            if sidePopupHideShow == ""
            {
                btnSidePopup.isHidden = true
            }
            else if sidePopupHideShow == "false"
            {
                btnSidePopup.isHidden = true
            }
            else
            {
                btnSidePopup.isHidden = false
            }
            viewSearchTopConstant.constant = 41
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        if checkUploadDoc == false
        {
            viewDocMain.isHidden = true
            viewDocMainHeightConst.constant = 0
        }
        
        self.removeChild()
        isLocationUpdate = false
        
    }
    @objc func RemoveDoc(notification: Notification)
    {
        // Take Action on Notification
    }
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("RemoveDocFromHome"), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        let botomPopUploAgail = self.storyboard?.instantiateViewController(withIdentifier: "HomeUploadDocumentVc") as! HomeUploadDocumentVc
        //  botomPopUploadDoc.delegate = self
        
        botomPopUploAgail.strStationIDGet = self.CovertID
        self.addChild(botomPopUploAgail)
        self.view.addSubview(botomPopUploAgail.view)
        botomPopUploAgail.didMove(toParent: self)
        
        let height = self.view.frame.height
        let width  = self.view.frame.width
        botomPopUploAgail.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    // ********** All Button Actions **********//
    //MARK: - Button Action
    
    @IBAction func btnTCClicked(_ sender: Any)
    {
        guard let url = URL(string: strTearmsURL ?? "") else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @IBAction func btnAgreeClicked(_ sender: Any)
    {
        self.UpdateTermsAPICall()
    }
    func UpdateTermsAPICall()
    {
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        CommonClass.loadProgressHudCycling(viewController: self)
        
        APIService.sharedInstance.UpdateTearms(dictionary: ["userlat": "\(currentLocation.coordinate.latitude)","userlong" : "\(currentLocation.coordinate.longitude)", "termsandcondition": "1"])
        { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                self.viewTermsCondition.removeFromSuperview()
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                 toast.show()
//
//
                
            }
            else {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    @IBAction func btnNearestHubBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnRestrictedUploadDocumentClicked(_ sender: Any)
    {
    }
    @IBAction func btnRestrictedHubOkayClicked(_ sender: Any)
    {

    }
    @IBAction func ActionSearch(_ sender: UIButton)
    {
      //  self.removeChild()
        
        let searchLoc = self.storyboard?.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
        searchLoc.delegate = self
       // print(self.Currentindex!)
        if Currentindex == nil
        {
            Currentindex = 0
        }
        print(self.Currentindex!)
        searchLoc.indexLocationSearch = self.Currentindex
        
        
        
        if strSearchLat != nil
        {
            print(strSearchLat!)
        }
      //  print(strSearchLat)
        
       // searchLoc.checkFlagCurrentLocationORNot
        consMapViewBottom.constant = 0
        self.navigationController?.pushViewController(searchLoc, animated: true)
        
    }
    
    @IBAction func ActionSidePopupOpen(_ sender: UIButton)
    {
        self.addSidePopupView()
        self.btnSidePopup.isHidden = true
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool
    {
        guard let lat = mapView.myLocation?.coordinate.latitude,
              let lng = mapView.myLocation?.coordinate.longitude else { return false }
    
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 18.0)
        mapView.animate(to: camera)
        
        return true
        
    }
    //MARK: - Dynamic label height
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

// ************************************************** //
// MARK:- Search Location Lat Long Delegate Methods
// ************************************************** //

extension HomeVC : SetindexForTopScrollTable,SetindexForTop
{
    func SetBackTableIndex(RowVal: Int)
    {
        print(RowVal)
        RowFromBottomPopupTmpVal = RowVal
    }
    func SetBackIndex(RowVal : Int)
    {
        print(RowVal)
        RowFromBottomPopupTmpVal1 = RowVal
    }
}
extension HomeVC : searchLocationLatLongDelegateProtocol
{
    func sendSearchLocationLatLong(strLat: String, strLong: String, strAddress: String, strCheckFromSearchLocation: String)
    {
        
        SearchLocation = strCheckFromSearchLocation
    
        if strLat == "" {
            self.mapView.clear()
            self.locationManager.startUpdatingLocation()
        }
        else
        {
            
            let lat:CLLocationDegrees = Double(strLat)!
            let lon:CLLocationDegrees = Double(strLong)!
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 18.0)
            mapView.animate(to: camera)
            
            
            self.lblCurrentAddress.text = strAddress
            
            
            self.removeChild()
            if SearchLocation == "FromCurrentLocation"
            {
                 FromSelectBike = 0
                
            }
            if SearchLocation == "FromSearchLocation"
            {
                BackFromSearck = "Search"
                FromSelectBike = 0
            }
             self.searchAPICall(strLat: strLat, strLong: strLong)
        }
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension HomeVC {
    
    func setUIOnScreen()
    {
        consMapViewBottom.constant = 0
        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()

        mapView.delegate = self

        mapView.settings.myLocationButton = false
        mapView.isMyLocationEnabled = true
        mapView.mapType = .normal

        checkLocationAuthorizationStatus()

        viewBackSearch.shadowZ100(frame: viewBackSearch.frame)

        btnTermsAgree.layer.cornerRadius = 4.0
        viewTerms.layer.cornerRadius = 4.0
        
        //Rubik Regular 15.0
        
        //I have read and agree to all  T & C.
        
      /*  let strTermAndCondition = self.lbTerms.text
       
        let strString = "I have read and agree to all  "
      // let strHight = "T & C."
       
       let textRange = NSRange(location: 30, length: strTermAndCondition!.count - strString.count)
       let textRangeBlue = NSRange(location: 0, length: strTermAndCondition!.count)
       let attributedText = NSMutableAttributedString(string: strTermAndCondition!)
       attributedText.addAttribute(.font, value: UIFont(name: "Rubik Medium", size: 15.0)!, range: textRangeBlue)
     
       attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0), range: textRange)
       self.lbTerms.attributedText = attributedText*/
        
    }
    func addRequestHubPopup() -> Void
    {
        mapView.isMyLocationEnabled = false
     //   mapView.settings.myLocationButton = false
        
        botomPop.willMove(toParent: nil)
        botomPop.view.removeFromSuperview()
        botomPop.removeFromParent()
        //  consMapViewBottom.constant = 0
        
        if strRequestHubDetail == nil
        {
            
        }
        else
        {
            RequestHub = self.storyboard?.instantiateViewController(withIdentifier: "HomeRequestedHub") as! HomeRequestedHub
            RequestHub.strDetail = strRequestHubDetail
            RequestHub.consMapViewBottomRequestHub = consMapViewBottom
        }
        
        self.addChild(RequestHub)
        self.view.addSubview(RequestHub.view)
        RequestHub.didMove(toParent: self)
        let height = view.frame.height
        let width  = view.frame.width
        RequestHub.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height )
    }
    func addSidePopupView()
    {
        let sidePop = self.storyboard?.instantiateViewController(withIdentifier: "HomeSidePopupVC") as! HomeSidePopupVC
        sidePop.btnSidePopup = btnSidePopup
        print(left_popups_latlong)
        sidePop.sideMenuArry = left_popups_latlong
        
        
        let yComponent = UIScreen.main.bounds.height - UIScreen.main.bounds.height + 99
        sidePop.view.frame = CGRect(x: self.view.frame.minX + 20 - self.view.frame.width - 40, y: yComponent, width: view.frame.width, height: 50)
       // sidePop.view.frame = CGRect(x: self.view.frame.minX + 20 - self.view.frame.width - 40, y: yComponent, width: view.frame.width, height: view.frame.height)
        self.addChild(sidePop)
        self.view.addSubview(sidePop.view)
        sidePop.didMove(toParent: self)
    }
    
    func addBottomPopupView()
    {
        if UserDefaults.standard.value(forKey: "ValueRequest") != nil
        {
            RequestHub.willMove(toParent: nil)
            RequestHub.view.removeFromSuperview()
            RequestHub.removeFromParent()
        }
        
        if ((self.view.superview?.isKind(of: HomeDocVc.self)) != nil)
        {
            
            botomPopUploadDoc.willMove(toParent: nil)
            botomPopUploadDoc.view.removeFromSuperview()
            botomPopUploadDoc.removeFromParent()
        }
        
        botomPop = self.storyboard?.instantiateViewController(withIdentifier: "HomeBottomPopupVC") as! HomeBottomPopupVC
        
        botomPop.strongoingRide = strFromOngoingRide
        botomPop.arrHubList = arrAllHubList
        botomPop.strRestrictedHubMessage = dicHomeData["terminalRestricted"] as! String
        
        print(FromSelectBike)
        self.botomPop.index = FromSelectBike
        //self.Currentindex = FromSelectBike
        
        if strFromOngoingRide == "OngoingRide"
        {
            
            botomPop.didSelectRow = { (indexPath, fromIndex) in
                
                print(indexPath.row)
                self.mapDirectionRequestAPI(indexPath: indexPath)
                
                self.botomPop.index = indexPath.row
                
               
                
                let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
                
                let lat = Double(dicHub["terminalLat"] as! String) ?? 0.0
                let long = Double(dicHub["terminalLong"] as! String) ?? 0.0
                
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18.0)
                self.mapView.animate(to: camera)
                
                //self.mapView.clear()
                let marker = self.markers[indexPath.row]
                
                for mark in self.markers
                {
                    if mark == marker {
                        
                        let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                        infoWindow.lblCycleCount.text = mark.snippet
                        mark.iconView = infoWindow
                        
                        self.GetCurrentAddressUsingMarkerLocation(strLat: String(lat), strLong: String(long))
                    }
                    else
                    {
                        
                        let dicMarkerData = marker.userData as? [String: Any]
                        let index = dicMarkerData!["index"] as? Int
                        print(index!)
                        
                        let dicHub = self.arrAllHubList[index!] as! [String: Any]
                        print(dicHub)
                        
                        let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
                        mark.iconView = infoWindow
                    }
                    
                }
                self.selectedMarker = marker
                
                
                //   self.mapDirectionRequestAPI(indexPath: indexPath)
                
                //  self.botomPop.index = indexPath.row
            }
        }
        else
        {
            botomPop.didSelectRow = { (indexPath,fromIndex) in
                
                self.mapDirectionRequestAPI(indexPath: indexPath)
                
                self.botomPop.index = indexPath.row
                print("SELECT FROM HOME",self.botomPop.index!)
                self.botomPop.ChangeIndex = self.RowFromBottomPopupTmpVal
                self.Currentindex = indexPath.row
                if fromIndex == true
                {
                    
                    let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
                   
                    if dicHub["terminalIsPrivate"] as! Int == 1
                    {
                        
                        if let StrStationID = dicHub["idStations"] as? String
                        {
                            self.CovertID = StrStationID
                        }
                        else
                        {
                            let StrStationIDCovert = dicHub["idStations"]
                            self.CovertID  = "\(StrStationIDCovert as! Int)"
                        }
                        self.Currentindex = indexPath.row
                        self.checkHubRestrictedOrNotAPICall(strIdStation: self.CovertID, indexPath: indexPath)
                    }
                    else
                    {
                        
                        let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                        selectBik.delegate = self
                        
                        if let StrStationID = dicHub["idStations"] as? String
                        {
                            selectBik.strStationID = StrStationID
                        }
                        else
                        {
                            let StrStationIDCovert = dicHub["idStations"]
                            selectBik.strStationID = "\(StrStationIDCovert as! Int)"
                        }
                        print(indexPath.row)
                        self.Currentindex = indexPath.row
                        selectBik.index = indexPath.row
                        self.SearchLocation = ""
                        self.navigationController?.pushViewController(selectBik, animated: true)
                    }
                    
                }
                else
                {
                    let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
                    
                    let lat = Double(dicHub["terminalLat"] as! String) ?? 0.0
                    let long = Double(dicHub["terminalLong"] as! String) ?? 0.0
                    
                    let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18.0)
                    self.mapView.animate(to: camera)
                    
                    //self.mapView.clear()
                    let marker = self.markers[indexPath.row]
                    
                    for mark in self.markers
                    {
                        
                        if mark == self.selectedMarker
                        {
                            
                            if self.selectedMarker == marker
                            {
                                
                                let dicMarkerData = marker.userData as? [String: Any]
                                let index = dicMarkerData!["index"] as? Int
                                print(index!)
                                
                                let dicHub = self.arrAllHubList[index!] as! [String: Any]
                                print(dicHub)
                                
                                
                                let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                                if let StrStationID = dicHub["idStations"] as? String
                                {
                                    selectBik.strStationID = StrStationID
                                }
                                else
                                {
                                    let StrStationIDCovert = dicHub["idStations"]
                                    selectBik.strStationID = "\(StrStationIDCovert as! Int)"
                                }
                                print(indexPath.row)
                                self.Currentindex = indexPath.row
                                selectBik.index = indexPath.row
                                self.SearchLocation = ""
                                self.navigationController?.pushViewController(selectBik, animated: true)
                            }
                            else {
                                
                                
                                let dicMarkerData = marker.userData as? [String: Any]
                                let index = dicMarkerData!["index"] as? Int
                                print(index!)
                                
                                let dicHub = self.arrAllHubList[index!] as! [String: Any]
                                print(dicHub)
                                
                                let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
                                mark.iconView = infoWindow
                                
                            }
                            
                        }
                        else if mark == marker {
                            
                            let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                            infoWindow.lblCycleCount.text = mark.snippet
                            mark.iconView = infoWindow
                            
                            self.GetCurrentAddressUsingMarkerLocation(strLat: String(lat), strLong: String(long))
                        }
                        
                    }
                    self.selectedMarker = marker
                    
                }
                
                
            }
        }
        
        botomPop.ActionMapDirection =
        { (index) in
            
            print(index)
            self.openGoogleMap(index: index)
        }
        
        botomPop.didSelectRowTop =
        { (index) in
            print(index)
        }
        
        
        
        self.addChild(botomPop)
        self.view.addSubview(botomPop.view)
        botomPop.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        botomPop.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height )
        
    }
    
    func openGoogleMap(index: Int) {
        
        let dicHub = self.arrAllHubList[index] as! [String: Any]
        
        if !(dicHub["terminalLat"] as! String == "") && !(dicHub["terminalLong"] as! String == "") {
            
            let lat = Double(dicHub["terminalLat"] as! String) ?? 0.0
            let long = Double(dicHub["terminalLong"] as! String) ?? 0.0
            
            if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
                
                if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            else {
                
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                    UIApplication.shared.open(urlDestination)
                }
            }
            
        }
        
    }
    
    func setAllHubOnMap() {
        
        //     self.mapView.clear()
        
        print(self.arrAllHubList)
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        
        markers.removeAll()
        
        
        for i in 0..<self.arrAllHubList.count
        {
            
            let dicHub = self.arrAllHubList[i] as! [String: Any]
            
            //  print(dicHub)
            if !(dicHub["terminalLat"] as! String == "") && !(dicHub["terminalLong"] as! String == "") {
                
                let lat = Double(dicHub["terminalLat"] as! String) ?? 0.0
                let long = Double(dicHub["terminalLong"] as! String) ?? 0.0
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                marker.title = dicHub["stationName"]! as? String
                marker.snippet = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
                
                
                if let StrStationID = dicHub["idStations"] as? String
                {
                    marker.userData = ["index": i, "event": "false", "stationID": "\(StrStationID)"]
                }
                else
                {
                    let StrStationIDCovert = dicHub["idStations"]
                    marker.userData = ["index": i, "event": "false", "stationID": "\(StrStationIDCovert as! Int)"]
                    
                }
                
                var bounds = GMSCoordinateBounds()
                
                if i == 0
                {
                    print(dicHub)
                    
                    
                    bounds = bounds.includingCoordinate(marker.position)
                    let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
                    mapView.animate(with: update)
                    mapView.setMinZoom(1, maxZoom: 18)
                    
                    self.selectedMarker = marker
                    let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                    infoWindow.lblCycleCount.text = "\(dicHub["allCycleCount"] as? NSNumber ?? 0)"
                    marker.iconView = infoWindow
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.mapDirectionRequestAPI(indexPath: indexPath)
                    
                }
                else
                {
                    
                    let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
                    marker.iconView = infoWindow
                }
                
                markers.append(marker)
                marker.map = self.mapView
                
                
            }
            
            
        }
        
        
    }
    
    func setAllHubOnMapAfterTap() {
        
        //        self.mapView.clear()
        
        var marker = GMSMarker()
        var bounds = GMSCoordinateBounds()
        
        var i = 0
        for mar in markers
        {
            
            if mar.iconView is MapPin {
                
                print("Icon view true")
                
            }
            else {
                print("Icon view false")
            }
            
            if self.selectedMarker == mar
            {
                
                marker = mar
                let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                infoWindow.lblCycleCount.text = mar.snippet
                marker.iconView = infoWindow
                
                bounds = bounds.includingCoordinate(marker.position)
                let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
                mapView.animate(with: update)
                mapView.setMinZoom(1, maxZoom: 18)
                
                markers[i] = marker
                
                let dicMark = marker.userData as! [String: Any]
                
                let stationID = dicMark["stationID"] as! String
                
                for j in 0..<arrAllHubList.count
                {
                    let dicHub = self.arrAllHubList[j] as! [String: Any]
                    
                    var getStationID = String()
                    
                    if let StrStationID = dicHub["idStations"] as? String
                    {
                        getStationID = "\(StrStationID)"
                    }
                    else
                    {
                        let StrStationIDCovert = dicHub["idStations"]
                        getStationID = "\(StrStationIDCovert as! Int)"
                        
                    }
                    
                    if stationID == getStationID {
                        
                        let indexPath = IndexPath(row: j, section: 0)
                        self.mapDirectionRequestAPI(indexPath: indexPath)
                    }
                    
                }
                
                
                
            }
            else {
                
                marker = mar
                let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
                marker.iconView = infoWindow
                
                markers[i] = marker
            }
            
            i += 1
        
            marker.map = self.mapView
            
        }
        
        
    }
    
}

// MARK:- Location Manager Delegate Methods
extension HomeVC: CLLocationManagerDelegate {
    
    func showLocationAccessAlert() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
        
    }
    func checkLocationAuthorizationStatus()
    {
        let status = CLLocationManager.authorizationStatus()
        print(status.rawValue)
        
        if status == CLAuthorizationStatus.notDetermined
        {
            print("NotDetermined")
            locationManager.requestWhenInUseAuthorization()
            CLLocationManager.locationServicesEnabled()
            locationManager.requestLocation()
            
        }
        else if status == CLAuthorizationStatus.authorizedAlways
        {
            print("Problem with authorizedAlways")
        }
        else if status == CLAuthorizationStatus.authorizedWhenInUse
        {
            print("Problem with authorizedWhenInUse")
        }
        else if status == CLAuthorizationStatus.denied
        {
            print("Problem with denied")
            showLocationAccessAlert()
        }
        else if status == CLAuthorizationStatus.restricted
        {
            print("Problem with restricted")
        }
        else {
            
            if CLLocationManager.locationServicesEnabled()
            {
                locationManager.requestLocation()
            }
            else{
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
                //   setUIOnScreen()
            }
            print("Problem with authorization")
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        self.locationManager.stopUpdatingLocation()
        print("MAP COUNT................")
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        print("Locationnnnnnnnnnnnnnnnnnnnn")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18.0)
        mapView.animate(to: camera)
        
        
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(location) { placemarks, error in
            
            if (error != nil) {
                
                print("reverse geocode fail: \(error?.localizedDescription ?? "")")
            }
            else {
                
                if placemarks != nil {
                    
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        
                        let pm = placemarks![0]
                        
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + " "
                        }
                        
                        print(addressString)
                        
                        self.lblCurrentAddress.text = addressString
                        
                    }
                    
                }
                
            }
            
        }
        
        if isLocationUpdate == false
        {
            isLocationUpdate = true
            self.homeAPICall(ValueFrom: "FromBasic", strLt: "", strlog: "")
        }
        
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        switch manager.authorizationStatus
        {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager( _ manager: CLLocationManager, didFailWithError error: Error)
    {
        //  locationManager.stopUpdatingLocation()
        //  locationManager.startUpdatingLocation()
        //CLLocationManager.locationServicesEnabled()
        
        print("Error: \(error.localizedDescription)")
    }
}

// MARK:- Google Map Delegate Methods
extension HomeVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let coordinate = mapView.projection.coordinate(for: mapView.center)
    }
    
    func selectData(strLat : String,strLog : String,indexVal : Int) -> Void
    {
        self.removeChild()
        
        self.GetCurrentAddressUsingMarkerLocation(strLat: String(strLat), strLong: String(strLog))
        self.setAllHubOnMapAfterTap()
        
        botomPop.willMove(toParent: nil)
        botomPop.view.removeFromSuperview()
        botomPop.removeFromParent()
        
        botomPop = self.storyboard?.instantiateViewController(withIdentifier: "HomeBottomPopupVC") as! HomeBottomPopupVC
        
        
        botomPop.strongoingRide = strFromOngoingRide
        botomPop.consMapViewBottom = consMapViewBottom
        botomPop.arrHubList = arrAllHubList
        botomPop.strRestrictedHubMessage = dicHomeData["terminalRestricted"] as! String
        self.botomPop.index = indexVal
      
        botomPop.didSelectRow = { (indexPath,fromIndex) in
            
            self.mapDirectionRequestAPI(indexPath: indexPath)
            self.botomPop.index = indexPath.row
            //self.botomPop.ChangeIndex = self.RowFromBottomPopupTmpVal
            
            print(self.RowFromBottomPopupTmpVal)
           
          //  if indexVal == indexPath.row
            if fromIndex == true
            {
                let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
                print(dicHub)
                
                if dicHub["terminalIsPrivate"] as! Int == 1
                {
                    
                    if let StrStationID = dicHub["idStations"] as? String
                    {
                        self.CovertID = StrStationID
                    }
                    else
                    {
                        let StrStationIDCovert = dicHub["idStations"]
                        self.CovertID  = "\(StrStationIDCovert as! Int)"
                    }
                    self.Currentindex = indexPath.row
                    self.checkHubRestrictedOrNotAPICall(strIdStation: self.CovertID, indexPath: indexPath)
                    
                }
                else
                {
                    
                    let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                    selectBik.delegate = self
                    
                    if let StrStationID = dicHub["idStations"] as? String
                    {
                        selectBik.strStationID = StrStationID
                    }
                    else
                    {
                        let StrStationIDCovert = dicHub["idStations"]
                        selectBik.strStationID = "\(StrStationIDCovert as! Int)"
                    }
                    print(indexPath.row)
                    self.Currentindex = indexPath.row
                    selectBik.index = indexPath.row
                    self.SearchLocation = ""
                    self.navigationController?.pushViewController(selectBik, animated: true)
                }
                
            }
            else
            {
                let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
                
                let lat = Double(dicHub["terminalLat"] as! String) ?? 0.0
                let long = Double(dicHub["terminalLong"] as! String) ?? 0.0
                
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18.0)
                self.mapView.animate(to: camera)
                
                //self.mapView.clear()
                let marker = self.markers[indexPath.row]
                
                for mark in self.markers
                {
                    
                    if mark == self.selectedMarker
                    {
                        
                        if self.selectedMarker == marker
                        {
                            
                            let dicMarkerData = marker.userData as? [String: Any]
                            let index = dicMarkerData!["index"] as? Int
                            print(index!)
                            
                            let dicHub = self.arrAllHubList[index!] as! [String: Any]
                            print(dicHub)
                            
                            
                            let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                            if let StrStationID = dicHub["idStations"] as? String
                            {
                                selectBik.strStationID = StrStationID
                            }
                            else
                            {
                                let StrStationIDCovert = dicHub["idStations"]
                                selectBik.strStationID = "\(StrStationIDCovert as! Int)"
                            }
                            print(indexPath.row)
                            self.Currentindex = indexPath.row
                            selectBik.index = indexPath.row
                            self.SearchLocation = ""
                            self.navigationController?.pushViewController(selectBik, animated: true)
                        }
                        else {
                            
                            
                            let dicMarkerData = marker.userData as? [String: Any]
                            let index = dicMarkerData!["index"] as? Int
                            print(index!)
                            
                            let dicHub = self.arrAllHubList[index!] as! [String: Any]
                            print(dicHub)
                            
                            let infoWindow = Bundle.main.loadNibNamed("MapPinWithoutCycle", owner: self, options: nil)!.first! as! MapPinWithoutCycle
                            mark.iconView = infoWindow
                            
                        }
                        
                    }
                    else if mark == marker {
                        
                        let infoWindow = Bundle.main.loadNibNamed("MapPin", owner: self, options: nil)!.first! as! MapPin
                        infoWindow.lblCycleCount.text = mark.snippet
                        mark.iconView = infoWindow
                        
                        self.GetCurrentAddressUsingMarkerLocation(strLat: String(lat), strLong: String(long))
                    }
                    
                }
                self.selectedMarker = marker
                
            }
            
            
        }
        
        botomPop.ActionMapDirection =
        { (index) in
            
            print(index)
            self.openGoogleMap(index: index)
        }
        
        botomPop.didSelectRowTop =
        { (index) in
            print(index)
        }

        self.addChild(botomPop)
        self.view.addSubview(botomPop.view)
        botomPop.didMove(toParent: self)

        let height = view.frame.height
        let width  = view.frame.width
        botomPop.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height )
        
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        checkUploadDoc = false
        viewDocMain.isHidden = true
        viewDocMainHeightConst.constant = 0
        print(marker)
        print(marker.position.latitude)
        
        var isCheck = false
        
        
        if strFromOngoingRide == "OngoingRide"
        {
            self.selectedMarker = marker
            
            
            let strLat = Double(marker.position.latitude)
            let strLog = Double(marker.position.longitude)
            
            let dicMark = marker.userData as! [String: Any]
            let stationID = dicMark["stationID"] as! String
            
            
            for j in 0..<3
            {
                let dicHub = self.arrAllHubList[j] as! [String: Any]
                var getStationID = String()
                
                if let StrStationID = dicHub["idStations"] as? String
                {
                    getStationID = "\(StrStationID)"
                }
                else
                {
                    let StrStationIDCovert = dicHub["idStations"]
                    getStationID = "\(StrStationIDCovert as! Int)"
                    
                }
                
                if stationID == getStationID
                {
                    self.selectData(strLat: String(strLat), strLog: String(strLog) , indexVal : j)
                    isCheck = true
                    break
                }
            }
            
            if isCheck == false
            {
                let strLat = Double(marker.position.latitude)
                let strLog = Double(marker.position.longitude)
                
                
                botomPop.willMove(toParent: nil)
                botomPop.view.removeFromSuperview()
                botomPop.removeFromParent()
                
                self.searchAPICall(strLat: String(strLat), strLong: String(strLog))
                
                self.GetCurrentAddressUsingMarkerLocation(strLat: String(strLat), strLong: String(strLog))
                
                self.setAllHubOnMapAfterTap()
            }
            
            return true
        }
        else
        {
            
            if marker.iconView is MapPin {
                
                let dicMark = marker.userData as! [String: Any]
                let stationID = dicMark["stationID"] as! String
                
                for j in 0..<arrAllHubList.count
                {
                    let dicHub = self.arrAllHubList[j] as! [String: Any]
                    
                    var getStationID = String()
                    
                    if let StrStationID = dicHub["idStations"] as? String
                    {
                        getStationID = "\(StrStationID)"
                    }
                    else
                    {
                        let StrStationIDCovert = dicHub["idStations"]
                        getStationID = "\(StrStationIDCovert as! Int)"
                        
                    }
                    if stationID == getStationID
                    {
                        print("Same ID")
                        print(stationID)
                        print(getStationID)
                        
                        print(dicHub)
                        
                        if dicHub["terminalIsPrivate"] as! Int == 1
                        {
                            
                            if let StrStationID = dicHub["idStations"] as? String
                            {
                                self.CovertID = StrStationID
                            }
                            else
                            {
                                let StrStationIDCovert = dicHub["idStations"]
                                self.CovertID  = "\(StrStationIDCovert as! Int)"
                            }
                            self.Currentindex = j
                            let indexpath = IndexPath(row: j, section: 0)
                            self.checkHubRestrictedOrNotAPICall(strIdStation: self.CovertID, indexPath: indexpath)
                            isCheck = true
                        }
                        else
                        {
                            let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                            if let StrStationID = dicHub["idStations"] as? String
                            {
                                selectBik.strStationID = StrStationID
                            }
                            else
                            {
                                let StrStationIDCovert = dicHub["idStations"]
                                selectBik.strStationID = "\(StrStationIDCovert as! Int)"
                            }
                            //  selectBik.strStationID = "\(dicHub["idStations"] as! Int)"
                            self.Currentindex = j
                            selectBik.index = j
                            SearchLocation = ""
                            self.navigationController?.pushViewController(selectBik, animated: true)
                        }
                        
                    }
                    
                }
                
            }
            else
            {
                self.selectedMarker = marker
                //print(marker.position.latitude)
                
                let strLat = Double(marker.position.latitude)
                let strLog = Double(marker.position.longitude)
                
                let dicMark = marker.userData as! [String: Any]
                let stationID = dicMark["stationID"] as! String
                
                
                for j in 0..<3
                {
                    let dicHub = self.arrAllHubList[j] as! [String: Any]
                    var getStationID = String()
                    
                    if let StrStationID = dicHub["idStations"] as? String
                    {
                        getStationID = "\(StrStationID)"
                    }
                    else
                    {
                        let StrStationIDCovert = dicHub["idStations"]
                        getStationID = "\(StrStationIDCovert as! Int)"
                        
                    }
                    
                    if stationID == getStationID
                    {
                        self.selectData(strLat: String(strLat), strLog: String(strLog) , indexVal : j)
                        isCheck = true
                        break
                    }
                }
                
            }
            
            if isCheck == false
            {
                let strLat = Double(marker.position.latitude)
                let strLog = Double(marker.position.longitude)
                
                
                botomPop.willMove(toParent: nil)
                botomPop.view.removeFromSuperview()
                botomPop.removeFromParent()
                
                //   consMapViewBottom.constant = 0
                self.searchAPICall(strLat: String(strLat), strLong: String(strLog))
                
                self.GetCurrentAddressUsingMarkerLocation(strLat: String(strLat), strLong: String(strLog))
                
                self.setAllHubOnMapAfterTap()
            }
           
            return true
        }
        
        
    }
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension HomeVC {
    
    func GetCurrentAddressUsingMarkerLocation(strLat : String , strLong : String)
    {
        self.locationManager.stopUpdatingLocation()
        let location: CLLocation?
        //locations.last!
        //  print("Location: \(location)")
        print("Locationnnnnnnnnnnnnnnnnnnnn")
        
        location = CLLocation(latitude: Double(strLat)!, longitude: Double(strLong)!)
      
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(location!) { placemarks, error in
            
            if (error != nil) {
                
                print("reverse geocode fail: \(error?.localizedDescription ?? "")")
            }
            else {
                
                if placemarks != nil {
                    
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        
                        let pm = placemarks![0]
                        
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + " "
                        }
                        
                        print(addressString)
                        
                        self.lblCurrentAddress.text = addressString
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    func homeAPICall(ValueFrom: String,strLt: String,strlog: String)
    {
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        
        var strLat : String!
        var strLog : String!
        
        if ValueFrom == "FromBasic"
        {
            
            strLat = "\(currentLocation.coordinate.latitude)"
            strLog = "\(currentLocation.coordinate.longitude)"
            
        }
        else
        {
            botomPop.willMove(toParent: nil)
            botomPop.view.removeFromSuperview()
            botomPop.removeFromParent()
         
            botomPopUploadDoc.willMove(toParent: nil)
            botomPopUploadDoc.view.removeFromSuperview()
            botomPopUploadDoc.removeFromParent()
            
            //  var botomPopUplo : HomeUploadDocumentVc!
            strLat = strLt
            strLog = strlog
        }
        print(strLat!,strLog!)
        
        APIService.sharedInstance.homeAPICall(dictionary: ["userLat": strLat!, "userLong": strLog!, "token": "\(UserDefaults.standard.value(forKey: "deviceToken") as! String)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                self.mapView.clear()
                
                dicHomeData = response["data"] as! [String: Any]
                
                if dicHomeData["show_termsandcondition_popup"] as! String == "true"
                {
                    strTearmsURL = dicHomeData["termsandconditionURL"] as? String
                   // self.viewTermsCondition.center = CGPoint(x: viewTermsCondition.frame.width / 2, y: viewTermsCondition.frame.height / 2)
                    self.viewTermsCondition.frame = (self.view.window?.bounds)!
                    self.view.window?.addSubview(viewTermsCondition)
                }
                
                if self.arrAllHubList.count > 0
                {
                    
                    self.arrAllHubList = NSArray()
                }
                self.arrAllHubList = dicHomeData["allTerminals"] as! NSArray
                print(self.arrAllHubList.count)
                //   print(dicHomeData["referralCode"] as! String)
                
                //                if dicHomeData["referralCode"] as! String == "<null>"
                //                {
                //
                //                }
                //                else
                //                {
                //                    UserDefaults.standard.setValue(dicHomeData["referralCode"] as! String, forKey: "RefereCode")
                //                    UserDefaults.standard.synchronize()
                //                }
                
                
                // print(self.arrAllHubList.count)
                
                strBLEKey = dicHomeData["ble_key"] as! String
                
               
                
             //   UserDefaults.standard.setValue(dicHomeData["show_termsandcondition_popup"] as! String, forKey: "SidePopup")
              //  UserDefaults.standard.synchronize()
                
                /*
                 else if sidePopupHideShow == "false"
                 {
                     btnSidePopup.isHidden = true
                 }
                 else
                 {
                     btnSidePopup.isHidden = false
                 }
                 */
                if (dicHomeData["left_popups_latlong"] as! NSDictionary).count != 0
                {
                    left_popups_latlong = dicHomeData["left_popups_latlong"] as! NSDictionary
                    /*
                     if (leftPopupsLatLong.serverPopupIsAllLocations.equals("1")) {
                     // show
                     } else if (!leftPopupsLatLong.serverPopupRadius.isNullOrEmpty() && !leftPopupsLatLong.serverPopupLatitude.isNullOrEmpty() &&
                         !leftPopupsLatLong.serverPopupLongitude.isNullOrEmpty()) {
                     // show

                     }else{
                     // hide
                     }
                     */
                    let LAtLongData = dicHomeData["left_popups_latlong"] as! [String:Any]
                    
                    print(LAtLongData)
//print(LAtLongData["server_popup_Radius"])
                    if LAtLongData["server_popup_isAllLocations"] as! String == "1"
                    {
                        /*
                         UserDefaults.standard.setValue("SavePopup", forKey: "SidePopup")
                         UserDefaults.standard.synchronize()
                         */
                        
                        if UserDefaults.standard.value(forKey: "SidePopup") == nil
                        {
                            self.addSidePopupView()
                            self.btnSidePopup.isHidden = true
                        }
                        else
                        {
                              btnSidePopup.isHidden = false
                              sidePopupHideShow = "true"
                        }
                       
                        
                        UserDefaults.standard.setValue("SavePopup", forKey: "SidePopup")
                        UserDefaults.standard.synchronize()
                      
                    }
                    else if LAtLongData["server_popup_Radius"] as! String == "" && LAtLongData["server_popup_Longitude"] as! String == "" &&
                             LAtLongData["server_popup_Latitude"] as! String == ""
                     {
                        btnSidePopup.isHidden = true
                        sidePopupHideShow = "false"
                     }
                   else if LAtLongData["server_popup_Radius"] as! String != "" && LAtLongData["server_popup_Longitude"] as! String != "" &&
                            LAtLongData["server_popup_Latitude"] as! String != ""
                    {
                      /* self.addSidePopupView()
                       self.btnSidePopup.isHidden = true
                       
                       UserDefaults.standard.setValue("SavePopup", forKey: "SidePopup")
                       UserDefaults.standard.synchronize()*/
                       
                       if UserDefaults.standard.value(forKey: "SidePopup") == nil
                       {
                           self.addSidePopupView()
                           self.btnSidePopup.isHidden = true
                       }
                       else
                       {
                             btnSidePopup.isHidden = false
                             sidePopupHideShow = "true"
                       }
                       UserDefaults.standard.setValue("SavePopup", forKey: "SidePopup")
                       UserDefaults.standard.synchronize()
                      // btnSidePopup.isHidden = false
                      // sidePopupHideShow = "true"
                    }
                    else
                    {
                        btnSidePopup.isHidden = true
                        sidePopupHideShow = "false"
                    }
                    //sidePopupHideShow = "
                  /*  if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = false
                    }*/
                    
                //    print(left_popups_latlong)
                   
                }
                else
                {
                    btnSidePopup.isHidden = true
                    sidePopupHideShow = "false"
                    /*if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = true
                    }*/
                }
             /*   if (dicHomeData["left_popups_latlong"] as! NSDictionary).count != 0
                //as? [String: Any] != nil
                {
                    left_popups_latlong = dicHomeData["left_popups_latlong"] as! NSDictionary
                    btnSidePopup.isHidden = false
                    
                    
                    print(left_popups_latlong)
                    if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = false
                    }
                    
                    /*
                     "left_popups_latlong" =     {
                     "server_popup_Latitude" = "";
                     "server_popup_Longitude" = "";
                     "server_popup_Radius" = "";
                     "server_popup_image" = "https://staging.ma.greenpedia.in/img/popupimages/_eventimage(1)_1638269746.png";
                     "server_popup_isAllLocations" = 1;
                     "server_popup_text" = "";
                     "server_popup_url" = "https://bit.ly/3xkVMYt";
                     };
                     */
                }
                else
                {
                    btnSidePopup.isHidden = true
                    
                    if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    
                }
                */
                
                if let tabItems = tabBarController?.tabBar.items {
                    let tabItem = tabItems[3]
                    let notifBadge = "\(dicHomeData["unread_pn_count"] as? Int ?? 0)"
                    
                    if notifBadge == "0" {
                        tabItem.badgeValue = nil
                    }
                    else {
                        tabItem.badgeValue = notifBadge
                    }
                    
                    let tabItemRide = tabItems[1]
                    let rideBadge = "\(dicHomeData["current_ride_count"] as? Int ?? 0)"
                    if rideBadge == "0" {
                        tabItemRide.badgeValue = nil
                    }
                    else {
                        tabItemRide.badgeValue = rideBadge
                    }
                    
                    
                }
                
                //consMapViewBottom.constant = 0
                self.addBottomPopupView()
                self.setAllHubOnMap()
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
    
    func searchAPICallFromLocationSearch(strLat: String, strLong: String)
    {
      //  self.removeChild()
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.homeAPICall(dictionary: ["userLat": "\(currentLocation.coordinate.latitude)", "userLong": "\(currentLocation.coordinate.longitude)", "searchplace_lat":strLat, "searchplace_long":strLong, "token": "\(UserDefaults.standard.value(forKey: "deviceToken") as! String)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let dicHomeData = response["data"] as! [String: Any]
                
                
                // self.arrAllHubList = NSArray()
                
                //                var tmpAry = NSArray()
                //                    tmpAry = dicHomeData["allTerminals"] as! NSArray
                
                self.arrAllHubList = dicHomeData["allTerminals"] as! NSArray
                
                
                print(self.arrAllHubList.count)
                
               /* sidePopupHideShow = dicHomeData["show_termsandcondition_popup"] as! String
                
               // UserDefaults.standard.setValue(dicHomeData["show_termsandcondition_popup"] as! String, forKey: "SidePopup")
               // UserDefaults.standard.synchronize()
                
                if (dicHomeData["show_termsandcondition_popup"] as! String) == "false"
                {
                    btnSidePopup.isHidden = true
                    
                  /*  if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = false
                    }*/
                    
                //    print(left_popups_latlong)
                   
                }
                else
                {
                    btnSidePopup.isHidden = false
                }*/
                
               /* if dicHomeData["left_popups_latlong"] as? [String: Any] != nil
                {
                    
                    if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = false
                    }
                }
                else
                {
                    if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    
                }
                */
                
                if let tabItems = tabBarController?.tabBar.items {
                    let tabItem = tabItems[3]
                    let notifBadge = "\(dicHomeData["unread_pn_count"] as? Int ?? 0)"
                    
                    if notifBadge == "0" {
                        tabItem.badgeValue = nil
                    }
                    else {
                        tabItem.badgeValue = notifBadge
                    }
                    
                }
                
                self.mapView.clear()
                
               // self.addBottomPopupView()
                self.setAllHubOnMap()
                
                // func GetCurrentAddressUsingMarkerLocation(strLat : String , strLong : String)
                // self.sendSearchLocationLatLong(strLat:"\(currentLocation.coordinate.latitude)", strLong: <#T##String#>, strAddress: <#T##String#>)
                // func sendSearchLocationLatLong(strLat: String, strLong: String, strAddress: String)
                
            }
            else
            {
                
                if response["error_code"] as! String == "404"
                {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else
                {
                    print(response)
                    strRequestHubDetail = response["message"] as? String
                    
                    self.addRequestHubPopup()
                    /* let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                     toast.show()*/
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    func searchAPICall(strLat: String, strLong: String)
    {
      //  self.removeChild()
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.homeAPICall(dictionary: ["userLat": "\(currentLocation.coordinate.latitude)", "userLong": "\(currentLocation.coordinate.longitude)", "searchplace_lat":strLat, "searchplace_long":strLong, "token": "\(UserDefaults.standard.value(forKey: "deviceToken") as! String)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let dicHomeData = response["data"] as! [String: Any]
                
                
                // self.arrAllHubList = NSArray()
                
                //                var tmpAry = NSArray()
                //                    tmpAry = dicHomeData["allTerminals"] as! NSArray
                
                self.arrAllHubList = dicHomeData["allTerminals"] as! NSArray
                
                
                print(self.arrAllHubList.count)
                
              /*  if dicHomeData["left_popups_latlong"] as? [String: Any] != nil
                {
                    
                    if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = false
                    }
                }
                else
                {
                    if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    
                }*/
              /*  sidePopupHideShow = dicHomeData["show_termsandcondition_popup"] as! String
                
               // UserDefaults.standard.setValue(dicHomeData["show_termsandcondition_popup"] as! String, forKey: "SidePopup")
               // UserDefaults.standard.synchronize()
                
                if (dicHomeData["show_termsandcondition_popup"] as! String) == "false"
                {
                    btnSidePopup.isHidden = true
                    
                  /*  if strFromOngoingRide == "OngoingRide"
                    {
                        self.btnSidePopup.isHidden = true
                    }
                    else
                    {
                        self.btnSidePopup.isHidden = false
                    }*/
                    
                //    print(left_popups_latlong)
                   
                }
                else
                {
                    btnSidePopup.isHidden = false
                }
                */
                if let tabItems = tabBarController?.tabBar.items {
                    let tabItem = tabItems[3]
                    let notifBadge = "\(dicHomeData["unread_pn_count"] as? Int ?? 0)"
                    
                    if notifBadge == "0" {
                        tabItem.badgeValue = nil
                    }
                    else {
                        tabItem.badgeValue = notifBadge
                    }
                    
                }
                
                self.mapView.clear()
                
                //self.removeChild()
                
                self.addBottomPopupView()
                self.setAllHubOnMap()
                
                // func GetCurrentAddressUsingMarkerLocation(strLat : String , strLong : String)
                // self.sendSearchLocationLatLong(strLat:"\(currentLocation.coordinate.latitude)", strLong: <#T##String#>, strAddress: <#T##String#>)
                // func sendSearchLocationLatLong(strLat: String, strLong: String, strAddress: String)
                
            }
            else
            {
                
                if response["error_code"] as! String == "404"
                {
                    
                    CommonClass.moveToLogOut(viewController: self)
                }
                else
                {
                    print(response)
                    strRequestHubDetail = response["message"] as? String
                    
                    self.addRequestHubPopup()
                    /* let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                     toast.show()*/
                }
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
    func mapDirectionRequestAPI(indexPath: IndexPath)
    {
        //   self.mapView.clear()
        
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        
        let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
        
        print(dicHub)
        let lat = Double(dicHub["terminalLat"] as! String) ?? 0.0
        let long = Double(dicHub["terminalLong"] as! String) ?? 0.0
        
        let session = URLSession.shared
        let url = URL(string: "\(urlMapDirection)directions/json?origin=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&destination=\(lat),\(long)&mode=walking&key=\(mapDirectionAPIKey)")!
        
        let task = session.dataTask(with: url){ data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                print("error in JSONSerialization")
                return
            }
            
            guard let routes = jsonResult["routes"] as? [Any] else {
                return
            }
            
            if routes.count == 0 {
                return
            }
            
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            
            guard let overviewPolyline = route["overview_polyline"] as? [String: Any] else {
                return
            }
            
            guard let polyLineString = overviewPolyline["points"] as? String else {
                return
            }
            
            DispatchQueue.main.async {
                
                self.path = GMSMutablePath(fromEncodedPath: polyLineString)!
                self.polyline.map = nil
                self.polyline = GMSPolyline(path: self.path)
                self.polyline.strokeWidth = 3.0
                self.polyline.strokeColor = UIColor(named: Color_Primary)!
                
                let styles: [GMSStrokeStyle] = [.solidColor(UIColor(named: Color_Primary)!), .solidColor(.clear)]
                let scale = 1.0 / self.mapView.projection.points(forMeters: 1, at: self.mapView.camera.target)
                let solidLine = NSNumber(value: 10.0 * Float(scale))
                let gap = NSNumber(value: 4.0 * Float(scale))
                self.polyline.spans = GMSStyleSpans(self.polyline.path!, styles, [solidLine, gap], GMSLengthKind.rhumb)
                
                self.polyline.map = self.mapView
            }
            
        }
        task.resume()
        
    }
   
    func checkHubRestrictedOrNotAPICall(strIdStation : String, indexPath: IndexPath) {
        
        //        botomPop.willMove(toParent: nil)
        //        botomPop.view.removeFromSuperview()
        //        botomPop.removeFromParent()
        //
        //        self.botomPopUploadDoc.willMove(toParent: nil)
        //        self.botomPopUploadDoc.view.removeFromSuperview()
        //        self.botomPopUploadDoc.removeFromParent()
        
        var currentLocation = CLLocation()
        currentLocation = locationManager.location!
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.checkHubRestrictedOrNotAPICall(dictionary: ["userLat": "\(currentLocation.coordinate.latitude)", "userLong": "\(currentLocation.coordinate.longitude)", "token": "\(UserDefaults.standard.value(forKey: "deviceToken") as! String)", "checkRestrictedHub":strIdStation]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            print(strIdStation)
            if response["error_code"] as! String == "404" {
                
                CommonClass.moveToLogOut(viewController: self)
            }
            else
            {
                
                //                let dicHub = self.arrAllHubList[indexPath.row] as! [String: Any]
                //                let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                //                selectBik.strStationID = "\(dicHub["idStations"] as! Int)"
                //                self.navigationController?.pushViewController(selectBik, animated: true)
                
                
                let dataResponce = response["data"] as! [String : Any]
                print(dataResponce)
                print(dataResponce["restrictedHubMessage"] as! String)
                //print(response["docError"])
               //CGFloat
                if dataResponce["restrictedHubMessage"] as! String == ""
                {
                    print(HeightConst!)
                    print(dataResponce["restrictedHubMessage"] as! String)
                }
                else
                {
                  //  print(HeightConst!)
                    print(dataResponce["restrictedHubMessage"] as! String)
                    
                 //   if HeightConst != nil
                  //  {
                  //  DispatchQueue.main.async {
                        
                        
                          //  HeightConst = self.heightForView(text: dataResponce["restrictedHubMessage"] as! String, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self.view.frame.width - 40)
                  //  }
                      //  print(HeightConst!)
                  //  }
                   
                    
                }
                // if num.stringValue == "1" && dataResponce["docError"] as! String == "true"
               // {
                if let any = dataResponce["restrictedHub"]
                {
                    if let num = any as? NSNumber
                    {
                        if num.stringValue == "1" && dataResponce["docError"] as! String == "true"
                        {
                            /*
                             var strVal : String!
                             var strDocError : String!
                             var strDocVerify : String!
                             */
                            botomPop.willMove(toParent: nil)
                            botomPop.view.removeFromSuperview()
                            botomPop.removeFromParent()
                            
                            //  consMapViewBottom.constant = 0
                            
                            botomPopUploadDoc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDocVc") as! HomeDocVc
                            
                            botomPopUploadDoc.strVal = "1"
                            botomPopUploadDoc.strDocError = "true"
                            botomPopUploadDoc.strDocVerify = ""
                           // botomPopUploadDoc.heightLAbel = HeightConst
                            botomPopUploadDoc.strDocText = response["message"] as? String
                            botomPopUploadDoc.strStationID = CovertID
                            botomPopUploadDoc.indexVal = Currentindex
                            
                            self.addChild(botomPopUploadDoc)
                            self.view.addSubview(botomPopUploadDoc.view)
                            botomPopUploadDoc.didMove(toParent: self)
                            
                            let height = view.frame.height
                            let width  = view.frame.width
                            botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                            
                            botomPopUploadDoc.openDocumentVc =
                            {
                                self.removeChild()
                                
                                self.botomPopUploadDoc.willMove(toParent: nil)
                                self.botomPopUploadDoc.view.removeFromSuperview()
                                self.botomPopUploadDoc.removeFromParent()
                                
                               // self.consMapViewBottom.constant = 0
                                
                                self.viewDocTopImageUpload.isHidden = true
                                self.btnTopImageUpload.isUserInteractionEnabled = false
                                
                                self.viewUploadImageCenter.isHidden = false
                                self.btnDocCenter.isUserInteractionEnabled = true
                                
                                self.ViewDocTopImageHeightConst.constant = 0
                                self.viewDocImageInnerHeightConst.constant = 150
                                
                                self.viewDocMain.isHidden = false
                                self.viewDocMainHeightConst.constant = 350
                                
                                self.viewFirstImage.isHidden = true
                                self.ViewDocSecondImage.isHidden = true
                                self.btnTopImageUpload.isUserInteractionEnabled = false
                                self.viewDocTopImageUpload.isHidden = true
                                print("UPLOAD")
                                
                                self.strStationIDGet = self.CovertID
                                
                                if self.checkFlagGetTypeIdCard == false
                                {
                                    self.getDocType()
                                }
                                
                               /* self.botomPopUploadDoc.willMove(toParent: nil)
                                self.botomPopUploadDoc.view.removeFromSuperview()
                                self.botomPopUploadDoc.removeFromParent()
                                
                                
                                self.botomPopUplo = self.storyboard?.instantiateViewController(withIdentifier: "HomeUploadDocumentVc") as? HomeUploadDocumentVc
                                self.botomPopUplo.delegate = self
                                //  botomPopUploadDoc.delegate = self
                                self.botomPopUplo.strStationIDGet = self.CovertID
                                self.addChild(self.botomPopUplo)
                                self.view.addSubview(self.botomPopUplo.view)
                                self.botomPopUploadDoc.didMove(toParent: self)
                                
                                let height = self.view.frame.height
                                let width  = self.view.frame.width
                                self.botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                                
                                */
                            }
                            /*
                             
                             
                             */
                            /*
                             Rubik Regular 16.0
                             20 - 20
                             
                             func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
                             {
                             let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
                             label.numberOfLines = 0
                             label.lineBreakMode = NSLineBreakMode.byWordWrapping
                             label.font = font
                             label.text = text
                             label.sizeToFit()
                             
                             return label.frame.height
                             }
                             */
                            
                            /*   btnRestrictedOkay.isHidden = true
                             btnRestrictedUploadDocument.isHidden = false
                             btnRestrictedUploadDocument.layer.cornerRadius = 5.0
                             
                             viewRestricted.isHidden = false
                             self.view.bringSubviewToFront(viewRestricted)
                             
                             //   let strDesc = dataResponce["restricted_message"] as? String
                             lbRestrictedHubDesc.text = response["message"] as? String
                             
                             let heightLAbel = self.heightForView(text: (response["message"] as? String)!, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self.view.frame.width - 40)
                             // lbRestrictedTitle.text = strDesc!.uppercased()
                             
                             viewRestrictedHubHeightConst.constant = heightLAbel + 200*/
                            
                            //                               UIView.animate(withDuration: 0.2)
                            //                               {
                            //                                   self.view.layoutIfNeeded()
                            //                               }
                            
                        }
                        else if num.stringValue == "1" && dataResponce["docError"] as! String == "true" && dataResponce["docVerifyError"] as! String == "false"
                        {
                            botomPop.willMove(toParent: nil)
                            botomPop.view.removeFromSuperview()
                            botomPop.removeFromParent()
                            
                            //consMapViewBottom.constant = 0
                            
                            botomPopUploadDoc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDocVc") as! HomeDocVc
                            
                            botomPopUploadDoc.strVal = "1"
                            botomPopUploadDoc.strDocError = "true"
                            botomPopUploadDoc.strDocVerify = "false"
                          //  botomPopUploadDoc.heightLAbel = HeightConst
                            botomPopUploadDoc.strDocText = response["message"] as? String
                            botomPopUploadDoc.strStationID = CovertID
                            botomPopUploadDoc.indexVal = Currentindex
                            self.addChild(botomPopUploadDoc)
                            self.view.addSubview(botomPopUploadDoc.view)
                            botomPopUploadDoc.didMove(toParent: self)
                            
                            let height = view.frame.height
                            let width  = view.frame.width
                            botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                            
                            //    viewRestrictedHubHeightConst.constant = 270
                            
                            
                            /*  btnRestrictedOkay.isHidden = true
                             btnRestrictedUploadDocument.isHidden = false
                             btnRestrictedUploadDocument.layer.cornerRadius = 5.0
                             viewRestricted.isHidden = false
                             self.view.bringSubviewToFront(viewRestricted)
                             
                             lbRestrictedHubDesc.text = response["message"] as? String
                             
                             
                             let heightLAbel = self.heightForView(text: (response["message"] as? String)!, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self.view.frame.width - 40)
                             // lbRestrictedTitle.text = strDesc!.uppercased()
                             
                             viewRestrictedHubHeightConst.constant = heightLAbel + 200*/
                            //                               UIView.animate(withDuration: 0.2)
                            //                               {
                            //                                   self.view.layoutIfNeeded()
                            //                               }
                        }
                        else if num.stringValue == "1" && dataResponce["docError"] as! String == "false" && dataResponce["docVerifyError"] as! String == "true"
                        {
                            botomPop.willMove(toParent: nil)
                            botomPop.view.removeFromSuperview()
                            botomPop.removeFromParent()
                            
                            //   consMapViewBottom.constant = 0
                            
                            botomPopUploadDoc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDocVc") as! HomeDocVc
                            
                            botomPopUploadDoc.strVal = "1"
                            botomPopUploadDoc.strDocError = "false"
                            botomPopUploadDoc.strDocVerify = "true"
                        //    botomPopUploadDoc.heightLAbel = HeightConst
                            botomPopUploadDoc.strDocText = response["message"] as? String
                            botomPopUploadDoc.strStationID = CovertID
                            botomPopUploadDoc.indexVal = Currentindex
                            self.addChild(botomPopUploadDoc)
                            self.view.addSubview(botomPopUploadDoc.view)
                            botomPopUploadDoc.didMove(toParent: self)
                            
                            let height = view.frame.height
                            let width  = view.frame.width
                            botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                            
                            /*   viewRestrictedHubHeightConst.constant = 270
                             btnRestrictedOkay.isHidden = false
                             btnRestrictedUploadDocument.isHidden = true
                             viewRestricted.isHidden = false
                             self.view.bringSubviewToFront(viewRestricted)
                             let strDesc = dataResponce["restricted_message"] as? String
                             lbRestrictedHubDesc.text = dataResponce["restrictedHubMessage"] as? String
                             //  lbRestrictedTitle.text = strDesc!.uppercased()
                             
                             UIView.animate(withDuration: 0.2)
                             {
                             self.view.layoutIfNeeded()
                             }*/
                            
                            
                        }
                        else if num.stringValue == "1" && dataResponce["docError"] as! String == "false" && dataResponce["docVerifyError"] as! String == "false"
                        {
                            
                            botomPop.willMove(toParent: nil)
                            botomPop.view.removeFromSuperview()
                            botomPop.removeFromParent()
                            
                            //     consMapViewBottom.constant = 0
                            
                            botomPopUploadDoc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDocVc") as! HomeDocVc
                            
                            botomPopUploadDoc.strVal = "1"
                            botomPopUploadDoc.strDocError = "false"
                            botomPopUploadDoc.strDocVerify = "false"
                       //     botomPopUploadDoc.heightLAbel = HeightConst
                            botomPopUploadDoc.strDocText = response["message"] as? String
                            botomPopUploadDoc.strStationID = CovertID
                            botomPopUploadDoc.indexVal = Currentindex
                            self.addChild(botomPopUploadDoc)
                            self.view.addSubview(botomPopUploadDoc.view)
                            botomPopUploadDoc.didMove(toParent: self)
                            
                            let height = view.frame.height
                            let width  = view.frame.width
                            botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                            /* viewRestrictedHubHeightConst.constant = 270
                             btnRestrictedOkay.isHidden = false
                             btnRestrictedUploadDocument.isHidden = true
                             viewRestricted.isHidden = false
                             self.view.bringSubviewToFront(viewRestricted)
                             let strDesc = dataResponce["restricted_message"] as? String
                             lbRestrictedHubDesc.text = dataResponce["restrictedHubMessage"] as? String
                             //   lbRestrictedTitle.text = strDesc!.uppercased()
                             UIView.animate(withDuration: 0.2)
                             {
                             self.view.layoutIfNeeded()
                             }*/
                        }
                        else
                        {
                            
                            botomPop.willMove(toParent: nil)
                            botomPop.view.removeFromSuperview()
                            botomPop.removeFromParent()
                            
                            //    consMapViewBottom.constant = 0
                            botomPopUploadDoc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDocVc") as! HomeDocVc
                            
                            botomPopUploadDoc.strVal = "1"
                            botomPopUploadDoc.strDocError = "true"
                            botomPopUploadDoc.strDocVerify = "true"
                         //   botomPopUploadDoc.heightLAbel = HeightConst
                            botomPopUploadDoc.strDocText = response["message"] as? String
                            botomPopUploadDoc.strStationID = CovertID
                            botomPopUploadDoc.indexVal = Currentindex
                            self.addChild(botomPopUploadDoc)
                            self.view.addSubview(botomPopUploadDoc.view)
                            botomPopUploadDoc.didMove(toParent: self)
                            
                            let height = view.frame.height
                            let width  = view.frame.width
                            botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
                            
                            /*  viewRestrictedHubHeightConst.constant = 270
                             btnRestrictedOkay.isHidden = false
                             btnRestrictedUploadDocument.isHidden = true
                             viewRestricted.isHidden = false
                             self.view.bringSubviewToFront(viewRestricted)
                             let strDesc = dataResponce["restricted_message"] as? String
                             lbRestrictedHubDesc.text = dataResponce["restrictedHubMessage"] as? String
                             //   lbRestrictedTitle.text = strDesc!.uppercased()
                             UIView.animate(withDuration: 0.2)
                             {
                             self.view.layoutIfNeeded()
                             }*/
                        }
                        
                    }
                    else if let str = any as? String
                    {
                        
                    }
                }
                
                
                
                //                if (restrictedHub.equals("1") && docError.equals("true")){
                //                    showRestrictedHub(msgTitle,restrictedMsg)
                //                    // Upload document button valu popup
                //                }
                //                else if (restrictedHub.equals("1") && docError.equals("true") && docVerifyError.equals("false")){
                //                    showRestrictedHub(msgTitle,restrictedMsg)
                //                    // Upload document button valu popup
                //                }
                //
                //                else if (restrictedHub.equals("1") && docError.equals("false") && docVerifyError.equals("true")){
                //                    showPrivateHUBMsg(msgTitle,restrictedMsg,"0")
                //                    // Okay button valu popup
                //                }
                //
                //                else if (restrictedHub.equals("1") && docError.equals("false") && docVerifyError.equals("false")){
                //                    showPrivateHUBMsg(msgTitle,restrictedMsg,"1")
                //                    // Okay button valu popup
                //                }
                //                else{
                //                    showPrivateHUBMsg(msgTitle,restrictedMsg,"0")
                //                    // Okay button valu popup
                //                }
                
                
                
                
                
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    //MARK: - API Call for GetDoc
    func getDocType()
    {
        //WsDocType
        //action : LOGIN
        //WsMobileBannerImage
        //DataBannerImageModel
        // CommonClass.loadProgressHudCycling(viewController: self)
        /*
         action => getTypes
         documentType = > true
         idStations =>
         */
        var CovertID : String!
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getDocType(dicBannerBodyParama:["action": "getTypes","documentType" : "true" ,"idStations" : strStationIDGet]) { result in
            
            CommonClass.removeProgressHudCycling(viewController: self)
            print(result)
            //do {
            if result["error_code"] as! String == "403"
            {
                //  CommonClass.moveToLogOut(viewController: self)
                AlertView.instance.showAlert(message: "\(result["message"] as! String)", image: "IC_ErrorIcon", alertType: .success)
            }
            else if result["error_code"] as! String == "404"
            {
                CommonClass.moveToLogOut(viewController: self)
            }
            else
            {
                
                let DicData =  result["data"] as! NSDictionary
                let docType = DicData.value(forKey: "documentTypes") as! NSArray
                
                
                self.arrDocList.append("SELECT DOCUMENT")
                self.arrDocListID.append("SELECT DOCUMENT")
                
                for i in 0..<docType.count
                {
                   let dicV = docType[i] as! NSDictionary
                    let getName = dicV.value(forKey: "name")
                    
                    if let StrStationID = dicV.value(forKey: "id") as? String
                    {
                        CovertID = StrStationID
                    }
                    else
                    {
                        let StrStationIDCovert = dicV.value(forKey: "id")
                        CovertID  = "\(StrStationIDCovert as! Int)"
                        print(CovertID!)
                     //   CovertID  = StrStationIDCovert
                    }
                    
                    self.arrDocList.append(getName as! String)
                    self.arrDocListID.append(CovertID)
                   // self.arrDocList.append(getName as! String)
                }
                
                self.txtSelectDoc.text = self.arrDocList[0]
                
                self.dropDownDoc.dataSource = self.arrDocList
                
                self.dropDownDoc.anchorView = self.btnSelectDocument
                
                self.dropDownDoc.selectionAction = { (index: Int, item: String) in
                     
                     print("Selected item: \(item) at index: \(index)")
                    
                    // self.strSelectedStateIndex = "\(index)"
                    // self.txtCity.text = ""
                    self.strDocId = self.arrDocListID[index]
                    
                    print("STRING ID",self.strDocId!)
                    
                     self.txtSelectDoc.text = item
                 }
                self.checkFlagGetTypeIdCard = true
               // arrDocList
                
              
                
            }
           
        } blockerror: { error in
//             print(error)
//               CommonClass.removeProgressHudCycling(viewController: self)
        }
    }
    
}
extension UIViewController
{
    func removeChild()
    {
        self.children.forEach
        {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
    }
}






