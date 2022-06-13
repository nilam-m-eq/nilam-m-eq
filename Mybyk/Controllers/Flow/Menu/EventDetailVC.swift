//
//  EventDetailVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit
import Toaster
import SDWebImage
import Foundation

class EventDetailVC: UIViewController
{
    @IBOutlet weak var viewNavi: UIView!

    var strEventID : String!
    
    @IBOutlet var lbLink: UILabel!
    var strLinkofUrl : String!
    var strDetail : String!
    var strFilter : String!
    
    @IBOutlet var lbVenue: UILabel!
    @IBOutlet var lbDate: UILabel!
    @IBOutlet var txtDetail: UITextView!
    @IBOutlet var txtHeightConstant: NSLayoutConstraint!
    @IBOutlet var lbDesc: UILabel!
    @IBOutlet var imgBanner: UIImageView!
    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.tabBarController?.tabBar.isHidden = true
//        txtDetail.delegate = self
//        txtDetail.isUserInteractionEnabled = true
//        txtDetail.isEditable = false
//        txtDetail.isSelectable = true
       /* txtDetail.translatesAutoresizingMaskIntoConstraints = true
        txtDetail.isScrollEnabled = false
        txtDetail.sizeToFit()*/
        
//        var frame = self.txtDetail.frame
//        frame.size.height = self.txtDetail.contentSize.height
//        self.txtDetail.frame = frame
        
//        self.lbDesc.isUserInteractionEnabled = true
//        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnLabel(_ :)))
//        tapgesture.numberOfTapsRequired = 1
//        self.lbDesc.addGestureRecognizer(tapgesture)
        
