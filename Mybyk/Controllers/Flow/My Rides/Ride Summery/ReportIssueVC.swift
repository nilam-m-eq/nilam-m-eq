//
//  ReportIssueVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 14/12/21.
//

import UIKit
import Toaster
import SwiftyGif
import SVGKit
import CoreText
import CoreImage
import libxml2
import QuartzCore
import CoreGraphics

class ReportIssueVC: CommonViewController {
    @IBOutlet var viewNavi: UIView!
    @IBOutlet var collectView: UICollectionView!
    @IBOutlet var btnSkip: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var viewBackImageName: UIView!
    @IBOutlet weak var lblMediaFileName: UILabel!
    
    @IBOutlet var txtComment: UITextField!
    var arrCycleIssueTypes = NSArray()
    
    var dicCurrentRideData = [String: Any]()
    
    var recordedVideoData = NSData()
    var selectedImageData = NSData()
    
    var FromRideSummary = String()
    
    @IBOutlet weak var consViewImageBackHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      // self.tabBarController?.tabBar.isHidden = true
      //  self.getCycleIssueTypeAPICall()
        
        self.setUIOnScreen()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        if arrCycleIssueTypes.count == 0
        {
            self.getCycleIssueTypeAPICall()
        }
        else
        {
            DispatchQueue.main.async {
                self.collectView.reloadData()
            }
        }
      
        
    }
//    //MARK: - GET LIST OF ISSUES TYPES
//    func getCycleIssueTypeAPICall() {
//
//      //  CommonClass.loadProgressHudCycling(viewController: self)
//        APIService.sharedInstance.getCycleIssueTypeAPICall(dictionary: ["getcycleissuetypes": "1"]) { [self] response in
//          //  CommonClass.removeProgressHudCycling(viewController: self)
//
//            print(response)
//
//            if response["is_error"] as! String == "false" {
//
//                let dicCurrentData = response["data"] as! [String: Any]
//                arrCycleIssueTypes = dicCurrentData["cycleIssueTypes"] as! NSArray
//
//                self.collectView.reloadData()
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
//
//        } blockError: { error in
//            CommonClass.removeProgressHudCycling(viewController: self)
//
//        }
//    }
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton)
    {
        print(FromRideSummary)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionWriteHere(_ sender: UIButton) {
        
        let write = self.storyboard?.instantiateViewController(withIdentifier: "ReportIssueWriteVC") as! ReportIssueWriteVC
        write.dicCurrentRideData = dicCurrentRideData
        write.strRedirectHomeSelectBike = FromRideSummary
        self.navigationController?.pushViewController(write, animated: true)
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
     
        if txtComment.text == ""
        {
            txtComment.viewTextFieldErrorBorder()
            return
        }
        print(dicCurrentRideData)
        print("QRCode = \(dicCurrentRideData["QRCode"] as! String)")
        
        print("cycle_issue_media_type = IMAGE or VIDEO")
        
        if recordedVideoData.length > 0 {
            
            self.submitReportIssueAPIWebServiceCall(mediaData: recordedVideoData, QRCode: "\(dicCurrentRideData["QRCode"] as! String)", cycleStatus: "55", cycle_issue_media_type: "VIDEO")
        }
        else if selectedImageData.length > 0 {
            
            self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["QRCode"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
        }
        else {
            
            self.submitReportIssueAPIWebServiceCall(mediaData: selectedImageData, QRCode: "\(dicCurrentRideData["QRCode"] as! String)", cycleStatus: "55", cycle_issue_media_type: "IMAGE")
        }
        
    }
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ReportIssueVC {
    
    func setUIOnScreen() {
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnSkip.layer.cornerRadius = 8.0
        self.btnSubmit.layer.cornerRadius = 8.0
        self.viewBackImageName.layer.cornerRadius = 8.0
      //  self.txtComment.shadowZ100(frame: txtComment.frame)
        
        self.txtComment.viewTextFieldActiveBorder()
        
        self.consViewImageBackHeight.constant = 0.0
        
        self.leftPaddingTextfield(space: 10)
    }
    func leftPaddingTextfield(space : CGFloat) -> Void
    {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: space, height: 2.0))
        txtComment.leftView = leftView
        txtComment.leftViewMode = .always
    }
    
    
}
extension UIImageView {
func downloadedsvg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let receivedicon: SVGKImage = SVGKImage(data: data),
            let image = receivedicon.uiImage
            else { return }
        DispatchQueue.main.async() {
            self.image = image
        }
    }.resume()
}
}
// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension ReportIssueVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {return}
        
        print(mediaType)
        
        switch mediaType
        {
        case "public.movie":
            // Handle movie here
            let videoUrl = info[UIImagePickerController.InfoKey.mediaURL]
            self.lblMediaFileName.text = "\(getCurrentTimeStamp()).mov"
            
            if let videoData = NSData(contentsOf: videoUrl as! URL) {
                
                print(videoData.length)
                self.recordedVideoData = videoData
            }
            
            self.consViewImageBackHeight.constant = 66.0
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


// ************************************************** //
// MARK:- UIcollection View Delegate & DataSource
// ************************************************** //
extension ReportIssueVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrCycleIssueTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectRideIssueCell
        
        let dicCycleType = arrCycleIssueTypes[indexPath.item] as! [String: Any]
        
      //  print(dicCycleType)
        cell.lblText.text = dicCycleType["cycleIssueTypeName"] as? String ?? ""
        
        let imageGet = dicCycleType["cycleIssueTypeImage"] as! String
        
     /*   let svg = URL(string: imageGet)!
         let data = try? Data(contentsOf: svg)
         let receivedimage: SVGKImage = SVGKImage(data: data)
        cell.imgViewIcon.image = receivedimage.uiImage*/
        
        let svg = URL(string: imageGet)!

        cell.imgViewIcon.downloadedsvg(from: svg)
        
       // cell.imgViewIcon.sd_setImage(with: URL(string: "\(dicCycleType["cycleIssueTypeImage"] as! String)"), placeholderImage: UIImage(named: ""))
        cell.viewImgBack.layer.cornerRadius = 10
        cell.viewImgBack.shadowZ100(frame: cell.viewImgBack.frame)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "ReportIssueDetailVC") as! ReportIssueDetailVC
        detail.dicIssueType = arrCycleIssueTypes[indexPath.item] as! [String: Any]
        detail.strRedirectHomeSelectBikeDetail = FromRideSummary
        // write.strRedirectHomeSelectBike = FromRideSummary
        detail.dicCurrentRideData = dicCurrentRideData
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension ReportIssueVC {
    
    func getCycleIssueTypeAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getCycleIssueTypeAPICall(dictionary: ["getcycleissuetypes": "1"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let dicCurrentData = response["data"] as! [String: Any]
                self.arrCycleIssueTypes = dicCurrentData["cycleIssueTypes"] as! NSArray
                
                DispatchQueue.main.async {
                    
                    self.collectView.reloadData()
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
    
    func submitReportIssueAPIWebServiceCall(mediaData: NSData, QRCode: String, cycleStatus: String, cycle_issue_media_type: String) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.submitReportIssueAPIWebServiceCall(media: mediaData, dictionary: ["QRCode":QRCode, "cycleStatus": cycleStatus, "note":"", "cycle_issue_media_type": cycle_issue_media_type]) {[self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["error_code"] as! String == "404" {
                
                CommonClass.moveToLogOut(viewController: self)
            }
            else
            {
                print(FromRideSummary)
//                let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
//                self.navigationController?.pushViewController(selectBik, animated: true)
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                self.navigationController?.pushViewController(homeVC, animated: true)
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
    
}







