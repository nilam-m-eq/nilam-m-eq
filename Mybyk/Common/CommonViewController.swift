//
//  CommonViewController.swift
//  Mybyk
//
//  Created by Parth Kapadia on 22/06/21.
//

import UIKit

protocol SetindexForTopScrollTable
{
    func SetBackTableIndex(RowVal : Int)
}
class CommonViewController: UIViewController
{

  //  var delegate: CommonViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Internet check background
    func updateUserInterface()
    {
        switch Network.reachability.status
        {
        case .unreachable:
            
            viewInternetConnection.instance.showMsg(strmsg: "Check your internet connection...")
            
            viewInternetConnection.instance.ActionOkay =
            {
                OngoingRideCancelRequestAlert.instance.HidePopup()
            }
        case .wwan: break
          //  view.backgroundColor = .yellow
        case .wifi:
            OngoingRideCancelRequestAlert.instance.HidePopup()
            break
           // view.backgroundColor = .green
            
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    @objc func statusManager(_ notification: Notification)
    {
        updateUserInterface()
    }
    func getDynamicCycleName(strCycleType: String) -> String
    {
        print(strCycleType)
        
        let strConvert = String(strCycleType)
        print(strConvert)
        
        let trimmedString = strConvert.trimmingCharacters(in: .whitespaces)
        print(trimmedString)
        if trimmedString == "PRO"
        {
            return "IC_ProCycle"
        }
        else if trimmedString == "DUET"
        {
            return "IC_DuetCycle"
        }
        else if trimmedString == "ELECTRIC"
        {
            return "IC_ElectricCycle"
        }
        else if trimmedString == "GEARED"
        {
            return "IC_ProCycle"
        }
        else
        {
            return "IC_PlusCycle"
        }
       /* switch strCycleType
        {
        case "PRO":
            return "IC_ProCycle"
        case "DUET":
            return "IC_DuetCycle"
        case "ELECTRIC":
            return "IC_ElectricCycle"
        default:
            return "IC_PlusCycle"
        }*/
    }
    
    func getCurrentTimeStamp() -> String {
        let dat: Date = Date(timeIntervalSinceNow: 0)
        let a : TimeInterval = dat.timeIntervalSince1970
        let timeString: String = String(format: "%.f", a)
        return timeString
    }
    
    
    
}

extension UIButton {
    
    func shadowSecondaryBtn(frame: CGRect) {
        
        let shadowSize: CGFloat = 5.0
        
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2, y: -shadowSize / 2, width: frame.size.width + shadowSize, height: frame.size.height + shadowSize))
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10.0
        layer.shadowPath = shadowPath.cgPath
        
    }
    
}

extension UIView {
    
