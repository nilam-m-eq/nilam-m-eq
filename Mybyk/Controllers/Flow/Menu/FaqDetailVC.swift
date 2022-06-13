//
//  FaqDetailVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 05/07/21.
//

import UIKit
import Toaster


class FaqDetailVC: CommonViewController
{
    
    @IBOutlet var tblFAQDetail: UITableView!
    @IBOutlet var lbTitleofFAQ: UILabel!
    var FAQID : String!
    
    var aryFAQDetailsCell = NSMutableArray()
    var aryFAQDetailsSection = NSMutableArray()
    
    var strFAQTitle : String!
    @IBOutlet var viewMainPuter: UIView!
    
    var selectedIndx = -1

    var thereIsCellTapped = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblFAQDetail.tableFooterView = UIView()
        tblFAQDetail.tableHeaderView = UIView()
        
     //   self.tabBarController?.tabBar.isHidden = true
        
       // tblFAQDetail.estimatedRowHeight = 44
      // tblFAQDetail.rowHeight = UITableView.automaticDimension
        
        //tblFAQDetail.estimatedSectionHeaderHeight = 20
        //tblFAQDetail.sectionHeaderHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        lbTitleofFAQ.text = strFAQTitle
        
        print(FAQID!)
        self.setUIOnScreen()
    }
    @IBAction func btnBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // ********** All Button Actions ********** //
    
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension FaqDetailVC
{
    
    func setUIOnScreen()
    {
        tblFAQDetail.delegate = self
        tblFAQDetail.dataSource = self
        tblFAQDetail.tableFooterView = UIView()
        
        viewMainPuter.shadowZ100(frame: viewMainPuter.frame)
        
        self.ApiGetFAQDetail()
    }
    func ApiGetFAQDetail()
    {
        //GetFAQDetails
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.GetFAQDetails(dictionary: ["faqCategoryID": FAQID!]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false"
            {
               let DtDic = response["data"] as! NSDictionary
                let aryofFAQData = DtDic.value(forKey: "faqs_list") as! NSArray
              //  aryFAQDetails = NSMutableArray(array: aryofFAQData as! [Any], copyItems: true)
                
                for i  in 0..<aryofFAQData.count
                {
                    let dicData = aryofFAQData[i] as! NSDictionary
                    let dataCell = dicData.value(forKey: "answer")
                    let dicNewSection = ["Question" : dicData.value(forKey: "question"), "CollapseExpand" : false]
                  //  let dataSection = dicData.value(forKey: "question")
                 //  aryFAQDetailsSection.add(dataSection!)
                    aryFAQDetailsCell.add(dataCell!)
                 
                    aryFAQDetailsSection.add(dicNewSection)
                }
                print(aryFAQDetailsCell)
                print(aryFAQDetailsSection)
//                var aryFAQDetailsCell = NSMutableArray()
//                var aryFAQDetailsSection = NSMutableArray()
                
                tblFAQDetail.reloadData()
                

            }
            else {
                
                CommonClass.removeProgressHudCycling(viewController: self)
                    
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                    toast.show()
             
            }
            
        } blockError: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
}
extension FaqDetailVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return aryFAQDetailsSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       // return 0
        
        let dic = aryFAQDetailsSection[section] as! [String : Any]
        let checkFlag = dic["CollapseExpand"] as! Bool
        
        if checkFlag == false
        {
            return 0
        }
        else
        {
            return 1
        }
       /* if selectedIndx == -1
        {
            return 0
        }
        else
        {
            return aryFAQDetailsCell.count
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFAQDetailCollapse", for: indexPath) as! CellFAQDetailCollapse
        
       // cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        
      //  print(aryFAQDetails)
        
            //cell.viewMainOuter.shadowRoundView(frame: <#T##CGRect#>)
        
      //  cell.viewMainOuter.layer.cornerRadius = 8.0
        //cell.viewMainOuter.frame.height / 2
     //   cell.viewMainOuter.shadowZ100(frame:  cell.viewMainOuter.frame)
            //shadowRoundView(frame: cell.viewMainOuter.frame)
        
//                let strAtt = (aryFAQDetailsCell[indexPath.row] as! String).htmlToAttributedString
//                let Conver = NSMutableAttributedString(attributedString: strAtt!)
//                let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
//                Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Ragular", size: 13.0)!, range: myRange)
//
//                cell.lbDetails.attributedText = Conver
        
        let strAtt1 = aryFAQDetailsCell[indexPath.section] as! String
        
       
       // let trimmed = (strAtt1 as NSString).trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        let strAtt = strAtt1.htmlToString
       // print("TRI",trimmed)
        
       
        //(aryFAQDetailsSection[section]  as! String).htmlToAttributedString
       // let strAtt = (aryFAQDetailsCell[indexPath.section] as! String).htmlToAttributedString
        
      /*  let Conver = NSMutableAttributedString(attributedString: strAtt!)
        let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
        Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
        Conver.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "Color_N_Dark200")!, range: myRange)
        
        
         
         
        cell.lbDetails.attributedText = Conver*/
        
        cell.lbDetails.text = strAtt
        
        /*
         //MARK: - Dynamic label height
         let heightLAbel = self.heightForView(text: (response["message"] as? String)!, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self.view.frame.width - 40)
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
        
    //   cell.lbDetails.attributedText = (aryFAQDetailsCell[indexPath.section] as! String).htmlToAttributedString
    //    cell.lbDetails.text = (aryFAQDetailsCell[indexPath.section] as! String)

//        / (aryFAQDetailsCell[indexPath.row] as! NSArray).count - 1
        
        cell.viewMainOuter.clipsToBounds = true
        cell.viewMainOuter.layer.cornerRadius = 10
        cell.viewMainOuter.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        cell.viewMainOuter.shadowZ100(frame:cell.viewMainOuter.frame)
        
        /*
         yourView.clipsToBounds = true
         yourView.layer.cornerRadius = 10
         yourView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
         */
     /*   if  indexPath.row == aryFAQDetailsCell.count - 1
        {
            cell.viewMainOuter.shadowZ100(frame:cell.viewMainOuter.frame)
            
           // cell.viewMainOuter.clipsToBounds = true
          //  cell.viewMainOuter.layer.cornerRadius = 8
            
            cell.viewMainOuter.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
           
        }
        else
        {
           
            cell.viewMainOuter.layer.cornerRadius = 0
          
         
        }*/
        
//        let strAtt = (aryFAQDetailsCell[indexPath.row] as! String).htmlToAttributedString
//        let Conver = NSMutableAttributedString(attributedString: strAtt!)
//        let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
//        Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Ragular", size: 13.0)!, range: myRange)
//
//        cell.lbDetails.attributedText = Conver
        
       // cell.btnCollapse.addTarget(self, action: "expandorcollapsed:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
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
    func calculateHeight(inString:String) -> CGFloat
        {
            let messageString = inString
          //  let attributes : [String : Any] = [NSAttributedString.Key.font : UIFont(name: "Rubik Regular", size: 14.0)!]
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Rubik Regular", size: 14.0)! ]
            
            // Conver = NSMutableAttributedString(attributedString: strAtt!)
            //  let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
            //  Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
            
            let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)

            let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 348.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

            let requredSize:CGRect = rect
            return requredSize.height
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
      //  return UITableView.automaticDimension
        let strAtt = (aryFAQDetailsCell[indexPath.section] as! String).htmlToString
       
        /*let heightOfRow = self.calculateHeight(inString: strAtt)

        return heightOfRow + 20*/
        
       let heightLAbel = self.heightForView(text: strAtt, font: UIFont(name: "Rubik Regular", size: 14.0)!, width: self.view.frame.width - 80)
        
        return heightLAbel
//        if indexPath.section == selectedIndx{
//            return UITableView.automaticDimension
//           }else{
//               return 0
//           }
       
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CellFAQHeaderExpand") as! CellFAQHeaderExpand
        headerCell.btnExpand.tag = section
        
      //  headerCell.viewSction.shadowZ100(frame: headerCell.viewSction.frame)
        
        let datDic = aryFAQDetailsSection[section] as! [String : Any]
        
        /*
         cellView.viewSectionMainCorner.clipsToBounds = true
         cellView.viewSectionMainCorner.layer.cornerRadius = 8
        
         if arySetion[section] == true
         {
             cellView.viewSectionMainCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
             cellView.btnArrowImageChange.setImage(UIImage(named: "IC_ExpandMoreGreen"), for: UIControl.State.normal)
            
         }
         else
         {
             cellView.viewSectionMainCorner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
             cellView.btnArrowImageChange.setImage(UIImage(named: "IC_ArrowTop"), for: UIControl.State.normal)
         }
         */
     //   headerCell.viewSction.clipsToBounds = true
     //   headerCell.viewSction.layer.cornerRadius = 8
        
        print(datDic["CollapseExpand"] as! Bool)
        if datDic["CollapseExpand"] as! Bool == true
        {
           // headerCell.viewSectionLine.isHidden = false
            headerCell.viewSectionLine.isHidden = true
            headerCell.viewSction.shadowZ100(frame:headerCell.viewSction.frame)
            headerCell.viewSction.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            headerCell.btnSetImageExpandCollapse.setImage(UIImage(named: "IC_Arrow_Top"), for: UIControl.State.normal)
            //datDic["CollapseExpand"] = false
        }
        else
        {
           // headerCell.viewSectionLine.isHidden = true
            headerCell.viewSectionLine.isHidden = true
            headerCell.viewSction.shadowZ100(frame:headerCell.viewSction.frame)
            headerCell.viewSction.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
            
            headerCell.btnSetImageExpandCollapse.setImage(UIImage(named: "IC_ForwordArrow"), for: UIControl.State.normal)
           // datDic["CollapseExpand"] = true
        }
        
        //headerCell.viewSction.layer.cornerRadius = 8.0
      //  cell.viewBackMain.shadowZ100(frame: cell.viewBackMain.frame)
        
        headerCell.selectionStyle = .none
        
//        if selectedIndx == section
//        {
//           // headerCell.btnExpand.setImage(UIImage(systemName: ), for: <#T##UIControl.State#>)
//          //  headerCell.btnExpand.setImage(UIImage(named: IC_Eclaps), for: UIControl.State.normal)
//        }
//        else
//        {
//           // headerCell.btnExpand.setImage(UIImage(named: IC_ForwordArrow), for: UIControl.State.normal)
//        }
       
        //headerCell.lbHeaderTitle.attributedText = (aryFAQDetailsSection[section]  as! String).htmlToAttributedString
        
      
      //  headerCell.lbHeaderTitle.attributedText = myString
        
       
        DispatchQueue.main.async {
        
            let dic = (self.aryFAQDetailsSection[section]  as! [String : Any])
            let strAtt = (dic["Question"] as! String).htmlToAttributedString
            //(aryFAQDetailsSection[section]  as! String).htmlToAttributedString
            let Conver = NSMutableAttributedString(attributedString: strAtt!)
            let myRange = NSRange(location: 0, length: strAtt!.length) // range starting at location 17 with a lenth of 7: "Strings"
            Conver.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Rubik Regular", size: 15.0)!, range: myRange)
            Conver.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "Color_N_Dark900")!, range: myRange)
            headerCell.lbHeaderTitle.attributedText = Conver
        }
      
        
