//
//  RecordEndRideVideoVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 03/02/22.
//

import UIKit
import Photos

class RecordEndRideVideoVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackInstruction: UIView!
    @IBOutlet weak var btnNextFirst: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var btnStopRecording: UIButton!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var stackViewBothBtn: UIStackView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnPreviousFirst: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var imgViewTimerIC: UIImageView!
    
    
    var strRequestID = String()
    
    
    
    var cameraConfig: CameraConfiguration!
    
    var timer : Timer?
    var maxTime: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
        self.setUIOnScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnNextFirst.layer.cornerRadius = 8.0
        self.btnNext.layer.cornerRadius = 8.0
        self.btnPrevious.layer.cornerRadius = 8.0
        self.btnPreviousFirst.layer.cornerRadius = 8.0
        
        viewBackInstruction.roundCorners(corners: [.topLeft, .topRight], radius: 12.0, rect: self.view.frame)
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ActionNextFirst(_ sender: UIButton) {
        
        self.btnNextFirst.isHidden = true
        self.stackViewBothBtn.isHidden = false
        self.btnPreviousFirst.isHidden = true
        
        self.lblInstruction.text = "Please show that the bike is locked properly"
        
    }
    
    @IBAction func ActionNext(_ sender: UIButton) {
        
        self.btnNextFirst.isHidden = true
        self.stackViewBothBtn.isHidden = true
        self.btnPreviousFirst.isHidden = false
        
        self.lblInstruction.text = "Please show the MYBYK hub where your bike is parked"
    }
    
    @IBAction func ActionPrevious(_ sender: UIButton) {
        
        self.btnNextFirst.isHidden = false
        self.stackViewBothBtn.isHidden = true
        self.btnPreviousFirst.isHidden = true
        
        self.lblInstruction.text = "Please capture the bike lock number"
    }
    
    @IBAction func ActionPreviousFirst(_ sender: UIButton) {
        
        self.btnNextFirst.isHidden = true
        self.stackViewBothBtn.isHidden = false
        self.btnPreviousFirst.isHidden = true
        
        self.lblInstruction.text = "Please show that the bike is locked properly"
    }
    
    @IBAction func ActionStopRecording(_ sender: UIButton) {
        
        self.cameraConfig.stopRecording { (error) in
            print(error ?? "Video recording error")
        }
        
        self.timer?.invalidate()
        
        if let device = AVCaptureDevice.default(for: .video) , device.hasTorch {
            
            do {
                try device.lockForConfiguration()
                device.torchMode = .off
                device.unlockForConfiguration()
            } catch {
                
            }
        }
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension RecordEndRideVideoVC {
    
    func setUIOnScreen() {
        
        self.btnNextFirst.isHidden = false
        self.stackViewBothBtn.isHidden = true
        self.btnPreviousFirst.isHidden = true
        self.lblInstruction.text = "Please capture the bike lock number"
        
        self.cameraConfig = CameraConfiguration()
        cameraConfig.setup { (error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            try? self.cameraConfig.displayPreview(self.previewImageView)
            print("Play")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print("Nowwwwwwww")
                self.cameraConfig.outputType = .video
                
                self.cameraConfig.recordVideo { (url, error) in
                    guard let url = url else {
                        print(error ?? "Video recording error")
                        return
                    }
                    print("\(url)")
                    
                    let playVC = self.storyboard?.instantiateViewController(withIdentifier: "EndRideVideoPlayVC") as! EndRideVideoPlayVC
                    playVC.videoURL = "\(url)"
                    playVC.strRequestID = self.strRequestID
                    self.navigationController?.pushViewController(playVC, animated: true)
                }
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountDown), userInfo: nil, repeats: true)
                
                if let device = AVCaptureDevice.default(for: .video) , device.hasTorch {
                    
                    do {
                        try device.lockForConfiguration()
                        try device.setTorchModeOn(level: 1.0)
                        device.torchMode = .on
                        device.unlockForConfiguration()
                    } catch {
                        
                    }
                }
            }
            
        }
        
    }
    
    @objc func timerCountDown() {
        
        if self.maxTime == 0 {
            
            self.cameraConfig.stopRecording { (error) in
                print(error ?? "Video recording error")
            }
            
            self.timer?.invalidate()
            
            if let device = AVCaptureDevice.default(for: .video) , device.hasTorch {
                
                do {
                    try device.lockForConfiguration()
                    device.torchMode = .off
                    device.unlockForConfiguration()
                } catch {
                    
                }
            }
            
        }
        else {
            
            self.maxTime = self.maxTime - 1
        }
        
        let (m, s) = self.secondsToHoursMinutesSeconds(seconds: self.maxTime)
        self.lblTimer.text = String(format: "%02d:%02d", m, s)
    }
    
    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int) {
        return((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
}







