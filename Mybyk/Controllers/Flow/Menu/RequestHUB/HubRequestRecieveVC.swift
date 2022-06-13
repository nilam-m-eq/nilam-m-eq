//
//  HubRequestRecieveVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 25/01/22.
//

import UIKit
import Lottie

class HubRequestRecieveVC: CommonViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    
    @IBOutlet var LottieView: AnimationView!

    var dicSubmitRequestData = [String: Any]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    //    self.tabBarController?.tabBar.isHidden = true
        
        self.LottieView!.contentMode = .scaleAspectFit
        self.LottieView!.loopMode = .playOnce
        self.LottieView!.animationSpeed = 0.5
        self.LottieView.play()
        
        self.setUIOnScreen()
        
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionOk(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}


// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension HubRequestRecieveVC {
    
    func setUIOnScreen() {
        
        btnOk.layer.cornerRadius = 10.0
        let dicSubmitRequest = dicSubmitRequestData["data"] as! [String: Any]
        
        lblTitle.text = "\(dicSubmitRequestData["message"] as! String)"
        lblMessage.text = "\(dicSubmitRequest["team_message"] as! String)"
    }
    
}