//        DispatchQueue.main.async {
//
//            headerCell.lbHeaderTitle.text = strAtt?.string
//        }
        headerCell.btnExpand.addTarget(self, action: #selector(FaqDetailVC.backAction(_sender:)), for: UIControl.Event.touchUpInside)
        
        return headerCell
    }
    @objc public func backAction(_sender: UIButton)
    {
       // let section = _sender.tag
        
        print("selected index",_sender.tag)
           if selectedIndx != _sender.tag {
               self.thereIsCellTapped = true
               self.selectedIndx = _sender.tag
           }
           else {
               // there is no cell selected anymore
               self.thereIsCellTapped = false
               self.selectedIndx = -1
           }
        
     //   let indexpath = IndexPath(row: _sender.tag, section: _sender.tag)
     //   tblFAQDetail.reloadRows(at: [indexpath], with: UITableView.RowAnimation.fade)
        UIView.animate(withDuration: 0.5, delay: 0.2) {
            
            self.view.layoutIfNeeded()
        }
        var datDic = aryFAQDetailsSection[_sender.tag] as! [String : Any]
        
        if datDic["CollapseExpand"] as! Bool == true
        {
            datDic["CollapseExpand"] = false
        }
        else
        {
            datDic["CollapseExpand"] = true
        }
       
        aryFAQDetailsSection.replaceObject(at: _sender.tag, with: datDic)
        print(aryFAQDetailsSection)
        
        //tblFAQDetail.reloadData()
        
        UIView.transition(with: tblFAQDetail,
                          duration: 0.60,
                          options: .transitionCrossDissolve,
                          animations: { self.tblFAQDetail.reloadData() })
          // tblFAQDetail.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
}
