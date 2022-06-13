//
//  ReportIssueDetailVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 15/12/21.
//

import UIKit
import Toaster
import SVGKit
import CoreText
import CoreImage
import libxml2
import QuartzCore
import CoreGraphics
import Lottie


class ReportIssueDetailVC: CommonViewController {
    @IBOutlet var viewInnerErroePopup: UIView!
    @IBOutlet var viewMainErrorPopup: UIView!
    @IBOutlet var viewNavi: UIView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var viewBackIssueImg: UIView!
    @IBOutlet var imgViewIssueType: UIImageView!
    @IBOutlet var lblIssueType: UILabel!
    @IBOutlet var txtViewMessage: UITextView!
    @IBOutlet var tblViewIssueList: UITableView!
    @IBOutlet var viewBackImageName: UIView!
    @IBOutlet weak var lblMediaFileName: UILabel!
    @IBOutlet var lbUploadImageError: NSLayoutConstraint!
    
    @IBOutlet var viewErrorUploadImage: UIView!
    @IBOutlet var viewLottie: AnimationView!
    
    @IBOutlet var lbTextviewPlaceHolder: UILabel!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    @IBOutlet var consTblViewHeight: NSLayoutConstraint!
    @IBOutlet var consViewImageBackHeight: NSLayoutConstraint!
    
    var dicIssueType = [String:Any]()
    var arrCycleStatus = NSArray()
    var dicCurrentRideData = [String: Any]()
    
    var timer = Timer()
    var strSelectedIssue = String()
    
    var recordedVideoData = NSData()
    var selectedImageData = NSData()
    //    var selectedImageData = Data()
    
    
    