    func shadowRoundView(frame: CGRect) {
        
        let shadowSize: CGFloat = 1.0
        
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2, y: -shadowSize / 2, width: frame.size.width + shadowSize, height: frame.size.height + shadowSize))
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = frame.size.height / 2
        layer.shadowPath = shadowPath.cgPath
        
    }
    
    func shadowSecondaryView(frame: CGRect) {
        
        let shadowSize: CGFloat = 5.0
        
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2, y: -shadowSize / 2, width: frame.size.width + shadowSize, height: frame.size.height + shadowSize))
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10.0
        layer.shadowPath = shadowPath.cgPath
        
    }
    
    func shadowZ100(frame: CGRect) {
        
//        layer.shadowColor = UIColor.lightGray.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 3)
//        layer.shadowRadius = 1
//
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
        
       // layer.masksToBounds = false
        
       
        /*layer.shadowColor = UIColor(red:223.0/255.0 , green: 225.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
        //UIColor.lightGray.cgColor
        layer.cornerRadius = 8.0

        layer.shadowOffset = .zero
        layer.shadowRadius = 0.5
        layer.shadowOpacity = 1.0*/
        
        layer.shadowColor = UIColor(red:223.0/255.0 , green: 225.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
      //  layer.cornerRadius = 8.0
        
    }
    func shadowZ(frame: CGRect) {
        
//        layer.shadowColor = UIColor.lightGray.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 3)
//        layer.shadowRadius = 1
//
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
        
       // layer.masksToBounds = false
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 4.0


        layer.shadowOffset = .zero
        layer.shadowRadius = 0.5

        layer.shadowOpacity = 1.0
        
    }
    func shadowZ100WithShadowRadius(frame: CGRect, radius: CGFloat)
    {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 3)
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
    func shadowZ100WithShadowRadiusWhatsAppMsg(frame: CGRect, radius: CGFloat)
    {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8.0


        layer.shadowOffset = .zero
        layer.shadowRadius = 1.0

        layer.shadowOpacity = 1.0
       
        
    }
    func viewBorderWithCornerRadius()
    {
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1).cgColor
       
    }
    func viewBorderWithCornerRadiusNoti()
    {
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1).cgColor
       
    }
    func viewBorderWithCornerRadi()
    {
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.875, green: 0.882, blue: 0.902, alpha: 1).cgColor
       
    }
    func viewTextFieldActiveBorder() {
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Active)?.cgColor
    }
    
    func viewTextFieldPrimaryBorder() {
        
        
       /* layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor*/
        
        /*
         viewMainBack.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         viewMainBack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         viewMainBack.layer.shadowOpacity = 1.0
         viewMainBack.layer.shadowRadius = 0.0
         viewMainBack.layer.masksToBounds = false
         viewMainBack.layer.cornerRadius = 4.0
         */
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        
    }
    func viewTextFieldPrimaryBorderForSelect()
    {
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor
        
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
      /*  layer.shadowColor = UIColor(named: Color_Primary)?.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        layer.cornerRadius = 4.0*/
    }
    func viewTextFieldShadowBorderViewNone()
    {
      //  layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 0
        layer.borderWidth = 0
        //layer.borderColor = UIColor(named: Color_N_Light500)?.cgColor
        
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    func viewTextFieldShadowBorderViewForOngoing() {
        
        
       /* layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor*/
        
        /*
         viewMainBack.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         viewMainBack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         viewMainBack.layer.shadowOpacity = 1.0
         viewMainBack.layer.shadowRadius = 0.0
         viewMainBack.layer.masksToBounds = false
         viewMainBack.layer.cornerRadius = 4.0
         */
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_N_Light500)?.cgColor
        
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
         
    }
    func viewTextFieldShadowBorderViewForSummary() {
        
        
       /* layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor*/
        
        /*
         viewMainBack.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         viewMainBack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         viewMainBack.layer.shadowOpacity = 1.0
         viewMainBack.layer.shadowRadius = 0.0
         viewMainBack.layer.masksToBounds = false
         viewMainBack.layer.cornerRadius = 4.0
         */
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_N_Light500)?.cgColor
        
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
         
    }
    func viewTextFieldShadowBorderView() {
        
        
       /* layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor*/
        
        /*
         viewMainBack.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         viewMainBack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         viewMainBack.layer.shadowOpacity = 1.0
         viewMainBack.layer.shadowRadius = 0.0
         viewMainBack.layer.masksToBounds = false
         viewMainBack.layer.cornerRadius = 4.0
         */
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_N_Light500)?.cgColor
        
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 1)
         
    }
    func viewTextFieldShadowBorder() {
        
        
       /* layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Primary)?.cgColor*/
        
        /*
         viewMainBack.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
         viewMainBack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         viewMainBack.layer.shadowOpacity = 1.0
         viewMainBack.layer.shadowRadius = 0.0
         viewMainBack.layer.masksToBounds = false
         viewMainBack.layer.cornerRadius = 4.0
         */
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Active)?.cgColor
        
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 1)
         
    }
    
    func viewTextFieldErrorBorder() {
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Error)?.cgColor
    }
    
    func viewTextFieldWarningBorder() {
        
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 3
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Color_Warning)?.cgColor
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCornersWithoutRect(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    
    
}


extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
   var isValidPhone: Bool {
      let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
      return testPhone.evaluate(with: self)
   }
}


