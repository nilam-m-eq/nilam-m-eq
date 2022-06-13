//
//  ReportIssueWriteVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 15/12/21.
//

import UIKit
import Toaster
import Lottie

class ReportIssueWriteVC: CommonViewController {
    @IBOutlet var viewNavi: UIView!
    @IBOutlet var btnSkip: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtViewMessage: UITextView!
    @IBOutlet weak var viewBackImageName: UIView!
    @IBOutlet weak var lblMediaFileName: UILabel!
    
    @IBOutlet var viewUploadImageErrorHeightConst: NSLayoutConstraint!
    @IBOutlet var lbComment: UILabel!
    @IBOutlet var viewConfirmParentView: UIView!
    
    @IBOutlet var viewConfirmMainView: UIView!
    @IBOutlet weak var consViewImageBackHeight: NSLayoutConstraint!
    @IBOutlet var viewAnimationConfirmLotttie: AnimationView!
    
    var dicCurrentRideData = [String: Any]()
    
    var recordedVideoData = NSData()
    var selectedImageData = NSData()
    
    var strRedirectHomeSelectBike = String()
    
    var timer = Timer()
    
    var imageTemp = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
        self.setUIOnScreen()
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
    
    @IBAction func ActionSkip(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionSubmit(_ sender: UIButton)
    {
        if lbComment.isHidden == false
        {
            txtViewMessage.viewTextFieldErrorBorder()
            return
        }
        else
        {
            print(dicCurrentRideData)
            print(strRedirectHomeSelectBike)
       
            /*
             let idCycleStatus = dicStat["idCycleStatus"] as! Int
             print("cycleStatus\(idCycleStatus)")
             print("cycle_issue_media_type = IMAGE or VIDEO")
             
             if strRedirectHomeSelectBikeDetail == ""
             {
                 if recordedVideoData.length == 0
                 {
                     lbUploadImageError.constant = 15
                    // return
                 }
                 else
                 {
                     lbUploadImageError.constant = 0
                     self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "IMAGE")
             */
            if strRedirectHomeSelectBike == ""
            {
                if recordedVideoData.length == 0
                {
                    viewUploadImageErrorHeightConst.constant = 15
                   // return
                }
                else
                {
                    viewUploadImageErrorHeightConst.constant = 0
                    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "55", cycle_issue_media_type: "VIDEO")
                   // lbUploadImageError.constant = 0
                   // self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "IMAGE")
                }
                
                if selectedImageData.length == 0
                {
                    viewUploadImageErrorHeightConst.constant = 15
                   // lbUploadImageError.constant = 15
                  //  return
                }
                else
                {
                    viewUploadImageErrorHeightConst.constant = 0
                    self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
                //    lbUploadImageError.constant = 0
                //    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "VIDEO")
                  
                }
                
              /*  if recordedVideoData.length > 0 {
                    
                    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "55", cycle_issue_media_type: "VIDEO")
                    
                }
                else if selectedImageData.length > 0
                {
                    print(selectedImageData.count)
                    
                    self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
                }
                else
                {
                    viewUploadImageErrorHeightConst.constant = 15
                    
                    //   let toast = Toast(text: "Please add photos", delay: 0.0, duration: Delay.long)
                    //   toast.show()
                }*/
            }
            else
            {
                if recordedVideoData.length == 0
                {
                    viewUploadImageErrorHeightConst.constant = 15
                   // return
                }
                else
                {
                    viewUploadImageErrorHeightConst.constant = 0
                    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["lock_QR_code"] as! String)", cycleStatus: "55", cycle_issue_media_type: "VIDEO")
                   // lbUploadImageError.constant = 0
                   // self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "IMAGE")
                }
                
                if selectedImageData.length == 0
                {
                    viewUploadImageErrorHeightConst.constant = 15
                   // lbUploadImageError.constant = 15
                  //  return
                }
                else
                {
                    viewUploadImageErrorHeightConst.constant = 0
                    self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["lock_QR_code"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
                //    lbUploadImageError.constant = 0
                //    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["sin"] as! String)", cycleStatus: "\(idCycleStatus)", cycle_issue_media_type: "VIDEO")
                  
                }
             /*   if recordedVideoData.length > 0 {
                    
                    self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["lock_QR_code"] as! String)", cycleStatus: "55", cycle_issue_media_type: "VIDEO")
                    
                }
                else if selectedImageData.length > 0
                {
                    print(selectedImageData.count)
                    
                    self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["lock_QR_code"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
                }
                else
                {
                    viewUploadImageErrorHeightConst.constant = 15
                    
                    //   let toast = Toast(text: "Please add photos", delay: 0.0, duration: Delay.long)
                    //   toast.show()
                }*/
            }
                
        }

        print(dicCurrentRideData)
    //    print("QRCode = \(dicCurrentRideData["QRCode"] as! String)")
        
        print("cycle_issue_media_type = IMAGE or VIDEO")
        
      /*  if txtViewMessage.text.count != 0 {
            
            if recordedVideoData.length > 0 {
                
                self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["QRCode"] as! String)", cycleStatus: "55", cycle_issue_media_type: "VIDEO")
            }
            else if selectedImageData.length > 0 {
                
                self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["QRCode"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
            }
            else {
                
                self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["QRCode"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
            }
        }*/
        
    }
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //

extension ReportIssueWriteVC : UITextViewDelegate
{
    
