//
//  HomeUploadDocumentVc.swift
//  Mybyk
//
//  Created by Parth Kapadia on 15/03/22.
//

import UIKit
import CoreText
import CoreImage
import libxml2
import QuartzCore
import CoreGraphics
import DropDown
import MobileCoreServices
import Foundation

protocol UploadImageDelegateProtocol
{
    func Image()
}

class HomeUploadDocumentVc: CommonViewController {
    @IBOutlet var viewUploadImageConst: NSLayoutConstraint!
    
    var delegate: UploadImageDelegateProtocol? = nil
    
    @IBOutlet var btnCancel2: UIButton!
    @IBOutlet var btnCancel1: UIButton!
    @IBOutlet var viewSecondUpload: UIView!
    @IBOutlet var viewFirstUpload: UIView!
    @IBOutlet var viewUploadImageTextCameraHeight: NSLayoutConstraint!
    @IBOutlet var viewUploadedImageHeightFirst: NSLayoutConstraint!
    @IBOutlet var viewUploadedImageHeightSecond: NSLayoutConstraint!
    @IBOutlet var viewUploadViewTop: NSLayoutConstraint!
    @IBOutlet var btnDownArrow: UIButton!
    @IBOutlet var viewUploadLeadingConstant: NSLayoutConstraint!
    @IBOutlet var viewMAinOuter: UIView!
    @IBOutlet var txtSelectDoc: UITextField!
    @IBOutlet var lbUploadTitle: UILabel!
    @IBOutlet var viewMainHeightConst: NSLayoutConstraint!
    @IBOutlet var viewInnerImageUploadHeightConst: NSLayoutConstraint!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var lbUploadImageName: UILabel!
    @IBOutlet var lbUploadImage: UILabel!
    @IBOutlet var viewUploadDoc: UIView!
   
    @IBOutlet var lbImage2: UILabel!
    @IBOutlet var lbImage1: UILabel!
    @IBOutlet var txtIdNumber: UITextField!
    
    var selectedImageData = [NSData]()
    var selectedImageName = [String]()
    
    @IBOutlet var viewSelectDoc: UIView!
    
    var botomPop : HomeDocVc!
    
    var partialViewDisp: CGFloat = UIScreen.main.bounds.height
    
    let dropDownDoc = DropDown()
    
   
    var strStationIDGet = String()
    
    var arrDocList = [String]()
    var arrDocListIndex = [String]()
    
    var openDocumentVcSelf: ((_ checkDocname: String) -> Void)?
     
