//
//  EndRideInstructionVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 03/02/22.
//

import UIKit

class EndRideInstructionVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackInstruction: UIView!
    @IBOutlet weak var btnStartRecording: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    
    
    var strRequestID = String()
    
    
    var cameraConfig: CameraConfiguration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUIOnScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnStartRecording.layer.cornerRadius = 8.0
        
        viewBackInstruction.roundCorners(corners: [.topLeft, .topRight], radius: 12.0, rect: self.view.frame)
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func ActionStartRecording(_ sender: UIButton) {
        
        let record = self.storyboard?.instantiateViewController(withIdentifier: "RecordEndRideVideoVC") as! RecordEndRideVideoVC
        record.strRequestID = strRequestID
        self.navigationController?.pushViewController(record, animated: true)
        
    }
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EndRideInstructionVC {
    
    func setUIOnScreen() {
        
        self.cameraConfig = CameraConfiguration()
        cameraConfig.setup { (error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            try? self.cameraConfig.displayPreview(self.previewImageView)
        }
    }
    
    
}