    func setUIOnScreen() {
        
        txtViewMessage.delegate = self
    
        viewUploadImageErrorHeightConst.constant = 0
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnSkip.layer.cornerRadius = 8.0
        self.btnSubmit.layer.cornerRadius = 8.0
        self.txtViewMessage.layer.cornerRadius = 4.0
        self.txtViewMessage.layer.borderWidth = 1.0
        self.txtViewMessage.layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1).cgColor
        self.viewBackImageName.layer.cornerRadius = 8.0
        
        self.consViewImageBackHeight.constant = 0.0
        
        viewConfirmParentView.layer.cornerRadius = 2.0
        
    }
 
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        lbComment.isHidden = true
        txtViewMessage.viewTextFieldPrimaryBorder()
    }
    func textViewDidChange(_ textView: UITextView)
    {
        if txtViewMessage.text.isEmpty
        {
            lbComment.isHidden = false
        }
        else
        {
            lbComment.isHidden = true
        }
      
    }
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ReportIssueWriteVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
            viewUploadImageErrorHeightConst.constant = 0
            break
            
        case "public.image":
            //UIImageJPEGRepresentation
            // Handle Image here
            let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.lblMediaFileName.text = "\(getCurrentTimeStamp()).jpeg"
            imageTemp = tempImage
            
          /*  if let data:Data = tempImage.jpegData(compressionQuality: 1.0) {
                print(data.count)
                self.selectedImageData = data as NSData
            }*/
          //  let data =
            let data = tempImage.compress(to: 300)
            self.selectedImageData = data as NSData
            
            self.consViewImageBackHeight.constant = 66.0
            viewUploadImageErrorHeightConst.constant = 0
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

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension ReportIssueWriteVC
{
    
    func submitReportIssueAPIWebServiceCall(mediaData: NSData, QRCode: String, cycleStatus: String, cycle_issue_media_type: String)
    {
        
        /*
         APIService.sharedInstance.submitReportIssueAPIWebServiceCall(media: mediaData, dictionary: ["QRCode":QRCode, "cycleStatus": cycleStatus, "note":"\(txtViewMessage.text!)", "cycle_issue_media_type": cycle_issue_media_type]) { response in
             CommonClass.removeProgressHudCycling(viewController: self)
         */
       
        print("QRCODE",QRCode)
        print("COUNT",mediaData.count)
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
                
              //  let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
             //   self.navigationController?.pushViewController(homeVC, animated: true)
              
                //self.navigationController?.popViewController(animated: true)
            
             //   self.viewConfirmMainView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
             //   self.view.addSubview(self.viewConfirmMainView)
              
                CommonClass.removeProgressHudCycling(viewController: self)
                
                self.viewConfirmMainView.frame = (self.view.window?.bounds)!
                self.view.window?.addSubview(self.viewConfirmMainView)
                self.view.bringSubviewToFront(self.viewConfirmMainView)
                
                self.viewAnimationConfirmLotttie!.contentMode = .scaleAspectFit
                self.viewAnimationConfirmLotttie!.loopMode = .playOnce
                self.viewAnimationConfirmLotttie!.animationSpeed = 0.5
                self.viewAnimationConfirmLotttie.play()
                
                self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
                
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
        self.viewConfirmMainView.removeFromSuperview()
        
        if strRedirectHomeSelectBike == ""
        {
            if var viewControllers = self.navigationController?.viewControllers
               {
                   for controller in viewControllers
                   {
                       print(controller)
                       if controller is SelectBikeVC
                       {
                         //  viewControllers.removeElement(controller)
                         //  self.navigationController?.viewControllers = viewControllers
                        /*   let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
                             self.navigationController?.popToViewController(selectBik, animated: true)*/
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
            if var viewControllers = self.navigationController?.viewControllers
            {
                for controller in viewControllers
                {
                    print(controller)
                }
            }
//            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//            self.navigationController?.pushViewController(homeVC, animated: true)
            let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(tabVC, animated: true)
        }
        
        
      /*  let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
        self.navigationController?.popToViewController(selectBik, animated: true)*/
        
      //  self.navigationController?.pushViewController(selectBik, animated: true)
       // self.navigationController?.popViewController(animated: true)
    }
}