    var strId : String!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.tabBarController?.tabBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        print(strStationIDGet)
        self.setUIOnScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.view.removeFromSuperview()
    }
    override func viewDidDisappear(_ animated: Bool)
    {

    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let frame = self.view.frame
        
        self.partialViewDisp = self.partialViewDisp - 370
        let yComponent = self.partialViewDisp
        
      //  UIView.animate(withDuration: 0.2, animations: { [weak self] in
         
         
         
        self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height - 48)
         
      //  })
    }
    @IBAction func btn2ImageCancelClicked(_ sender: Any)
    {
        print(btnCancel2.tag)
        print(btnCancel1.tag)
        print(selectedImageName)
        
        if (btnCancel2.tag == 1)
        {
            if selectedImageName.count == 1
            {
                viewUploadViewTop.constant = 16
                viewUploadImageTextCameraHeight.constant = 50
                viewMainHeightConst.constant = 90
              
                viewUploadedImageHeightSecond.constant = 0
                
                viewSecondUpload.isHidden = true
               
                viewUploadDoc.isHidden = false
                
                viewUploadLeadingConstant.constant = CGFloat(Int((viewMAinOuter.frame.width - 166) / 2))
                
                selectedImageName.remove(at: 0)
             
                UserDefaults.standard.removeObject(forKey:"imageList")
                UserDefaults.standard.removeObject(forKey:"imageData")
                UserDefaults.standard.synchronize()
                /*
                 let checkDataAvaOrNot = UserDefaults.standard.value(forKey: "imageData")
                 let checkImageAvaOrNot = UserDefaults.standard.value(forKey: "imageList")
                 */
            }
            else if selectedImageName.count == 2
            {
                viewUploadViewTop.constant = 0
                viewUploadImageTextCameraHeight.constant = 50
                viewMainHeightConst.constant = 90
                viewUploadedImageHeightFirst.constant = 36
                viewUploadedImageHeightSecond.constant = 0
                
                viewSecondUpload.isHidden = true
                viewFirstUpload.isHidden = false
                viewUploadDoc.isHidden = false
                
                selectedImageName.remove(at: 1)
            }
            else
            {
                
            }
           
        }
        else
        {
            
        }
        UserDefaults.standard.set(selectedImageData, forKey: "imageData")
        UserDefaults.standard.synchronize()
        
      
    }
    @IBAction func btn1ImageCancelClicked(_ sender: Any)
    {
        print(btnCancel2.tag)
        print(btnCancel1.tag)
        print(selectedImageName)
        
        if (btnCancel1.tag == 0)
        {
            if selectedImageName.count == 1
            {
                viewUploadViewTop.constant = 16
                viewUploadImageTextCameraHeight.constant = 50
                viewMainHeightConst.constant = 90
              
                viewUploadedImageHeightFirst.constant = 0
                
                viewFirstUpload.isHidden = true
               
                viewUploadDoc.isHidden = false
                
                viewUploadLeadingConstant.constant = CGFloat(Int((viewMAinOuter.frame.width - 166) / 2))
                
                selectedImageName.remove(at: 0)
                
                UserDefaults.standard.removeObject(forKey:"imageList")
                UserDefaults.standard.removeObject(forKey:"imageData")
                UserDefaults.standard.synchronize()
            }
            else if selectedImageName.count == 2
            {
                viewUploadViewTop.constant = 0
                viewUploadImageTextCameraHeight.constant = 50
                viewMainHeightConst.constant = 90
                viewUploadedImageHeightFirst.constant = 0
                viewUploadedImageHeightSecond.constant = 36
                
                viewSecondUpload.isHidden = false
                viewFirstUpload.isHidden = true
                viewUploadDoc.isHidden = false
                
                selectedImageName.remove(at: 0)
            }
            else
            {
                
            }
           
        }
        else
        {
            
        }
        UserDefaults.standard.set(selectedImageData, forKey: "imageData")
        UserDefaults.standard.synchronize()
    }
    @IBAction func btnSubmitClicked(_ sender: Any)
    {
        print("SUBMIT CLICKED")
        
       NotificationCenter.default.removeObserver(self)
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
    @IBAction func btnUploadPicClicked(_ sender: Any)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeUploadDocumentVc: UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    // MARK: - ImagePicker Delegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {return}
        
        print(mediaType)
          //  myImageView.contentMode = .scaleAspectFit
         //   myImageView.image = pickedImage
       // }


        /*

        Swift Dictionary named “info”.
        We have to unpack it from there with a key asking for what media information we want.
        We just want the image, so that is what we ask for.  For reference, the available options are:

        UIImagePickerControllerMediaType
        UIImagePickerControllerOriginalImage
        UIImagePickerControllerEditedImage
        UIImagePickerControllerCropRect
        UIImagePickerControllerMediaURL
        UIImagePickerControllerReferenceURL
        UIImagePickerControllerMediaMetadata

        */
        dismiss(animated: true, completion:nil)
            
            self.delegate?.Image()
           // NotificationCenter.default.post(name: Notification.Name("methodOfReceivedNotification"), object: nil)
            
            //methodOfReceivedNotification
            
          //  self.viewWillAppear(true)
     //   }
      //  dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }

    
}

extension HomeUploadDocumentVc: UIGestureRecognizerDelegate {
    
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
extension HomeUploadDocumentVc
{
    
    func setUIOnScreen()
    {
        //Please upload below given document
        
      //  Local Address Proof
        
//        let strLb =  "Please upload below given document"
//        let customizedText = NSMutableAttributedString(string: strLb)
//        customizedText.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "Rubik Bold", size: 13.0)! , range: NSRange(location: 14, length:strLb.count - 14))
        //      letelf.lblOTPResendTimer.attributedText = customizedText
        
       
        imagePicker.delegate = self
        
        let normalText = "Please upload below given document \n"
        let boldText  = "Local Address Proof"
    
        let attributedString = NSMutableAttributedString(string:normalText)

        let attrs = [NSAttributedString.Key.font : UIFont(name: "Rubik Bold", size: 14.0)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs as [NSAttributedString.Key : Any])
        attributedString.append(boldString)
        lbUploadTitle.attributedText = attributedString
        
        self.view.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 8.0)
        
