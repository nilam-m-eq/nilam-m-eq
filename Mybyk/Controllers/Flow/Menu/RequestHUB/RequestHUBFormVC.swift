//
//  RequestHUBFormVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 21/01/22.
//

import UIKit
import DropDown
import Toaster
import Foundation

class requestHubImgTblCell: UITableViewCell {
    
    @IBOutlet var viewBackImageName: UIView!
    @IBOutlet weak var lblMediaFileName: UILabel!
    @IBOutlet weak var btnDeleteImage: UIButton!
    
}


class RequestHUBFormVC: CommonViewController, UITextFieldDelegate {
    @IBOutlet var lbStateErrorConstant: NSLayoutConstraint!
    @IBOutlet weak var lbAllFieldRequired: UILabel!
    @IBOutlet var lbFirstImage: UILabel!
    @IBOutlet var lbThirdImage: UILabel!
    @IBOutlet var lbSecondImage: UILabel!
    @IBOutlet var viewSecondUploadHeightConst: NSLayoutConstraint!
    @IBOutlet var viewUploadImageCenter: UIView!
    @IBOutlet var viewFirstUploadHeightConst: NSLayoutConstraint!
    @IBOutlet var viewThirdUploadHeightConst: NSLayoutConstraint!
    @IBOutlet var imgUploadHeightConst: NSLayoutConstraint!
    @IBOutlet var viewUploadImage: UIView!
    @IBOutlet var viewImgSecondUpload: UIView!
    @IBOutlet var viewImgFirstUpload: UIView!
    @IBOutlet var viewImgThirdUpload: UIView!
    @IBOutlet var viewAllFieldEmptyConstHeight: NSLayoutConstraint!
    @IBOutlet var viewUploadImageTop: NSLayoutConstraint!
    @IBOutlet weak var viewNavi: UIView!
   // @IBOutlet weak var txtNameOfPerson: UITextField!
    @IBOutlet weak var viewBackNameOfPerson: UIView!
  //  @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var viewBackContact: UIView!
    @IBOutlet weak var txtAppartment: UITextField!
    @IBOutlet weak var viewBackAppartment: UIView!
    @IBOutlet weak var txtSociety: UITextField!
    @IBOutlet weak var viewBackSociety: UIView!
    @IBOutlet weak var txtLandmark: UITextField!
    @IBOutlet weak var viewBackLandmark: UIView!
    //@IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var viewBackAddress: UIView!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var viewBackArea: UIView!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var viewBackCity: UIView!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var viewBackState: UIView!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var viewBackPincode: UIView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var viewBackMessage: UIView!
    @IBOutlet weak var viewBackImage: UIView!
    @IBOutlet weak var viewBackMainImage: UIView!
    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var btnSelectState: UIButton!
    @IBOutlet weak var tblViewImg: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet var lbStateConstHeight: NSLayoutConstraint!
    
    @IBOutlet var btnUploadImageCenter: UIButton!
    @IBOutlet var lbUploadImage: UILabel!
    @IBOutlet var lbMessageError: UILabel!
    @IBOutlet var lbMessageHeightConst: NSLayoutConstraint!
    @IBOutlet var lbPinError: UILabel!
    @IBOutlet var lbPinCodeHeightConst: NSLayoutConstraint!
    @IBOutlet var lbstateError: UILabel!
    @IBOutlet var lbCityError: UILabel!
    @IBOutlet weak var viewBackImgLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMainBackImgHeightCons: NSLayoutConstraint!
    @IBOutlet weak var tblViewImgHeightCons: NSLayoutConstraint!
    @IBOutlet var viewUploadImageTopHeightConst: NSLayoutConstraint!
    
    @IBOutlet var viewUploadImageLeadingConstant: NSLayoutConstraint!
    var arrCityList = NSArray()
    var arrStateList = NSArray()
    
    @IBOutlet var viewCityHeightConstant: NSLayoutConstraint!
    var arrCityListString = [String]()
    var arrCityFilter = NSMutableArray()
    var arrStateListString = [String]()
    
    let dropDownCity = DropDown()
    let dropDownState = DropDown()
    
    var strSelectedStateIndex = String()
    var strSelectedCityIndex = String()
    
    var arrSelectedImageString = [String]()
    var arrSelectedImageData = [Data]()
    //var arrSelectedImageData = NSData()
    
    @IBOutlet var lbLandMarkError: UILabel!
    
    @IBOutlet var lbLandMarkHEightConst: NSLayoutConstraint!
    @IBOutlet var lbNoApartmentErroe: UILabel!
    
    @IBOutlet var lbNameHeightConst: NSLayoutConstraint!
    
    @IBOutlet var lbNoApartmentHeightConst: NSLayoutConstraint!
    @IBOutlet var lbApartmentError: UILabel!
    @IBOutlet var lbApartmentHeightConst: NSLayoutConstraint!
    
    @IBOutlet var lbCityHeightConst: NSLayoutConstraint!
    @IBOutlet var lbAreaError: UILabel!
    @IBOutlet var lbAreaHeightConst: NSLayoutConstraint!
    @IBOutlet var lbAddreesslineHeightConst: NSLayoutConstraint!
    @IBOutlet var lbContactError: UILabel!
    @IBOutlet var lbNameErroe: UILabel!
    @IBOutlet var lnContactHeightConst: NSLayoutConstraint!
    @IBOutlet var lbAddressError: UILabel!
    
    
    var DicDataFromPinVc = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = true
      
      //  viewBackImgLeadingConstraint.priority = .defaultLow
        
        self.setUIOnScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    // ********** All Button Actions ********** //
    //MARK: - button action
    
