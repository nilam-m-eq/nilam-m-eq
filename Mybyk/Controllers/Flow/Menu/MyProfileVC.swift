//
//  MyProfileVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit
import Toaster
import Foundation

class MyProfileVC: CommonViewController, LineChartDelegate {
 
    
    @IBOutlet var imgLeft: UIImageView!
    @IBOutlet var imgRight: UIImageView!
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet var lbDistanceCoveredKms: UILabel!
    @IBOutlet weak var viewBackProfile: UIView!
    @IBOutlet weak var viewBackChart: UIView!
    @IBOutlet weak var viewBackTotalTime: UIView!
    @IBOutlet weak var viewBackTotalRides: UIView!
    @IBOutlet weak var viewBackRoutes: UIView!
    @IBOutlet weak var viewBackMyBest: UIView!
    //@IBOutlet weak var viewLineChart: LineChart!
    @IBOutlet weak var imgViewProPic: UIImageView!
    @IBOutlet var lbTotalRide: UILabel!
    @IBOutlet var collGraphData: UICollectionView!
    
    @IBOutlet var lbMyBestBottom: UILabel!
    @IBOutlet var lbTotalKm: UILabel!
    @IBOutlet var lbRide: UILabel!
    @IBOutlet var lbTotalTime: UILabel!
    @IBOutlet var lbMyBest: UILabel!
    @IBOutlet var lbDistance: UILabel!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbWeekName: UILabel!
    @IBOutlet var viewMybest: UIView!
    @IBOutlet var viewDistance: UIView!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    
    var aryListGraph = [AnyObject]()
    var tmpAryListGraph = [AnyObject]()
    var tmpAryListGraphStored = [AnyObject]()
    
    var dicProfileData = [String : Any]()
    var dicDataNext = [String : Any]()
   
    
    var TotalrideCount = 0
    var TotalCount = 0
    
    let linechrtView = LineChart()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.tabBarController?.tabBar.isHidden = true
        
        linechrtView.delegate = self
        