        print(strEventID!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EventDetailVC {
    
    func setUIOnScreen() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLink))
        lbLink.isUserInteractionEnabled = true
        lbLink.addGestureRecognizer(tap)
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
      //  self.consViewBackDetailWidth.constant = self.view.frame.width
        self.getEventDetails()
        
    }
    
}
extension String
{
    func htmlToAttributedStringConvert(string : String) -> NSAttributedString{
           var attribStr = NSMutableAttributedString()
           
           do {//, allowLossyConversion: true
               attribStr = try NSMutableAttributedString(data: string.data(using: String.Encoding.utf8)!, options: [ .documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
               
               let textRangeForFont : NSRange = NSMakeRange(0, attribStr.length)
               attribStr.addAttributes([NSAttributedString.Key.font : UIFont(name: "Rubik Regular", size:15)!], range: textRangeForFont)
               
           } catch {
               print(error)
           }
           
           return attribStr
       }
}
extension EventDetailVC : UITextViewDelegate
{
    //MARK:- tappedOnLabel
    func textView(_ textView: UITextView,
                      shouldInteractWith URL: URL,
                      in characterRange: NSRange,
                      interaction: UITextItemInteraction) -> Bool {

            UIApplication.shared.open(URL, options: [:])
            return false
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
    @objc func openLink(_ gestureRecognizer: UITapGestureRecognizer)
    {
        print("tap working")
        // handle gestureRecognizer.url in gestureRecognizer.range (UTF-16)
        let URL = NSURL(string: lbLink.text!)
        UIApplication.shared.open(URL! as URL, options: [:])
    }
    func getEventDetails()
    {
        /*
         WsEventInfo.php
         eventID

         */
        
        CommonClass.loadProgressHudCycling(viewController: self)
        //318
        APIService.sharedInstance.getEventDetail(dictionary: ["eventID": strEventID!]) { [self] response in
          //  APIService.sharedInstance.getEventDetail(dictionary: ["eventID": "318"]) { [self] response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            let getData = response["data"] as! [String : Any]
            let EventDetail = getData["event"] as! [String : Any]
            
            if response["is_error"] as! String == "false"
            {
                imgBanner.sd_setImage(with: URL(string: "\(EventDetail["eventBanner"] as! String)"), placeholderImage: UIImage(named: ""))

                
               /* let text = EventDetail["event_description"] as! String
                
                let convertToAttr = text.htmlToAttributedString
               
                let input = convertToAttr?.string
                let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matches = detector.matches(in: input!, options: [], range: NSRange(location: 0, length: input!.utf16.count))

                for match in matches {
                    guard let range = Range(match.range, in: input!) else { continue }
                    let url = input![range]
                    print(url)
                }*/
                
                /*
                 let normalText = "Available credits: "
                 let boldText  = "\(dicCurrentData["credit"] as? String ?? "")"
             
                // let attributedString = NSMutableAttributedString(string:normalText)

                 let attrs = [NSAttributedString.Key.font : UIFont(name: "Rubik Bold", size: 16.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_Primary") ]
                 
                 let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Rubik Regular", size: 16.0),NSAttributedString.Key.foregroundColor : UIColor(named: "Color_N_Dark900") ]
                 
                 let boldString = NSMutableAttributedString(string: boldText, attributes:attrs as [NSAttributedString.Key : Any])
                 
                 let normalStr = NSMutableAttributedString(string: normalText, attributes:attrs1 as [NSAttributedString.Key : Any])
                 
                 normalStr.append(boldString)
                 lbAvailableCredit.attributedText = normalStr
                 */
              //  DispatchQueue.main.async {
                let strContent = "\(EventDetail["event_description"] as! String)".htmlToAttributedString
                let strConvert = strContent?.string
                let attributedString = NSMutableAttributedString(string:strConvert!)
                
                print(attributedString)
                let strLink  = "\n\n\(EventDetail["event_link"] as! String)"
                let str = "\nRegister"
                
                lbDate.text = "\(EventDetail["event_end_date"] as! String)"
                lbVenue.text = "\(EventDetail["event_venue"] as! String)"
                
                lbLink.text = "\(EventDetail["event_link"] as! String)"
                
                /*
                 self.addAttribute(NSLinkAttributeName, value: linkURL, range: foundRange)
                           return true
                 */
                let strLinkData = "\(EventDetail["event_link"] as! String)"
                let attributedStringGene = NSMutableAttributedString(string:strLinkData)
                attributedStringGene.addAttributes([NSAttributedString.Key.link
                                                    : lbLink.text!], range: NSRange(location: 0, length: lbLink.text!.count))
                lbLink.attributedText = attributedStringGene
                
               
            
                DispatchQueue.global(qos: .background).async {
                    
                    // do things which can run in background
                    // calculations-delay-waiting for a response etc.
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [self] in
                        self.strLinkofUrl = "\(EventDetail["event_link"] as! String)"
                        let attributedString1 = NSMutableAttributedString(string:str)
                        let attributedString2 = NSMutableAttributedString(string:strLink)
                    //    attributedString2.addAttribute(.link, value: strLink, range: NSRange(location: 0, length: strLink.count))
                        attributedString.append(attributedString1)
                        attributedString.append(attributedString2)
                        
                        print(self.txtHeightConstant.constant)
                       print(self.txtDetail.contentSize.height)
                        
                        
                        // NSAttributedString(string: "labelText", attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: UIFont(name: "system", size: 12)])

                        let attributedStringContent = NSAttributedString(string: strConvert!, attributes: [NSAttributedString.Key.font: UIFont(name: "Rubik Regular", size: 15.0)!])
                        
                      //  self.txtDetail.attributedText = attributedStringContent
                        
                      //  self.txtDetail.attributedText = strContent
                        
                        self.txtDetail.attributedText = "\(EventDetail["event_description"] as! String)".htmlToAttributedStringConvert(string: EventDetail["event_description"] as! String)
                        //Rubik Regular 15.0
                        
                        let strVal = "\(EventDetail["event_description"] as! String)".htmlToAttributedStringConvert(string: EventDetail["event_description"] as! String)
                        
                      //  let height = self.heightForView(text:strContent!.string, font: UIFont(name: "Rubik Regular", size:15.0)!, width: self.view.frame.width - 60)
                        
                        let height = self.heightForView(text:strVal.string, font: UIFont(name: "Rubik Regular", size:15.0)!, width: self.view.frame.width - 60)
                        
                        print(height)//Output : 41.0
                     //   self.txtHeightConstant.constant = height + 200
                        
                        let contentSize = self.txtDetail.sizeThatFits(self.txtDetail.bounds.size)
                           let higntcons = contentSize.height
                        txtHeightConstant.constant = higntcons
                        
                        //self.txtDetail.contentSize.height
                        
                    })
                }
                                                  
                                                  
              /*  DispatchQueue.global(qos: .background).async {

                  // do things which can run in background
                  // calculations-delay-waiting for a response etc.

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {

                      let attributedString1 = NSMutableAttributedString(string:str)
                      /*
                       attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))

                              textView.attributedText = attributedString
                       */
                      let attributedString2 = NSMutableAttributedString(string:strLink)
                      attributedString2.addAttributes([NSAttributedString.Key.link :strLink], range: NSRange(location: 0, length: strLink.count))
                      attributedString.append(attributedString1)
                      attributedString.append(attributedString2)
                      
                      print(attributedString1)
                        
                       // var strDetail : String!
                     //   var strFilter : String!
                        strDetail = attributedString.string
                      self.lbDesc.attributedText = attributedString
                        
                       
                     //   self.lbDesc.addGestureRecognizer(tapgesture)
                    // implement UI related part which has to run in main thread.

                  })
                }*/
                
                    
                    
                 
               // }
              
                //"\(EventDetail["event_description"] as! String)".htmlToAttributedString
                
            
              //  lbAvailableCredit.text = "\(dicCurrentData["credit"] as? String ?? "")"
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
}