    var strRedirectHomeSelectBikeDetail = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        
        //self.tabBarController?.tabBar.isHidden = true
        self.getCycleStatusAPICall()
        self.setUIOnScreen()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let imageGet = dicIssueType["cycleIssueTypeImage"] as! String
        let svg = URL(string: imageGet)!
        let data = try? Data(contentsOf: svg)
        let receivedimage: SVGKImage = SVGKImage(data: data)
        imgViewIssueType.image = receivedimage.uiImage
    }
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionUploadImage(_ sender: UIButton) {
        
        let alertCntrl = UIAlertController(title: "CAPTURE IMAGE OR VIDEO", message: "", preferredStyle: .actionSheet)
        alertCntrl.addAction(UIAlertAction(title: "IMAGE", style: .default, handler: { action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let img = UIImagePickerController()
                img.delegate = self
                img.sourceType = .camera
                img.mediaTypes = ["public.image"]
                img.allowsEditing = false
                self.present(img, animated: true, completion: nil)
            }
            
        }))
        alertCntrl.addAction(UIAlertAction(title: "VIDEO", style: .default, handler: { action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let img = UIImagePickerController()
                img.delegate = self
                img.sourceType = .camera
                img.mediaTypes = ["public.movie"]
                img.allowsEditing = false
                self.present(img, animated: true, completion: nil)
            }
            
        }))
        alertCntrl.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        self.present(alertCntrl, animated: true, completion: nil)
    }
    
    @IBAction func ActionRemoveImage(_ sender: UIButton) {
        
        recordedVideoData = NSData()
        selectedImageData = NSData()
        self.consViewImageBackHeight.constant = 0.0
    }
    
    @IBAction func ActionSubmit(_ sender: UIButton) {
        
        print(dicCurrentRideData)
     //   print("QRCode = \(dicCurrentRideData["lock_QR_code"] as! String)")
        print(strSelectedIssue)
        
//        if strSelectedIssue != ""
//        {
//
//
//
//        }
        if strSelectedIssue == ""
        {
            //
            let toast = Toast(text: "Please Select An Issue", delay: 0.0, duration: Delay.long)
            toast.show()
        }
//        else if lbTextviewPlaceHolder.isHidden == false
//        {
//            txtViewMessage.viewTextFieldErrorBorder()
//            return
//        }
        else
        {
            let intIndex = Int(strSelectedIssue)
            let dicStat = arrCycleStatus[intIndex!] as! [String: Any]
            print(dicStat)
            let idCycleStatus = dicStat["idCycleStatus"] as! Int
            print("cycleStatus\(idCycleStatus)")
            print("cycle_issue_media_type = IMAGE or VIDEO")
            
            if strRedirectHomeSelectBikeDetail == ""
            {
                if recordedVideoData.length == 0
                {
                    if selectedImageData.length != 0
                    {
                        lbUploadImageError.constant = 0
                        viewErrorUploadImage.isHidden = true
                    }
                    else
                    {
                        lbUploadImageError.constant = 15
                        viewErrorUploadImage.isHidden = false
                    }
                   // return
                }
                else
                {
                    lbUploadImageError.constant = 0
                    viewErrorUploadImage.isHidden = true
                    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "VIDEO")
                }
                
                if selectedImageData.length == 0
                {
                    
                      if recordedVideoData.length != 0
                      {
                          lbUploadImageError.constant = 0
                          viewErrorUploadImage.isHidden = true
                      }
                      else
                      {
                          lbUploadImageError.constant = 15
                          viewErrorUploadImage.isHidden = false
                      }
                  //  return
                }
                else
                {
                    viewErrorUploadImage.isHidden = true
                    lbUploadImageError.constant = 0
                    self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "IMAGE")
                  
                }
            }
            else
            {
                if recordedVideoData.length == 0
                {
                    if selectedImageData.length != 0
                    {
                        lbUploadImageError.constant = 0
                        viewErrorUploadImage.isHidden = true
                    }
                    else
                    {
                        lbUploadImageError.constant = 15
                        viewErrorUploadImage.isHidden = false
                    }
                   // return
                }
                else
                {
                    viewErrorUploadImage.isHidden = true
                    lbUploadImageError.constant = 0
                    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["lock_QR_code"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "VIDEO")
                }
                
                if selectedImageData.length == 0
                {
                  
                    if recordedVideoData.length != 0
                    {
                        lbUploadImageError.constant = 0
                        viewErrorUploadImage.isHidden = true
                    }
                    else
                    {
                        lbUploadImageError.constant = 15
                        viewErrorUploadImage.isHidden = false
                    }
                  //  return
                }
                else
                {
                    lbUploadImageError.constant = 0
                    viewErrorUploadImage.isHidden = true
                    self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["lock_QR_code"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "IMAGE")
                  
                }
            }
           
        }
        print("cycleStatus - 55")
        
        //        let dicStat = arrCycleStatus[indexPath.row] as! [String: Any]
        //
        //        cell.lblIssueType.text = "\(dicStat["Status"] as! String)"
        //
        //        if strSelectedIssue == "\(indexPath.row)" {
        
    }
    
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ReportIssueDetailVC : UITextViewDelegate {
    
    func setUIOnScreen() {
        
        txtViewMessage.delegate = self
        
        viewInnerErroePopup.layer.cornerRadius = 2.0
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        lbUploadImageError.constant = 0
        self.viewBackIssueImg.layer.cornerRadius = 8.0
        self.viewBackIssueImg.shadowZ100(frame: viewBackIssueImg.frame)
        self.btnSubmit.layer.cornerRadius = 8.0
        self.viewBackImageName.layer.cornerRadius = 8.0
        self.txtViewMessage.layer.cornerRadius = 8.0
        self.txtViewMessage.layer.borderWidth = 1.0
        self.txtViewMessage.layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1).cgColor
        
        self.consViewBackDetailWidth.constant = self.view.frame.width
        self.consViewImageBackHeight.constant = 0.0
        
        self.imgViewIssueType.sd_setImage(with: URL(string: "\(dicIssueType["cycleIssueTypeImage"] as! String)"), placeholderImage: UIImage(named: ""))
        self.lblIssueType.text = "\(dicIssueType["cycleIssueTypeName"] as? String ?? "")"
        
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        lbTextviewPlaceHolder.isHidden = true
        txtViewMessage.viewTextFieldPrimaryBorder()
    }
    func textViewDidChange(_ textView: UITextView)
    {
        if txtViewMessage.text.isEmpty
        {
            lbTextviewPlaceHolder.isHidden = false
        }
        else
        {
            lbTextviewPlaceHolder.isHidden = true
        }
      
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ReportIssueDetailVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {return}
        
        print(mediaType)
        
        switch mediaType {
        case "public.movie":
            // Handle movie here
            let videoUrl = info[UIImagePickerController.InfoKey.mediaURL]
            self.lblMediaFileName.text = "\(getCurrentTimeStamp()).mov"
            
            if let videoData = NSData(contentsOf: videoUrl as! URL) {
                
                print(videoData.length)
                self.recordedVideoData = videoData
            }
            
            self.consViewImageBackHeight.constant = 66.0
            lbUploadImageError.constant = 0.0
            break
            
        case "public.image":
            // Handle Image here
            let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.lblMediaFileName.text = "\(getCurrentTimeStamp()).jpeg"
            
            if let data:Data = tempImage.jpegData(compressionQuality: 1.0) {
                print(data.count)
                self.selectedImageData = data as NSData
            }
            
            self.consViewImageBackHeight.constant = 66.0
            lbUploadImageError.constant = 0.0
            break
            
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension ReportIssueDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCycleStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! ReportDetailTblCell
        
        let dicStat = arrCycleStatus[indexPath.row] as! [String: Any]
        
        cell.lblIssueType.text = "\(dicStat["Status"] as! String)"
        
        if strSelectedIssue == "\(indexPath.row)" {
            
            //IC_CircleGreen
            cell.imgViewRadio.image = UIImage(named: "IC_CircleGreen")
        }
        else {
            //
            //IC_Radio
            cell.imgViewRadio.image = UIImage(named: "IC_CicleGray")
        }
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        strSelectedIssue = "\(indexPath.row)"
        tblViewIssueList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    
    
}


// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension ReportIssueDetailVC {
    
    func getCycleStatusAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getCycleStatusAPICall(dictionary: ["cycleStatus": "\(dicIssueType["idCycleStatus"] as! String)"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
           // print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicCycleStatusData = response["data"] as! [String: Any]
                
                self.arrCycleStatus = dicCycleStatusData["cycle_status"] as! NSArray
                self.consTblViewHeight.constant = 44.0 * CGFloat(self.arrCycleStatus.count)
                self.tblViewIssueList.reloadData()
            }
            else {
                
                  
                
                if response["error_code"] as! String == "404" {

                   // CommonClass.moveToLogOut(viewController: self)
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
    
    func submitReportIssueAPIWebServiceCall(mediaData: NSData, QRCode: String, cycleStatus: String, cycle_issue_media_type: String) {
        
        print(cycle_issue_media_type)
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.submitReportIssueAPIWebServiceCall(media: mediaData, dictionary: ["QRCode":QRCode, "cycleStatus": cycleStatus, "note":"\(txtViewMessage.text!)", "cycle_issue_media_type": cycle_issue_media_type]) { response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "true" {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
            }
            else {
               // self.navigationController?.popViewController(animated: true)
                
            
                CommonClass.removeProgressHudCycling(viewController: self)
                
                self.viewMainErrorPopup.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(self.viewMainErrorPopup)
                self.view.bringSubviewToFront(self.viewMainErrorPopup)
                
                self.viewLottie!.contentMode = .scaleAspectFit
                self.viewLottie!.loopMode = .playOnce
                self.viewLottie!.animationSpeed = 0.5
                self.viewLottie.play()
                
                self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
                
                //let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
               // self.navigationController?.pushViewController(homeVC, animated: true)
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
    @objc func timerAction()
    {
        self.viewMainErrorPopup.removeFromSuperview()
        
        if strRedirectHomeSelectBikeDetail == ""
        {
            if let viewControllers = self.navigationController?.viewControllers
            {
                for controller in viewControllers
                {
                    print(controller)
                    if controller is SelectBikeVC
                    {
                        if let destinationViewController = navigationController?.viewControllers
                            .filter(
                                {$0 is SelectBikeVC})
                                .first {
                            navigationController?.popToViewController(destinationViewController, animated: true)
                        }
                    }
                }
            }
        }
        else
        {
            let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(tabVC, animated: true)
            
//            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        
    }
    
}