        collGraphData.delegate = self
        collGraphData.dataSource = self
        imgRight.isHidden = true
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
       // self.viewBackProfile.viewBorderWithCornerRadius()
        
//        self.viewBackChart.viewBorderWithCornerRadius()
//        self.viewBackTotalTime.viewBorderWithCornerRadius()
//        self.viewBackTotalRides.viewBorderWithCornerRadius()
//        self.viewBackRoutes.viewBorderWithCornerRadius()
//        self.viewBackMyBest.viewBorderWithCornerRadius()
//
        self.viewBackProfile.shadowZ100(frame: self.viewBackProfile.frame)
        self.viewBackChart.shadowZ100(frame: self.viewBackProfile.frame)
        self.viewBackTotalTime.shadowZ100(frame: self.viewBackProfile.frame)
        self.viewBackTotalRides.shadowZ100(frame: self.viewBackProfile.frame)
        self.viewBackRoutes.shadowZ100(frame: self.viewBackProfile.frame)
        self.viewBackMyBest.shadowZ100(frame: self.viewBackProfile.frame)
        
//        self.viewBackProfile.shadowSecondaryView(frame: self.viewBackProfile.frame)
//        self.viewBackChart.shadowSecondaryView(frame: self.viewBackChart.frame)
//        self.viewBackTotalTime.shadowSecondaryView(frame: self.viewBackTotalTime.frame)
//        self.viewBackTotalRides.shadowSecondaryView(frame: self.viewBackTotalRides.frame)
//        self.viewBackRoutes.shadowSecondaryView(frame: self.viewBackRoutes.frame)
//        self.viewBackMyBest.shadowSecondaryView(frame: self.viewBackMyBest.frame)
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionEdit(_ sender: UIButton) {
        
        let editPro = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileEditVC") as! MyProfileEditVC
        
        print(dicProfileData)
        editPro.dicGetData = dicProfileData
        self.navigationController?.pushViewController(editPro, animated: true)
    }
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat, viewName viewRight: UIView)
    {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: viewRight.frame.size.width - borderWidth, y: 0, width: borderWidth, height: viewRight.frame.size.height)
        viewRight.addSubview(border)
    }
    @IBAction func btnRightClicked(_ sender: Any)
    {
        DispatchQueue.main.async
        {
            self.tmpAryListGraph.removeAll()
            self.tmpAryListGraph = self.tmpAryListGraphStored
            
            self.TotalrideCount =  self.TotalrideCount - 1
            
            print("TOTAL Right", self.TotalrideCount)
            if  self.TotalrideCount == 0
            {
                self.imgRight.isHidden = true
                self.collGraphData.reloadData()
                
                
            }
            else
            {
                self.imgLeft.isHidden = false
                self.collGraphData.reloadData()
                
                
            }
        }
    }
    @IBAction func btnLeftClicked(_ sender: Any)
    {
        DispatchQueue.main.async
        {
           // tmpAryListGraphStored
            self.tmpAryListGraph.removeAll()
            self.tmpAryListGraph = self.tmpAryListGraphStored
            
            self.TotalrideCount =  self.TotalrideCount + 1
            
            print("TOTAL Left", self.TotalrideCount)
            if  self.TotalrideCount ==  self.TotalCount - 1
            {
                self.imgLeft.isHidden = true
                
                self.collGraphData.reloadData()
                
            }
            else
            {
                self.imgRight.isHidden = false
                
                self.collGraphData.reloadData()
                
            }
        }
    }
    
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat])
    {
        
    }
  
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension MyProfileVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return tmpAryListGraph.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:self.view.frame.size.width - 110, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGraphData", for: indexPath) as! cellGraphData
        
        
        let datDicWeekWise = tmpAryListGraph[TotalrideCount] as! [String : Any]
        let Graphdata = datDicWeekWise["allDaysDistanceData"] as! Array<AnyObject>
        
        print(Graphdata)
        if TotalrideCount == 0
        {
            lbWeekName.text = "This Week"
            
        }
        else
        {
            let startDate =  self.ConvertDate(strDate: datDicWeekWise["weekStartDate"] as! String)
            let endDate = self.ConvertDate(strDate: datDicWeekWise["weekEndDate"]as! String)
          
            lbWeekName.text = String(format: "%@-%@", startDate,endDate)
        }
        linechrtView.frame = CGRect(x: cell.viewChart.frame.origin.x, y: cell.viewChart.frame.origin.y, width: self.view.frame.size.width - 125, height: cell.viewChart.bounds.height)
        
      //  linechrtView.removeFromSuperview()
      
        cell.viewChart.addSubview(linechrtView)
      
        if Graphdata.count == 0
        {
          //  linechrtView.clearAll()
            linechrtView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            cell.viewChart.addSubview(linechrtView)
            linechrtView.isHidden = true
            cell.lbNoDataFound.isHidden = false
         //   cell.lbNoDataFound.bringSubviewToFront(cell.viewChart)
        }
        else
        {
            linechrtView.isHidden = false
            cell.lbNoDataFound.isHidden = true
         
            var GraphValue = [CGFloat]()
            
            Graphdata.forEach { value in
                print(value)
                let dat = value as! [String : Any]
                
                let fl: CGFloat = CGFloat((dat["totalRideDistance"] as! NSString).doubleValue)
          
                GraphValue.append(fl)
               
            }
            print(GraphValue)
            let data = GraphValue
            let xLabels: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            
           print(data)
            
         
            
            linechrtView.clearAll()
            
           // linechrtView.clear()
            
            linechrtView.backgroundColor = UIColor.clear
          //  linechrtView.reloadInputViews()
            linechrtView.animation.enabled = true
            linechrtView.area = false
            linechrtView.x.labels.visible = true
            linechrtView.x.grid.count = 5
            linechrtView.y.grid.count = 5
            linechrtView.x.labels.values = xLabels
            linechrtView.y.labels.visible = true
            linechrtView.addLine(data)
          
            
        }
        
      /*
       let datDicWeekWise = tmpAryListGraph[indexPath.row] as! [String : Any]
       let Graphdata = datDicWeekWise["allDaysDistanceData"] as! Array<AnyObject>
       
       if indexPath.row == 0
        {
            lbWeekName.text = "This Week"
            
            if Graphdata.count == 0
            {
                cell.lbNoDataFound.isHidden = false
            }
            else
            {
                cell.lbNoDataFound.isHidden = true
             
                var GraphValue = [CGFloat]()
                
                Graphdata.forEach { value in
                    print(value)
                    let dat = value as! [String : Any]
                    
                    let fl: CGFloat = CGFloat((dat["totalRideDistance"] as! NSString).doubleValue)
              
                    GraphValue.append(fl)
                   
                }
                print(GraphValue)
                let data = GraphValue
                let xLabels: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                
                linechrtView.frame = CGRect(x: cell.viewChart.frame.origin.x, y: cell.viewChart.frame.origin.y, width: cell.viewChart.frame.size.width, height: cell.viewChart.frame.size.height)
           
                linechrtView.animation.enabled = true
                linechrtView.area = false
                linechrtView.x.labels.visible = true
                linechrtView.x.grid.count = 5
                linechrtView.y.grid.count = 5
                linechrtView.x.labels.values = xLabels
                linechrtView.y.labels.visible = true
                linechrtView.addLine(data)
                
                cell.viewChart.addSubview(linechrtView)
                
            }
        }
        else
        {
              let startDate =  self.ConvertDate(strDate: datDicWeekWise["weekStartDate"] as! String)
              let endDate = self.ConvertDate(strDate: datDicWeekWise["weekEndDate"]as! String)
            
            lbWeekName.text = String(format: "%@-%@", startDate,endDate)
            
            if Graphdata.count == 0
            {
                cell.lbNoDataFound.isHidden = false
            }
            else
            {
                cell.lbNoDataFound.isHidden = true
             
                var GraphValue = [CGFloat]()
                
                Graphdata.forEach { value in
                    print(value)
                    let dat = value as! [String : Any]
                    
                    let fl: CGFloat = CGFloat((dat["totalRideDistance"] as! NSString).doubleValue)
              
                    GraphValue.append(fl)
                   
                }
                print(GraphValue)
                let data = GraphValue
                let xLabels: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                
                linechrtView.frame = CGRect(x: cell.viewChart.frame.origin.x, y: cell.viewChart.frame.origin.y, width: cell.viewChart.frame.size.width, height: cell.viewChart.frame.size.height)
           
                linechrtView.animation.enabled = true
                linechrtView.area = false
                linechrtView.x.labels.visible = true
                linechrtView.x.grid.count = 5
                linechrtView.y.grid.count = 5
                linechrtView.x.labels.values = xLabels
                linechrtView.y.labels.visible = true
                linechrtView.addLine(data)
                
                cell.viewChart.addSubview(linechrtView)
                
            }
        }*/
        
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
        
            cell.alpha = 1
        }

    }
    func ConvertDate(strDate : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let dateObj = dateFormatter.date(from: strDate)
        
        dateFormatter.dateFormat = "dd MMM"
        let dateString = dateFormatter.string(from: dateObj!)
        print(dateString)
        
        return dateString
      //  print("Dateobj: \(dateObj)")
    }
}
extension MyProfileVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        
        self.addRightBorder(with: UIColor(named: "Color_N_Light500"), andWidth: 1, viewName: viewDistance)
        self.addRightBorder(with: UIColor(named: "Color_N_Light500"), andWidth: 1, viewName: viewMybest)
        self.consViewBackDetailWidth.constant = self.view.frame.width
        imgViewProPic.layer.cornerRadius = imgViewProPic.frame.size.width / 2
        