        btnSubmit.layer.cornerRadius = 5.0
        btnSubmit.clipsToBounds = true
        
      //  viewInnerImageUploadHeightConst.constant = 0 //36
         // 90
      //  viewUploadImageConst.constant = 0 // 70
        
 //       let checkDataAvaOrNot = UserDefaults.standard.value(forKey: "imageData")
       // let selectedImageName = UserDefaults.standard.value(forKey: "imageList") as! [String]
        
      
       
     /*   if UserDefaults.standard.value(forKey: "imageList") != nil
        {
            print(UserDefaults.standard.value(forKey: "imageList")!)
            
            selectedImageName = UserDefaults.standard.value(forKey: "imageList")! as! [String]
            
            if selectedImageName.count == 3
            {
                selectedImageName.remove(at: 0)
            }
            if selectedImageName.count == 1
            {
                lbImage1.text = selectedImageName[0]
                
                viewUploadViewTop.constant = 0
                viewUploadImageTextCameraHeight.constant = 50
                viewMainHeightConst.constant = 90
                viewUploadedImageHeightFirst.constant = 36
                viewUploadedImageHeightSecond.constant = 0
                
                viewSecondUpload.isHidden = true
                viewFirstUpload.isHidden = false
                viewUploadDoc.isHidden = false
            }
            else if selectedImageName.count == 2
            {
                lbImage1.text = selectedImageName[0]
                lbImage2.text = selectedImageName[1]
                
                viewUploadViewTop.constant = 0
                viewUploadImageTextCameraHeight.constant = 0
                viewMainHeightConst.constant = 90
                viewUploadedImageHeightFirst.constant = 36
                viewUploadedImageHeightSecond.constant = 36
                
                viewSecondUpload.isHidden = false
                viewFirstUpload.isHidden = false
                viewUploadDoc.isHidden = true
            }
            else
            {
              
                viewSecondUpload.isHidden = true
                viewFirstUpload.isHidden = true
                viewMainHeightConst.constant = 90
                viewUploadViewTop.constant = 16
                viewUploadLeadingConstant.constant = CGFloat(Int((viewMAinOuter.frame.width - 166) / 2))
                
                viewUploadedImageHeightFirst.constant = 0
                viewUploadedImageHeightSecond.constant = 0
                viewUploadDoc.isHidden = false
                
            }
            
        }
        else
        {
            viewSecondUpload.isHidden = true
            viewFirstUpload.isHidden = true
            viewMainHeightConst.constant = 90
            viewUploadViewTop.constant = 16
            viewUploadLeadingConstant.constant = CGFloat(Int((viewMAinOuter.frame.width - 166) / 2))
            
            viewUploadedImageHeightFirst.constant = 0
            viewUploadedImageHeightSecond.constant = 0
        }*/
        
        viewSelectDoc.viewBorderWithCornerRadius()
        txtIdNumber.viewBorderWithCornerRadius()
        
        viewMAinOuter.layer.cornerRadius = 3.0
     //   viewMAinOuter.shadowZ100WithShadowRadius(frame: self.viewMAinOuter.frame, radius: 3.0)
        
        txtIdNumber.setLeftPaddingPoints(5)
        txtSelectDoc.setLeftPaddingPoints(5)
        
        self.dropDownDoc.anchorView = self.btnDownArrow
        
        self.dropDownDoc.selectionAction = { (index: Int, item: String) in
             
             print("Selected item: \(item) at index: \(index)")
            
            // self.strSelectedStateIndex = "\(index)"
            // self.txtCity.text = ""
            self.strId = self.arrDocListIndex[index]
            
            print("STRING ID",self.strId!)
            
             self.txtSelectDoc.text = item
         }
    
        self.getDocType()
        
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
                self.arrDocListIndex.append("SELECT DOCUMENT")
                
                for i in 0..<docType.count
                {
                   let dicV = docType[i] as! NSDictionary
                    let getName = dicV.value(forKey: "name")
                    
                    print(dicV.value(forKey: "id") as? String?)
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
                    self.arrDocListIndex.append(CovertID)
                }
                
                self.txtSelectDoc.text = self.arrDocList[0]
                self.dropDownDoc.dataSource = self.arrDocList
               // arrDocList
                
              
                
            }
           
        } blockerror: { error in
//             print(error)
//               CommonClass.removeProgressHudCycling(viewController: self)
        }
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat)
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat)
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