    @IBAction func btnFirstCancelClicked(_ sender: Any)
    {
       
        viewFirstUploadHeightConst.constant = 0
        viewImgFirstUpload.isHidden = true
        print(self.arrSelectedImageString)
        print("DATA COUNT FIRST",self.arrSelectedImageData.count)
        if self.arrSelectedImageData.count == 0
        {
            btnUploadImageCenter.isUserInteractionEnabled = true
            viewUploadImageCenter.isHidden = false
           // viewUploadImage.isHidden = false
            viewUploadImageTopHeightConst.constant = 0
            
            viewUploadImage.isHidden = true
           // viewUploadImageTop.constant = 53
            
           // viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
            viewMainBackImgHeightCons.constant = 128
            viewImgFirstUpload.isHidden = true
            viewImgSecondUpload.isHidden = true
            viewImgThirdUpload.isHidden = true
            
            self.viewBackImage.backgroundColor = .white
            
          //  imgUploadHeightConst.constant = 22
           // self.viewUploadImage.backgroundColor = .clear
        }
        if self.arrSelectedImageData.count == 1
        {
            btnUploadImageCenter.isUserInteractionEnabled = true
            
            self.arrSelectedImageData.remove(at: 0)
            self.arrSelectedImageString.remove(at: 0)
            viewUploadImage.isHidden = true
            viewUploadImageCenter.isHidden = false
            viewUploadImageTopHeightConst.constant = 0
            
            self.arrSelectedImageData.removeAll()
            self.arrSelectedImageData.removeAll()
            
       //     viewUploadImageTop.constant = 53
            
            //viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
            viewMainBackImgHeightCons.constant = 150
            viewImgFirstUpload.isHidden = true
            viewImgSecondUpload.isHidden = true
            viewImgThirdUpload.isHidden = true
            
            self.viewBackImage.backgroundColor = .white
            
           // imgUploadHeightConst.constant = 22
            viewBackImage.shadowZ100(frame: viewBackImage.frame)
        }
        if self.arrSelectedImageData.count == 2
        {
            btnUploadImageCenter.isUserInteractionEnabled = false
            
            self.viewMainBackImgHeightCons.constant = 156
            self.arrSelectedImageData.remove(at: 0)
            self.arrSelectedImageString.remove(at: 0)
        }
        if self.arrSelectedImageData.count == 3
        {
            btnUploadImageCenter.isUserInteractionEnabled = false
            
            viewUploadImage.isHidden = false
            viewUploadImageTopHeightConst.constant = 30
            
            self.viewMainBackImgHeightCons.constant = 180
            self.arrSelectedImageData.remove(at: 0)
            self.arrSelectedImageString.remove(at: 0)
        }
       
    }
    @IBAction func btnSecondCancelClicked(_ sender: Any)
    {
       
        viewSecondUploadHeightConst.constant = 0
        viewImgSecondUpload.isHidden = true
        print(self.arrSelectedImageString)
        print("DATA COUNT SECOND",self.arrSelectedImageData.count)
        if self.arrSelectedImageData.count == 0
        {
            btnUploadImageCenter.isUserInteractionEnabled = true
            viewUploadImageCenter.isHidden = false
           // viewUploadImage.isHidden = false
            viewUploadImageTopHeightConst.constant = 0
            viewUploadImage.isHidden = true
            
          //  viewUploadImageTop.constant = 53
            
           // viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
            viewMainBackImgHeightCons.constant = 150
            viewImgFirstUpload.isHidden = true
            viewImgSecondUpload.isHidden = true
            viewImgThirdUpload.isHidden = true
            self.viewBackImage.backgroundColor = .white
            
         //   imgUploadHeightConst.constant = 22
        }
        if self.arrSelectedImageData.count == 1
        {
            btnUploadImageCenter.isUserInteractionEnabled = true
            self.arrSelectedImageData.remove(at: 0)
            self.arrSelectedImageString.remove(at: 0)
            viewUploadImage.isHidden = true
            viewUploadImageCenter.isHidden = false
         //   viewUploadImageTop.constant = 53
            viewUploadImageTopHeightConst.constant = 0
       //     viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
            viewMainBackImgHeightCons.constant = 150
            viewImgFirstUpload.isHidden = true
            viewImgSecondUpload.isHidden = true
            viewImgThirdUpload.isHidden = true
            
            self.arrSelectedImageData.removeAll()
            self.arrSelectedImageData.removeAll()
            
            self.viewBackImage.backgroundColor = .white
            
           // imgUploadHeightConst.constant = 22
            viewBackImage.shadowZ100(frame: viewBackImage.frame)
        }
        if self.arrSelectedImageData.count == 2
        {
            btnUploadImageCenter.isUserInteractionEnabled = false
            self.viewMainBackImgHeightCons.constant = 156
            self.arrSelectedImageData.remove(at: 1)
            self.arrSelectedImageString.remove(at: 1)
        }
        if self.arrSelectedImageData.count == 3
        {
            btnUploadImageCenter.isUserInteractionEnabled = false
            
            viewUploadImage.isHidden = false
            viewUploadImageTopHeightConst.constant = 30
            
            self.viewMainBackImgHeightCons.constant = 180
            self.arrSelectedImageData.remove(at: 1)
            self.arrSelectedImageString.remove(at: 1)
        }
       
    }
    @IBAction func btnThirdCancelClicked(_ sender: Any)
    {
       
        viewThirdUploadHeightConst.constant = 0
        viewImgThirdUpload.isHidden = true
      
        print(self.arrSelectedImageString)
        print("DATA COUNT THIRD",self.arrSelectedImageData.count)
        
        if self.arrSelectedImageData.count == 0
        {
            btnUploadImageCenter.isUserInteractionEnabled = true
            viewUploadImageCenter.isHidden = false
           // viewUploadImage.isHidden = false
            viewUploadImageTopHeightConst.constant = 0
            viewUploadImage.isHidden = true
            
           // viewUploadImageTop.constant = 53
            
          //  viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
            viewMainBackImgHeightCons.constant = 150
            viewImgFirstUpload.isHidden = true
            viewImgSecondUpload.isHidden = true
            viewImgThirdUpload.isHidden = true
            self.viewBackImage.backgroundColor = .white
            
          //  imgUploadHeightConst.constant = 22
            
        }
        if self.arrSelectedImageData.count == 1
        {
            btnUploadImageCenter.isUserInteractionEnabled = true
            self.arrSelectedImageData.remove(at: 0)
            self.arrSelectedImageString.remove(at: 0)
            viewUploadImage.isHidden = true
            viewUploadImageCenter.isHidden = false
            viewUploadImageTopHeightConst.constant = 0
           // viewUploadImageTop.constant = 53
            self.arrSelectedImageData.removeAll()
            self.arrSelectedImageData.removeAll()
           // viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
            viewMainBackImgHeightCons.constant = 150
            viewImgFirstUpload.isHidden = true
            viewImgSecondUpload.isHidden = true
            viewImgThirdUpload.isHidden = true
            
            self.viewBackImage.backgroundColor = .white
            
         //   imgUploadHeightConst.constant = 22
            viewBackImage.shadowZ100(frame: viewBackImage.frame)
        }
        if self.arrSelectedImageData.count == 2
        {
            btnUploadImageCenter.isUserInteractionEnabled = false
            self.viewMainBackImgHeightCons.constant = 156
            self.arrSelectedImageData.remove(at: 1)
            self.arrSelectedImageString.remove(at: 1)
        }
        if self.arrSelectedImageData.count == 3
        {
            btnUploadImageCenter.isUserInteractionEnabled = false
            self.viewMainBackImgHeightCons.constant = 180
            
            viewUploadImage.isHidden = false
            viewUploadImageTopHeightConst.constant = 30
            self.arrSelectedImageData.remove(at: 2)
            self.arrSelectedImageString.remove(at: 2)
        }
        
    }
    
    
    
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionSelectCity(_ sender: UIButton) {
        
        print(arrCityList)
        
        
    
        if strSelectedStateIndex == ""
        {
            
        }
        else
        {
            if dropDownCity.dataSource.count == 1 {
                
            }
            else {
                dropDownCity.show()
            }
           
        }
        
        
        
    }
    
