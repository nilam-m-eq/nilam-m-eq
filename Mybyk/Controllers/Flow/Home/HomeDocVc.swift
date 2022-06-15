//
//  HomeDocVc.swift
//  Mybyk
//
//  Created by Parth Kapadia on 16/03/22.
//

import UIKit

class HomeDocVc: UIViewController
{
   

    @IBOutlet var btnOkay: UIButton!
    @IBOutlet var btnDocUpload: UIButton!
    @IBOutlet var lbDesc: UILabel!
    
    var strVal : String!
    var strDocError : String!
    var strDocVerify : String!
    var strDocText : String!
    var strStationID : String!
    var indexVal : Int!
    
    @IBOutlet var stackView: UIStackView!
    var partialView: CGFloat = UIScreen.main.bounds.height
    
    var openDocumentVc: (() -> Void)?
    
    var heightLAbel : CGFloat!
    var window : UIWindow?
    var topPadding : CGFloat!
    var bottomPadding : CGFloat!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        window = UIApplication.shared.windows.first
        topPadding = window!.safeAreaInsets.top
        bottomPadding = window!.safeAreaInsets.bottom
        
       // self.tabBarController?.tabBar.isHidden = false
        //else if num.stringValue == "1" && dataResponce["docError"] as! String == "false" && dataResponce["docVerifyError"] as! String == "true"
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {

        btnDocUpload.layer.cornerRadius = 5.0
        self.view.roundCornersWithoutRect(corners: [.topLeft, .topRight], radius: 20.0)
        
        self.checkDoc()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let frame = self.view.frame
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
         
         //   self!.consMapViewBottom.constant = tblHeight!.height + 88
          //  let bottomSpace = (self?.tabBarController?.tabBar.frame.height)! + tblHeight!.height + 88
            
            // 400 - 363
          //  400 - 220 == 200
            //248 + label
            
          // DispatchQueue.main.async {
                
           // print(<#T##Any#>)
              //  let heightLAbel = self!.heightForView(text: self!.strDocText, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self!.view.frame.width - 40)
                
          //  print("HEIGHT VALUE",self!.heightLAbel!)
            
            print("DOC TEXT",self!.strDocText)
            //    self!.heightLAbel = self!.heightForView(text: self!.strDocText, font: UIFont(name: "Rubik Regular", size: 16.0)!, width: self!.view.frame.width - 40)
                
            
               // self!.partialView = self!.partialView - (260 + self!.heightLAbel)
                   
            //    }
              
            if  self!.topPadding >= 44
            {
                self!.partialView = self!.partialView - (self!.stackView.frame.origin.y + self!.stackView.frame.height + 50 + self!.bottomPadding)
            }
            else
            {
                self!.partialView = self!.partialView - (self!.stackView.frame.origin.y + self!.stackView.frame.height + 50)
            }
           
            print(self!.partialView)
            print(self!.stackView.frame.origin.y + self!.stackView.frame.height + 5)
            print(self!.partialView - (self!.stackView.frame.origin.y + self!.stackView.frame.height + 50))
            //- (self!.btnDocUpload.frame.origin.y + self!.btnDocUpload.frame.height + 5)
            
            let yComponent = self!.partialView
                self?.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height - 49)
    //}
          
        })
    }
    //MARK: - button action
    
    @IBAction func btnOkayClicked(_ sender: Any)
    {
      //  NotificationCenter.default.post(name: Notification.Name("RemoveDocFromHome"), object: nil)
        
        let selectBik = self.storyboard?.instantiateViewController(withIdentifier: "SelectBikeVC") as! SelectBikeVC
       // selectBik.delegate = self
        selectBik.strStationID = strStationID
        print(strStationID!)
        print(indexVal!)
        selectBik.index = indexVal
        //selectBik.delegate = self
        self.navigationController?.pushViewController(selectBik, animated: true)
    }
    
    @IBAction func btnUploadClicked(_ sender: Any)
    {
        self.openDocumentVc!()
//        let botomPopUploadDoc = self.storyboard?.instantiateViewController(withIdentifier: "HomeUploadDocumentVc") as! HomeUploadDocumentVc
//      //  botomPopUploadDoc.delegate = self
//        botomPopUploadDoc.strStationIDGet = strStationID
//        self.addChild(botomPopUploadDoc)
//        self.view.addSubview(botomPopUploadDoc.view)
//        botomPopUploadDoc.didMove(toParent: self)
//
//        let height = view.frame.height
//        let width  = view.frame.width
//        botomPopUploadDoc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
//
//        self.willMove(toParent: nil)
//        self.view.removeFromSuperview()
//        self.removeFromParent()
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
extension HomeDocVc
{
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        //DispatchQueue.main.async {
            
            
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            label.sizeToFit()

           
      //  }
        return label.frame.height
        //return 0.0
    }
    func checkDoc() -> Void
    {
        
        //        botomPopUploadDoc.strVal = "1"
        //        botomPopUploadDoc.strDocError = "true"
        //        botomPopUploadDoc.strDocVerify = ""
        lbDesc.text = strDocText
        if strVal == "1" && strDocError == "true" && strDocVerify == ""
        {
            btnDocUpload.isHidden = false
            btnOkay.isHidden = true
        }
        else if strVal == "1" && strDocError == "true" && strDocVerify == "false"
        {
            btnDocUpload.isHidden = false
            btnOkay.isHidden = true
        }
        else if strVal == "1" && strDocError == "false" && strDocVerify == "true"
        {
            btnDocUpload.isHidden = true
            btnOkay.isHidden = false
        }
        else if strVal == "1" && strDocError == "false" && strDocVerify == "false"
        {
         
            btnDocUpload.isHidden = true
            btnOkay.isHidden = false
        }
        else
        {
            
            btnDocUpload.isHidden = true
            btnOkay.isHidden = false
        }
                
    }
}
