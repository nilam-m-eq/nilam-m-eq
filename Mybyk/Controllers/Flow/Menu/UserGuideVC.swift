//
//  UserGuideVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit
import DropDown
import Toaster
import SDWebImage
import SwiftyGif

class UserGuideVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var viewNoUserGuideData: UIView!
    @IBOutlet var CollSliderImage: UICollectionView!
    @IBOutlet var btnDropDownFAQ: UIButton!
    @IBOutlet var txtFindJob: UITextField!
    @IBOutlet var viewFindJob: UIView!
    let dropDownFAQ = DropDown()
    var aryUserGuideList = NSMutableArray()
    var aryUserGuideListtmp = NSMutableArray()
    
    @IBOutlet var lbHeader: UILabel!
    @IBOutlet var lbDetails: UILabel!
    var arrUserGuide = [String]()
    
    var checkUSerData : Bool!
    
    @IBOutlet var viewNext: UIView!
    @IBOutlet var viewPrevious: UIView!
    
    var NextVal = 0
    var PreviVal = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = true
        CollSliderImage.delegate = self
        CollSliderImage.dataSource = self
       
        CollSliderImage.layer.cornerRadius = 10.0
        CollSliderImage.clipsToBounds = true
        
        viewFindJob.viewBorderWithCornerRadius()
        
        viewPrevious.isHidden = true
        viewNoUserGuideData.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //  self.ApiGetUserGuide()
        
        if checkUSerData ==  false
        {
            viewNoUserGuideData.isHidden = false
            self.view.bringSubviewToFront(viewNoUserGuideData)
            return
        }
        if checkUSerData == true
        {
            for i in 0..<aryUserGuideList.count
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
            
            CollSliderImage.reloadData()
        }
     /*   else
        {
             
        }
        */
     
      
    }
    //MARK: - button action
    
    @IBAction func btnPreviousClicked(_ sender: Any)
    {
       
        PreviVal = PreviVal - 1
        
        print("PREVIOUS",PreviVal)
        viewPrevious.isHidden = true
        viewNext.isHidden = false
        
        let dicData = self.aryUserGuideListtmp[PreviVal] as! NSDictionary
        let strAtt = "\(dicData["description"] as! String)".htmlToAttributedString
        let Conver = NSMutableAttributedString(attributedString: strAtt!)
        let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
        Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
        
        self.lbDetails.attributedText = Conver
        self.lbHeader.text = "\(dicData["screenTitle"] as! String)"
        txtFindJob.text = "\(dicData["userGuideTitle"] as! String)"
        
        self.aryUserGuideList.removeAllObjects()
        self.aryUserGuideList.add(self.aryUserGuideListtmp[PreviVal])
     
    
        self.CollSliderImage.reloadData()
    }
    @IBAction func btnNextXlixked(_ sender: Any)
    {
      
        PreviVal = PreviVal + 1
        print("NEXT",PreviVal)
        viewPrevious.isHidden = false
        viewNext.isHidden = true
    
        let dicData = self.aryUserGuideListtmp[PreviVal] as! NSDictionary
        

        let strAtt = "\(dicData["description"] as! String)".htmlToAttributedString
        let Conver = NSMutableAttributedString(attributedString: strAtt!)
        let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
        Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
        
        self.lbDetails.attributedText = Conver
     
        self.lbHeader.text = "\(dicData["screenTitle"] as! String)"
        txtFindJob.text = "\(dicData["userGuideTitle"] as! String)"
      
     
        self.aryUserGuideList.removeAllObjects()
        self.aryUserGuideList.add(self.aryUserGuideListtmp[PreviVal])
      
        self.CollSliderImage.reloadData()
      
    }
    @IBAction func btnFindJobClicked(_ sender: Any)
    {
        print(dropDownFAQ.dataSource)
        if dropDownFAQ.dataSource.count == 1
        {
            
        }
        else
        {
            dropDownFAQ.show()
        }
    }
    
    // ********** All Button Actions ********** //
    
    
    //MARK: - collectionview datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return aryUserGuideList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollFAQSlider", for: indexPath) as! CellCollFAQSlider
    //    print(aryUserGuideList[indexPath.row])
        
        let dicDisp = aryUserGuideList[indexPath.row] as! NSDictionary
        print(dicDisp)
        let imageGet = dicDisp.value(forKey: "userGuideImage") as! String
        
      //  print(imageGet)
        
       // let gifURL : String = "http://www.gifbin.com/bin/4802swswsw04.gif"
        cell.activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            let imageURL = UIImage.gifImageWithURL(imageGet)
            cell.imgSlideDis.image = imageURL
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.isHidden = true
        }
        
        //= UIImageView(image: imageURL)
       // let imageView3 = UIImageView(image: imageURL)
        
        /*    do {
                let gif = try UIImage(gifName: imageGet)
                cell.imgSlideDis.setGifImage(gif, loopCount: -1)

            } catch {

                print("EROR",error)
            }*/
      /*  do
        {
            
//            print(imageGet)
//            let gif = try UIImage(gifName: imageGet)
//            cell.imgSlideDis.setGifImage(gif)
        }
        catch
        {
            print("EROR",error)
        }*/
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        return CGSize(width: self.view.frame.size.width - 40, height: 350)
//    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension UserGuideVC {
    
    func setUIOnScreen() {
        
        
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
                let dicAdd = response["data"] as? NSDictionary
                
                print(dicAdd!)
                
                aryUserGuideList = NSMutableArray(array:dicAdd!.value(forKey: "userguide_list") as! NSArray)
                aryUserGuideListtmp = NSMutableArray(array:dicAdd!.value(forKey: "userguide_list") as! NSArray)
                
                print(aryUserGuideListtmp[0])
               // aryUserGuideList.add(aryUserGuideListtmp[0])
                print(aryUserGuideList)
                //dicAdd.value(forKey: "userguide_list")
                //(dicAdd?.value(forKey: "userguide_list") as? NSMutableArray)!
                //(response["userguide_list"] as? NSMutableArray)!
                
                for i in 0..<aryUserGuideList.count
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
                
                CollSliderImage.reloadData()
                 
            }
            else {
                
                viewNoUserGuideData.isHidden = false
                self.view.bringSubviewToFront(viewNoUserGuideData)
                
                CommonClass.removeProgressHudCycling(viewController: self)
                    
               // let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                 //   toast.show()
             
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
}