    @IBAction func ActionSelectState(_ sender: UIButton)
    {
        
        if dropDownState.dataSource.count == 1
        {
            
        }
        else {
            dropDownState.show()
        }
        
    }
    
    @IBAction func ActionUploadImage(_ sender: UIButton)
    {
        
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                
                DispatchQueue.main.async
                {
                    let img = UIImagePickerController()
                    img.delegate = self
                    img.sourceType = .camera
                    img.mediaTypes = ["public.image"]
                    img.allowsEditing = true
                    self.present(img, animated: true, completion: nil)
                }
        }
       
    }
    func validatiohHeight(txtField : NSLayoutConstraint,val : Int)
    {
        txtField.constant = CGFloat(val)
    }
    @IBAction func ActionSubmit(_ sender: UIButton)
    {
//
//        if txtNameOfPerson.text == ""
//        {
//            //lbNameHeightConst.constant = 15
//            self.validatiohHeight(txtField: lbNameHeightConst, val: 15)
//            self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
//            self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
//            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
//            viewAllFieldEmptyConstHeight.constant = 15
//            return
//        }
//        else if txtContact.text == ""
//        {
//            self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
//            self.validatiohHeight(txtField: lnContactHeightConst, val: 15)
//            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
//            self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
//            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
//            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
//            viewAllFieldEmptyConstHeight.constant = 15
//            return
//        }
//        else
        if txtSociety.text == ""
        {
           
         //   self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 15)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
        //    self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if txtAppartment.text == ""
        {
        //    self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
        //    self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 15)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
          //  self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
           //self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
          //  self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if txtLandmark.text == ""
        {
       //     self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
       //     self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 15)
          //  self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
           // self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
          //  self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if txtArea.text == ""
        {
          //  self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
        //    self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 15)
            
            //self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
           // self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        /*
         self.arrStateListString.append("SELECT YOUR STATE")
         \self.arrCityListString.append("SELECT YOUR CITY")
         */
        else if txtState.text == "SELECT YOUR STATE"
        {
        //    self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
        //    self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
      //      self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
          //  self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
          //  self.validatiohHeight(txtField: lbStateConstHeight, val: 15)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 15)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if txtCity.text == "SELECT YOUR CITY"
        {
          //  self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
          //  self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 15)
          //  self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if txtPincode.text == ""
        {
         //   self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
       //     self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
           // self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
           // self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 15)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if txtMessage.text == ""
        {
         //   self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
         //   self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
          //  self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
           // self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
           // self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 15)
            self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            lbAllFieldRequired.text = "All fields are required."
            viewAllFieldEmptyConstHeight.constant = 15
            return
        }
        else if arrSelectedImageData.count == 0
        {
            viewAllFieldEmptyConstHeight.constant = 15
            lbAllFieldRequired.text = "Image is required"
            return
        }
        else
        {
            viewAllFieldEmptyConstHeight.constant = 0
            self.submitRequestHubFormAPIWebServiceCall(mediaData: arrSelectedImageData)
        }
       // if validateSubmitForm()
       // {

            
       // }
    }
    
   
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension RequestHUBFormVC {
    
    func setUIOnScreen() {
        
       // txtNameOfPerson.delegate = self
       // txtContact.delegate  = self
        txtAppartment.delegate = self
        txtSociety.delegate = self
        txtLandmark.delegate = self
    //    txtAddress.delegate = self
        txtArea.delegate = self
        txtCity.delegate = self
        txtState.delegate = self
        txtPincode.delegate = self
        txtMessage.delegate = self
        
        viewUploadImage.isHidden = true
        viewUploadImageCenter.isHidden = false
        viewImgFirstUpload.isHidden = true
        viewImgSecondUpload.isHidden = true
        viewImgThirdUpload.isHidden = true
        btnUploadImageCenter.isUserInteractionEnabled = true
        viewUploadImageTopHeightConst.constant = 0
        
        print(DicDataFromPinVc)
        
     //   txtNameOfPerson.text = DicDataFromPinVc["first_name"] as? String
      //  txtContact.text = DicDataFromPinVc["contact_no"] as? String
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        viewAllFieldEmptyConstHeight.constant = 0
        viewBackImage.shadowZ100(frame: viewBackImage.frame)
        
       // viewBackNameOfPerson.shadowZ(frame: viewBackImage.frame)
      //  viewBackContact.shadowZ(frame: viewBackImage.frame)
        viewBackAppartment.shadowZ(frame: viewBackImage.frame)
        viewBackSociety.shadowZ(frame: viewBackImage.frame)
        viewBackLandmark.shadowZ(frame: viewBackImage.frame)
     //   viewBackAddress.shadowZ(frame: viewBackImage.frame)
        viewBackArea.shadowZ(frame: viewBackImage.frame)
        viewBackCity.shadowZ(frame: viewBackImage.frame)
        viewBackState.shadowZ(frame: viewBackImage.frame)
        viewBackPincode.shadowZ(frame: viewBackImage.frame)
        viewBackMessage.shadowZ(frame: viewBackImage.frame)
       
        
        btnSubmit.layer.cornerRadius = 10.0
        
        
     
        
       /* viewBackNameOfPerson.layer.cornerRadius = 3.0
        viewBackNameOfPerson.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackNameOfPerson.layer.borderWidth = 1.0
        
        viewBackContact.layer.cornerRadius = 3.0
        viewBackContact.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackContact.layer.borderWidth = 1.0
        
        viewBackAppartment.layer.cornerRadius = 3.0
        viewBackAppartment.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackAppartment.layer.borderWidth = 1.0
        
        viewBackSociety.layer.cornerRadius = 3.0
        viewBackSociety.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackSociety.layer.borderWidth = 1.0
        
        viewBackLandmark.layer.cornerRadius = 3.0
        viewBackLandmark.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackLandmark.layer.borderWidth = 1.0
        
        viewBackAddress.layer.cornerRadius = 3.0
        viewBackAddress.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackAddress.layer.borderWidth = 1.0
        
        viewBackArea.layer.cornerRadius = 3.0
        viewBackArea.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackArea.layer.borderWidth = 1.0
        
        viewBackCity.layer.cornerRadius = 3.0
        viewBackCity.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackCity.layer.borderWidth = 1.0
        
        viewBackState.layer.cornerRadius = 3.0
        viewBackState.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackState.layer.borderWidth = 1.0
        
        viewBackPincode.layer.cornerRadius = 3.0
        viewBackPincode.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackPincode.layer.borderWidth = 1.0
        
        viewBackMessage.layer.cornerRadius = 3.0
        viewBackMessage.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
        viewBackMessage.layer.borderWidth = 1.0 */
        
       // viewBackImage.layer.cornerRadius = 3.0
       // viewBackImage.layer.borderColor = UIColor(named: Color_N_Dark200)?.cgColor
       // viewBackImage.layer.borderWidth = 1.0
       
        
        dropDownState.anchorView = btnSelectState
        dropDownState.selectionAction = { [self] (index: Int, item: String) in
            
            print("Selected item: \(item) at index: \(index)")
            self.strSelectedStateIndex = "\(index)"
            
            if item == "SELECT YOUR STATE"
            {
                btnSelectCity.isUserInteractionEnabled = false
                self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            }
            else
            {
                btnSelectCity.isUserInteractionEnabled = true
                self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            }
            /*
             SELECT YOUR STATE
             self.arrCityListString.append("SELECT YOUR CITY")
             
            
             
             */
         //   self.txtCity.text = ""
            self.txtState.text = item
            self.txtCity.text = "SELECT YOUR CITY"
            
            let stateIndex = Int(strSelectedStateIndex)
            let dicState = self.arrStateList[stateIndex!] as! [String: Any]
            
            let stateID = dicState["stateID"] as! String
            
            self.arrCityFilter = NSMutableArray()
            
            DispatchQueue.main.async
            {
                for i in 0..<self.arrCityList.count
                {
                    let dicCity = self.arrCityList[i] as! [String: Any]
                    print(dicCity)
                    if dicCity["idState"] as! String == stateID
                    {
                        
                        self.arrCityFilter.add(dicCity)
                    }
                }
              //  print(arrCityList.count)
               // print(arrCityFilter.count)
                
                self.arrCityListString = [String]()
                
                for i in 0..<self.arrCityFilter.count {
                    let city = self.arrCityFilter[i] as! [String: Any]
                    let cityName = city["name"] as! String
                    self.arrCityListString.append(cityName)
                }
                self.dropDownCity.dataSource = self.arrCityListString
            }
        }
        
        
        dropDownCity.anchorView = btnSelectCity
        dropDownCity.selectionAction = { [self] (index: Int, item: String) in
            
            print("Selected item: \(item) at index: \(index)")
            self.strSelectedCityIndex = "\(index)"
            if item == "SELECT YOUR CITY"
            {
                self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            }
            else
            {
                self.validatiohHeight(txtField: viewCityHeightConstant, val: 0)
            }
            self.txtCity.text = item
        }
        
       // viewUploadImageLeadingConstant.constant = CGFloat(Int((self.viewBackImage.frame.width - 140) / 2))
        viewMainBackImgHeightCons.constant = 150
        viewImgFirstUpload.isHidden = true
        viewImgSecondUpload.isHidden = true
        viewImgThirdUpload.isHidden = true
        viewImgFirstUpload.layer.cornerRadius = 4.0
        viewImgSecondUpload.layer.cornerRadius = 4.0
        viewImgThirdUpload.layer.cornerRadius = 4.0
        

    //    print(viewUploadImageLeadingConstant.constant)
        //(self.view.frame.width / 2) - 200
        self.getCityStateListAPICall()
        
    }
   /* func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
     
        if textField == txtContact
        {
            var specifiedChar = true
            let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
            specifiedChar = replacementStringIsLegal
            
            var charLimit = true
            let maxLength = 10
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            charLimit = newString.length <= maxLength
            
            if newString.length >= maxLength
            {
//                btnGetOTP.backgroundColor = UIColor(named: Color_Primary)
//
//                viewBackMobileNumberText.viewBorderWithCornerRadius()
            }
            else
            {
//                btnGetOTP.backgroundColor = UIColor(named: Color_N_Dark200)
//                if newString.length == 0
//                {
//                    constMobileNumberErrorH.constant = 16
//                    lblMobileNumberError.text = "Field cannot be empty."
//                    lblMobileNumberError.textColor = UIColor(named: Color_Error)
//                    imgViewMobileNumberError.image = UIImage(named: "IC_Error")
//                    viewBackMobileNumberText.viewTextFieldErrorBorder()
//                }
//                else
//                {
//                    constMobileNumberErrorH.constant = 0
//                    //  viewBackMobileNumberText.viewBorderWithCornerRadius()
//
//
//                }
            }
            
            if specifiedChar == true && charLimit == true {
                
                return true
            }
            else {
                return false
            }
        }
        return true
    }*/
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        /*
         self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
         self.validatiohHeight(txtField: lnContactHeightConst, val: 15)
         self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
         self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
         self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
         self.validatiohHeight(txtField: lbAddreesslineHeightConst, val: 0)
         self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
         self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
         self.validatiohHeight(txtField: lbStateConstHeight, val: 0)
         self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
         self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
         
         txtContact.viewTextFieldPrimaryBorder()
         txtAppartment.viewTextFieldPrimaryBorder()
         txtSociety.viewTextFieldPrimaryBorder()
         txtLandmark.viewTextFieldPrimaryBorder()
         txtAddress.viewTextFieldPrimaryBorder()
         txtArea.viewTextFieldPrimaryBorder()
         txtCity.viewTextFieldPrimaryBorder()
         txtState.viewTextFieldPrimaryBorder()
         txtPincode.viewTextFieldPrimaryBorder()
         txtMessage.viewTextFieldPrimaryBorder()
        
         */
       
//        if textField == txtNameOfPerson
//        {
//            viewBackNameOfPerson.viewTextFieldPrimaryBorder()
//
//            viewBackContact.viewTextFieldActiveBorder()
//            viewBackAppartment.viewTextFieldActiveBorder()
//            viewBackSociety.viewTextFieldActiveBorder()
//            viewBackLandmark.viewTextFieldActiveBorder()
//            viewBackAddress.viewTextFieldActiveBorder()
//            viewBackArea.viewTextFieldActiveBorder()
//            viewBackCity.viewTextFieldActiveBorder()
//            viewBackState.viewTextFieldActiveBorder()
//            viewBackPincode.viewTextFieldActiveBorder()
//            viewBackMessage.viewTextFieldActiveBorder()
//
//            self.validatiohHeight(txtField: lbNameHeightConst, val: 0)
//            return
//        }
//        if textField == txtContact
//        {
//            viewBackNameOfPerson.viewTextFieldActiveBorder()
//
//            viewBackContact.viewTextFieldPrimaryBorder()
//
//            viewBackAppartment.viewTextFieldActiveBorder()
//            viewBackSociety.viewTextFieldActiveBorder()
//            viewBackLandmark.viewTextFieldActiveBorder()
//            viewBackAddress.viewTextFieldActiveBorder()
//            viewBackArea.viewTextFieldActiveBorder()
//            viewBackCity.viewTextFieldActiveBorder()
//            viewBackState.viewTextFieldActiveBorder()
//            viewBackPincode.viewTextFieldActiveBorder()
//            viewBackMessage.viewTextFieldActiveBorder()
//
//            self.validatiohHeight(txtField: lnContactHeightConst, val: 0)
//            return
//        }
        if textField == txtAppartment
        {
           // viewBackNameOfPerson.viewTextFieldActiveBorder()
          //  viewBackContact.viewTextFieldActiveBorder()
            
            viewBackAppartment.viewTextFieldPrimaryBorder()
            
            viewBackSociety.viewTextFieldActiveBorder()
            viewBackLandmark.viewTextFieldActiveBorder()
           // viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            viewBackCity.viewTextFieldActiveBorder()
            viewBackState.viewTextFieldActiveBorder()
            viewBackPincode.viewTextFieldActiveBorder()
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbApartmentHeightConst, val: 0)
            return
        }
        if textField == txtSociety
        {
          //  viewBackNameOfPerson.viewTextFieldActiveBorder()
          //  viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            
            viewBackSociety.viewTextFieldPrimaryBorder()
            
            viewBackLandmark.viewTextFieldActiveBorder()
          //  viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            viewBackCity.viewTextFieldActiveBorder()
            viewBackState.viewTextFieldActiveBorder()
            viewBackPincode.viewTextFieldActiveBorder()
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbNoApartmentHeightConst, val: 0)
            return
        }
        if textField == txtLandmark
        {
          //  viewBackNameOfPerson.viewTextFieldActiveBorder()
          //  viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            viewBackSociety.viewTextFieldActiveBorder()
            
            viewBackLandmark.viewTextFieldPrimaryBorder()
            
          //  viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            viewBackCity.viewTextFieldActiveBorder()
            viewBackState.viewTextFieldActiveBorder()
            viewBackPincode.viewTextFieldActiveBorder()
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbLandMarkHEightConst, val: 0)
            return
        }
        if textField == txtArea
        {
           // viewBackNameOfPerson.viewTextFieldActiveBorder()
          //  viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            viewBackSociety.viewTextFieldActiveBorder()
            viewBackLandmark.viewTextFieldActiveBorder()
           // viewBackAddress.viewTextFieldActiveBorder()
            
            viewBackArea.viewTextFieldPrimaryBorder()
            
            viewBackCity.viewTextFieldActiveBorder()
            viewBackState.viewTextFieldActiveBorder()
            viewBackPincode.viewTextFieldActiveBorder()
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbAreaHeightConst, val: 0)
            return
        }
        if textField == txtCity
        {
          //  viewBackNameOfPerson.viewTextFieldActiveBorder()
         //   viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            viewBackSociety.viewTextFieldActiveBorder()
            viewBackLandmark.viewTextFieldActiveBorder()
        //    viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            
            viewBackCity.viewTextFieldPrimaryBorder()
            
            viewBackState.viewTextFieldActiveBorder()
            viewBackPincode.viewTextFieldActiveBorder()
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbCityHeightConst, val: 0)
            return
        }
        if textField == txtState
        {
           // viewBackNameOfPerson.viewTextFieldActiveBorder()
          //  viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            viewBackSociety.viewTextFieldActiveBorder()
            viewBackLandmark.viewTextFieldActiveBorder()
          //  viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            viewBackCity.viewTextFieldActiveBorder()
            
            viewBackState.viewTextFieldPrimaryBorder()
            
            viewBackPincode.viewTextFieldActiveBorder()
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbStateErrorConstant, val: 0)
            return
        }
        if textField == txtPincode
        {
          //  viewBackNameOfPerson.viewTextFieldActiveBorder()
         //   viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            viewBackSociety.viewTextFieldActiveBorder()
            viewBackLandmark.viewTextFieldActiveBorder()
         //   viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            viewBackCity.viewTextFieldActiveBorder()
            viewBackState.viewTextFieldActiveBorder()
            
            viewBackPincode.viewTextFieldPrimaryBorder()
            
            viewBackMessage.viewTextFieldActiveBorder()
            
            self.validatiohHeight(txtField: lbPinCodeHeightConst, val: 0)
            return
        }
        if textField == txtMessage
        {
         //   viewBackNameOfPerson.viewTextFieldActiveBorder()
          //  viewBackContact.viewTextFieldActiveBorder()
            viewBackAppartment.viewTextFieldActiveBorder()
            viewBackSociety.viewTextFieldActiveBorder()
            viewBackLandmark.viewTextFieldActiveBorder()
        //    viewBackAddress.viewTextFieldActiveBorder()
            viewBackArea.viewTextFieldActiveBorder()
            viewBackCity.viewTextFieldActiveBorder()
            viewBackState.viewTextFieldActiveBorder()
            viewBackPincode.viewTextFieldActiveBorder()
            
            viewBackMessage.viewTextFieldPrimaryBorder()
            self.validatiohHeight(txtField: lbMessageHeightConst, val: 0)
            return
        }
        
       
    }
    func validateSubmitForm() -> Bool {
        
//        if txtNameOfPerson.text! == "" {
//            showFieldErrorMessage(message: "Please enter your name")
//            return false
//        }
//        else if txtContact.text! == "" {
//            showFieldErrorMessage(message: "Please enter your contact number")
//            return false
//        }
//        else
        if txtSociety.text! == "" {
            showFieldErrorMessage(message: "Please enter your Appartment/Society Name")
            return false
        }
        else if txtAppartment.text! == "" {
            showFieldErrorMessage(message: "Please enter your No. of appartment/societies in the vicinity")
            return false
        }
        else if txtLandmark.text! == "" {
            showFieldErrorMessage(message: "Please enter your landmark")
            
            return false
        }
        else if txtArea.text! == "" {
            showFieldErrorMessage(message: "Please enter your area")
            return false
        }
        else if txtCity.text! == "" {
            showFieldErrorMessage(message: "Please select your City")
            return false
        }
        else if txtState.text! == "" {
            showFieldErrorMessage(message: "Please select your state")
            return false
        }
        else if txtPincode.text! == "" {
            showFieldErrorMessage(message: "Please enter your pincode")
            return false
        }
        else if txtMessage.text! == "" {
            showFieldErrorMessage(message: "Please type your message")
            return false
        }
        else {
            
            return true
        }
        
    }
    
    func showFieldErrorMessage(message: String) {
        
        let toast = Toast(text: message, delay: 0.0, duration: Delay.long)
        toast.show()
    }
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension RequestHUBFormVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {return}
        
        print(mediaType)
        
        switch mediaType {
        case "public.movie":
            // Handle movie here
            
            break
            
        case "public.image":
            // Handle Image here
            let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            let imgName = "\(getCurrentTimeStamp()).jpeg"
            
            
            /*
             let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
             
            // let imageData =
             //UIImageJPEGRepresentation(tempImage, 0.2)
             
           /*  if let data:Data = tempImage.jpegData(compressionQuality: 1.0) {
                 print(data.count)
                 self.pickerController(picker, didSelect: tempImage,imagedata: data)
               
             }*/
             let data = tempImage.compress(to: 300)
             self.pickerController(picker, didSelect: tempImage,imagedata: data)
             */
           // if let data:Data = tempImage.jpegData(compressionQuality: 1.0)
           // {
               // print(data.count)
                let data = tempImage.compress(to: 200)
                
               // let imgData = data as NSData
               // let data = imgData.compress(to: 300)
               
                 
            if self.arrSelectedImageData.count == 4
            {
                
            }
            else{
                self.arrSelectedImageData.append(data)
                self.arrSelectedImageString.append(imgName)
            }
                btnUploadImageCenter.isUserInteractionEnabled = false
                viewUploadImageCenter.isHidden = true
                viewUploadImage.isHidden = false
                
                //viewUploadImageLeadingConstant.constant = 0
                //Upload Images
                
           // }
            
            break
            
        default:
            break
        }
        
        self.dismiss(animated: false) { [self] in
            print("Image Selected")
            print(self.arrSelectedImageData.count)
            
            print(self.arrSelectedImageData)
            DispatchQueue.main.async {
                self.viewBackImage.layer.borderWidth = 0.0
                
                
              //  self.viewUploadImageLeadingConstant.constant = 20
              //  self.viewMainBackImgHeightCons.constant = 22
              
                if self.arrSelectedImageData.count == 1 {
                    
                    self.viewUploadImageTopHeightConst.constant = 30
                    //lbUploadImage.font = UIFont(name: "Rubik Medium", size: 15.0)
                    self.viewAllFieldEmptyConstHeight.constant = 0
                    self.viewBackImage.backgroundColor = .clear
                   // self.viewUploadImage.backgroundColor = .clear
                  //  self.viewUploadImageLeadingConstant.constant = 0
                   // self.viewUploadImageTop.constant = 0
                    self.viewMainBackImgHeightCons.constant = 120
                    self.viewImgFirstUpload.isHidden = false
                    self.viewImgSecondUpload.isHidden = true
                    self.viewImgThirdUpload.isHidden = true
                    self.lbFirstImage.text = self.arrSelectedImageString[0]
                    self.viewImgFirstUpload.backgroundColor = .lightGray
                    //self.imgUploadHeightConst.constant = 0
    //                self.viewMainBackImgHeightCons.constant = 0
                    self.viewFirstUploadHeightConst.constant = 36
                }
                else if self.arrSelectedImageData.count == 2
                {
                    self.viewUploadImageTopHeightConst.constant = 30
                   // lbUploadImage.font = UIFont(name: "Rubik Medium", size: 15.0)
                    self.viewBackImage.backgroundColor = .clear
                  //  self.viewUploadImage.backgroundColor = .clear
                 //   self.viewUploadImageLeadingConstant.constant = 0
                 //   self.viewUploadImageTop.constant = 0
                    self.viewMainBackImgHeightCons.constant = 130
                    self.viewImgFirstUpload.isHidden = false
                    self.viewImgSecondUpload.isHidden = false
                    self.viewImgThirdUpload.isHidden = true
                    self.lbSecondImage.text = self.arrSelectedImageString[1]
                    self.viewImgSecondUpload.backgroundColor = .lightGray
                   // self.imgUploadHeightConst.constant = 0
    //                self.viewMainBackImgHeightCons.constant = 0
                    self.viewSecondUploadHeightConst.constant = 36
                }
                else if self.arrSelectedImageData.count == 3 {
                    
                    self.viewUploadImageTopHeightConst.constant = 30
                  //  lbUploadImage.font = UIFont(name: "Rubik Medium", size: 15.0)
                    self.viewBackImage.backgroundColor = .clear
                 //   self.viewUploadImage.backgroundColor = .clear
                //    self.viewUploadImageLeadingConstant.constant = 0
                //    self.viewUploadImageTop.constant = 0
                    self.viewMainBackImgHeightCons.constant = 140
                    self.viewImgFirstUpload.isHidden = false
                    self.viewImgSecondUpload.isHidden = false
                    self.viewImgThirdUpload.isHidden = false
                    self.viewUploadImage.isHidden = true
                //    self.imgUploadHeightConst.constant = 0
                    self.lbThirdImage.text = self.arrSelectedImageString[2]
                    self.viewImgThirdUpload.backgroundColor = .lightGray
                    self.viewUploadImage.isHidden = true
                    
                    self.viewThirdUploadHeightConst.constant = 36
                    self.viewImgSecondUpload.backgroundColor = .lightGray
                    self.viewImgSecondUpload.backgroundColor = .lightGray
                   // self.imgUploadHeightConst.constant = 0
    //                self.viewMainBackImgHeightCons.constant = 0
                    self.viewSecondUploadHeightConst.constant = 36
                    
                    self.lbSecondImage.text = self.arrSelectedImageString[1]
                    
                    self.lbFirstImage.text = self.arrSelectedImageString[0]
                    self.viewImgFirstUpload.backgroundColor = .lightGray
                    //self.imgUploadHeightConst.constant = 0
    //                self.viewMainBackImgHeightCons.constant = 0
                    self.viewFirstUploadHeightConst.constant = 36
    //                self.viewMainBackImgHeightCons.constant = 0
                }
            }
           // self.tblViewImg.reloadData()
          //  self.tblViewImgHeightCons.constant = CGFloat(44 * self.arrSelectedImageString.count)
            
          
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RequestHUBFormVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSelectedImageString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! requestHubImgTblCell
        
        cell.lblMediaFileName.text = arrSelectedImageString[indexPath.row]
     //   cell.viewBackImageName.layer.cornerRadius = 8.0
        
        cell.btnDeleteImage.tag = indexPath.row
        cell.btnDeleteImage.addTarget(self, action: #selector(self.ActionDeleteImage(sender:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    @objc func ActionDeleteImage(sender: UIButton) {
        
        self.arrSelectedImageString.remove(at: sender.tag)
        self.arrSelectedImageData.remove(at: sender.tag)
        self.tblViewImgHeightCons.constant = CGFloat(44 * self.arrSelectedImageString.count)
        self.tblViewImg.reloadData()
        
        if self.arrSelectedImageData.count == 0 {
            
            self.viewMainBackImgHeightCons.constant = 128
            self.viewBackImage.layer.borderWidth = 1.0
            self.viewBackImgLeadingConstraint.priority = .defaultLow
        }
        else if self.arrSelectedImageData.count != 3 {
            
            self.viewMainBackImgHeightCons.constant = 22
        }
    }
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension RequestHUBFormVC {
    
    func aFunction(numbers: Array<Int>, position: Int) -> Array<Int>
    {
        var newNumbers = Array(numbers[0..<position])
        return newNumbers
    }
    func getCityStateListAPICall() {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.getCityStateListAPICall(dictionary: ["action": "locationlist"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
                let dicCityStateData = response["data"] as! [String: Any]
                
                self.arrStateList = dicCityStateData["state_list"] as! NSArray
                self.arrCityList = dicCityStateData["city_list"] as! NSArray
                self.arrStateListString = [String]()
                
                for i in 0..<arrStateList.count
                {
                    let state = arrStateList[i] as! [String: Any]
                    let stateName = state["stateName"] as? String ?? ""
                    
                    if i == 0
                    {
                        self.arrStateListString.append("SELECT YOUR STATE")
                        
                    }
                    else
                    {
                        self.arrStateListString.append(stateName)
                    }
                  
                }
                //self.arrStateListString.sort()
               // self.arrStateListString.insert("SELECT YOUR STATE", at: 0)
                
             //   print(arrStateListString[0])
                txtState.text = arrStateListString[0]
             
                    let dicState = self.arrStateList[0] as! [String: Any]
                    
                    let stateID = dicState["stateID"] as! String
                    
                    self.arrCityFilter = NSMutableArray()
                    
                    for i in 0..<self.arrCityList.count
                    {
                        let dicCity = arrCityList[i] as! [String: Any]
                        print(dicCity)
                        if dicCity["idState"] as! String == stateID
                        {
                            
                            self.arrCityFilter.add(dicCity)
                        }
                    }
                    
                    print(arrCityList.count)
                    print(arrCityFilter.count)
                    
                    self.arrCityListString = [String]()
                    
                    for i in 0..<arrCityFilter.count
                   {
                        let city = arrCityFilter[i] as! [String: Any]
                        let cityName = city["name"] as! String
                        
                        if i == 0
                        {
                            self.arrCityListString.append("SELECT YOUR CITY")
                        }
                        else
                        {
                            self.arrCityListString.append(cityName)
                        }
                        
                    }
                
                //self.arrCityListString.sort()
               // self.arrCityListString.insert("SELECT YOUR STATE", at: 0)
                
                dropDownCity.dataSource = self.arrCityListString
                    
                
                
                print(arrCityListString)
                txtCity.text = arrCityListString[0]
                
                dropDownState.dataSource = self.arrStateListString
                
                strSelectedStateIndex = "0"
                strSelectedCityIndex = "0"
                
                if txtState.text == "SELECT YOUR STATE"
                {
                    btnSelectCity.isUserInteractionEnabled = false
                }
                else
                {
                    btnSelectCity.isUserInteractionEnabled = true
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
    
    func submitRequestHubFormAPIWebServiceCall(mediaData: [Data]) {
        
        let stateIndex = Int(strSelectedStateIndex)
        let dicState = self.arrStateList[stateIndex!] as! [String: Any]
        let stateID = dicState["stateID"] as! String
        
        let cityIndex = Int(strSelectedCityIndex)
        let dicCity = self.arrCityFilter[cityIndex!] as! [String: Any]
        let cityID = dicCity["idCity"] as! String
        
        /*
         //   txtNameOfPerson.text = DicDataFromPinVc["first_name"] as? String
          //  txtContact.text = DicDataFromPinVc["contact_no"] as? String
         */
        //"address": "\(txtAddress.text!)",
     //   print(Int(txtSociety.text!)!)
        print(txtAppartment.text!)
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.submitRequestHubFormAPIWebServiceCall(media: mediaData, dictionary: ["action": "addhubrequest", "personName": "\(DicDataFromPinVc["first_name"] as! String)", "mobileNumber": "\(DicDataFromPinVc["contact_no"] as! String)", "societyName":  "\(txtSociety.text!)", "numberofApartments": "\(txtAppartment.text!)", "landmark": "\(txtLandmark.text!)", "area": "\(txtArea.text!)", "stateID": "\(stateID)", "cityID": "\(cityID)", "pincode": "\(txtPincode.text!)", "message": "\(txtMessage.text!)"]) { response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
                
               /* let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()*/
                
                self.viewAllFieldEmptyConstHeight.constant = 0
                
               let recieve = self.storyboard?.instantiateViewController(withIdentifier: "HubRequestRecieveVC") as! HubRequestRecieveVC
                recieve.dicSubmitRequestData = response
                self.navigationController?.pushViewController(recieve, animated: true)
                
                
            /*    let dicSubmitRequest = response["message"] as!String
                
                /*
                 
                 
                 lblTitle.text = "\(dicSubmitRequestData["message"] as! String)"
                 lblMessage.text = "\(dicSubmitRequest["team_message"] as! String)"
                 */
                viewInternetConnection.instance.showMsg(strmsg: dicSubmitRequest)
                
                viewInternetConnection.instance.ActionOkay =
                {
                    OngoingRideCancelRequestAlert.instance.HidePopup()
                    
                    self.navigationController?.popViewController(animated: true)
                }*/
           
                
            }
            else {
                
                self.viewAllFieldEmptyConstHeight.constant = 0
                
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






