//
//  NotificationDetailVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/06/21.
//

import UIKit

class NotificationDetailVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!

    @IBOutlet weak var consViewBackDetailWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.tabBarController?.tabBar.isHidden = true
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
extension NotificationDetailVC {
    
    func setUIOnScreen() {
        
        viewNavi.shadowZ100(frame: viewNavi.frame)
        self.consViewBackDetailWidth.constant = self.view.frame.width
        
    }
    
    
}