//        let data: [CGFloat] = [0, 0, 2, 0, 10, 0, 5]
//        let xLabels: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "July"]
//
//        self.viewLineChart.animation.enabled = true
//        self.viewLineChart.area = false
//        self.viewLineChart.x.labels.visible = true
//        self.viewLineChart.x.grid.count = 5
//        self.viewLineChart.y.grid.count = 5
//        self.viewLineChart.x.labels.values = xLabels
//        self.viewLineChart.y.labels.visible = true
//        self.viewLineChart.addLine(data)
        
        self.GetProfileData()
    }
    
    
}
extension MyProfileVC
{
    func GetProfileData()
    {
        CommonClass.loadProgressHudCycling(viewController: self)
      
        APIService.sharedInstance.getProfileData(dicBannerBodyParama: ["action": "getDetails"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
            
                
                let dataDisp = response["data"] as! [String : Any]
                aryListGraph = dataDisp["allRidesData"] as! [AnyObject]
                TotalCount = aryListGraph.count
                
                
                tmpAryListGraph = dataDisp["allRidesData"] as! [AnyObject]
                tmpAryListGraphStored = dataDisp["allRidesData"] as! [AnyObject]
                dicProfileData = dataDisp["overview"] as! [String : Any]
                
                lbDistance.text =  dataDisp["total_ride_distance"] as? String
                
                print(dataDisp["totalRides"]!)
                print(dataDisp["total_ride_duration"]!)
                
                lbRide.text = "\(dataDisp["totalRides"]!)"
                lbMyBest.text = "\(dataDisp["total_ride_duration"]!)"
                
                lbName.text = dicProfileData["name"] as? String
                
                  if let strImg = dicProfileData["photograph"] as? String {
                      
                      self.imgViewProPic.sd_setImage(with: URL(string: strImg), placeholderImage: UIImage(named: ""))
                  }
                  else {
                      
                      let lblNameInitialize = UILabel()
                      lblNameInitialize.frame.size = CGSize(width: 100.0, height: 100.0)
                      lblNameInitialize.textColor = UIColor.white
                      lblNameInitialize.text = String((dicProfileData["firstName"] as! String).first!) + String((dicProfileData["lastName"] as! String).first!)
                      lblNameInitialize.textAlignment = NSTextAlignment.center
                      lblNameInitialize.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
                      lblNameInitialize.backgroundColor = UIColor(named: Color_Primary)
                      UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
                      lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
                      self.imgViewProPic.image = UIGraphicsGetImageFromCurrentImageContext()
                      UIGraphicsEndImageContext()
                  }
              /*  let datDicWeekWise = tmpAryListGraph[0] as! [String : Any]
                let Graphdata = datDicWeekWise["allDaysDistanceData"] as! Array<AnyObject>
                
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = collGraphData.dequeueReusableCell(withReuseIdentifier: "cellGraphData", for: indexPath) as! cellGraphData
                
                if Graphdata.count == 0
                {
                    cell.lbNoDataFound.isHidden = false
                    cell.viewChart.isHidden = true
                   
                }
                else
                {
                    var GraphValue = [CGFloat]()
                    
                    Graphdata.forEach { value in
                        print(value)
                        let dat = value as! [String : Any]
                        
                        let fl: CGFloat = CGFloat((dat["totalRideDistance"] as! NSString).doubleValue)
                        
                      //  let ConvertFloat = CGFloat(String(format: "%.4f",dat["totalRideDistance"] as! CVarArg))
                        //(dat["totalRideDistance"]).floatValue
                        //(dat["totalRideDistance"] as! String)
                        //"\(dat["totalRideDistance"])" as! CGFloat
                        GraphValue.append(fl)
                       
                    }
                    
                  //  cell.viewChart.reloadInputViews()
                    print(GraphValue)
                 //   let data: [CGFloat] = [0, 0, 2, 0, 10, 0, 5]
                    let data = GraphValue
                    let xLabels: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                    
                    
                    cell.lbNoDataFound.isHidden = true
                    cell.viewChart.isHidden = false
                    
                    cell.viewChart.animation.enabled = true
                    cell.viewChart.area = false
                    cell.viewChart.x.labels.visible = true
                    cell.viewChart.x.grid.count = 5
                    cell.viewChart.y.grid.count = 5
                    cell.viewChart.x.labels.values = xLabels
                    cell.viewChart.y.labels.visible = true
                    cell.viewChart.addLine(data)
                
                
                }
               */
                //allDaysDistanceData
                collGraphData.reloadData()
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
            
        } blockerror: { error in
            CommonClass.removeProgressHudCycling(viewController: self)
            
        }
    }
    
}

