//
//  EndRideCountDownTimerVC.swift
//  Mybyk
//
//  Created by Parth Kapadia on 28/06/21.
//

import UIKit

class EndRideCountDownTimerVC: CommonViewController {
    @IBOutlet weak var viewBackSeconds: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let yComponent = UIScreen.main.bounds.height - UIScreen.main.bounds.height
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        } completion: { status in
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut) {
                self.view.backgroundColor = UIColor(named: Color_N_Dark900)?.withAlphaComponent(0.8)
            } completion: { stat in
                
            }
        }
        
    }
    
    // ********** All Button Actions ********** //
    
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EndRideCountDownTimerVC {
    
    func setUIOnScreen() {
        
        self.viewBackSeconds.layer.cornerRadius = self.viewBackSeconds.frame.size.height / 2
        self.viewBackSeconds.layer.borderColor = UIColor(named: Color_N_Light00)?.cgColor
        self.viewBackSeconds.layer.borderWidth = 5.0
        
    }
    
}




