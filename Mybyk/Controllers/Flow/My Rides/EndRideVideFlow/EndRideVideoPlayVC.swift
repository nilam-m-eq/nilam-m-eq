//
//  EndRideVideoPlayVC.swift
//  Mybyk
//
//  Created by Gaurav Patel on 04/02/22.
//

import UIKit
import AVFoundation
import AVKit
import CoreLocation
import Toaster

class EndRideVideoPlayVC: CommonViewController {
    @IBOutlet weak var viewNavi: UIView!
    @IBOutlet weak var viewBackInstruction: UIView!
    @IBOutlet weak var btnRecordAgain: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var videoView: UIView!
    
    var videoURL = String()
    var strRequestID = String()
    
    var player = AVPlayer()
    var avpController = AVPlayerViewController()
    
    var locationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.tabBarController?.tabBar.isHidden = true
        self.setUIOnScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.viewNavi.shadowZ100(frame: viewNavi.frame)
        self.btnRecordAgain.layer.cornerRadius = 8.0
        self.btnSubmit.layer.cornerRadius = 8.0
        
        viewBackInstruction.roundCorners(corners: [.topLeft, .topRight], radius: 12.0, rect: self.view.frame)
        
        let url = URL(string: videoURL)
        player = AVPlayer(url: url!)
        avpController.player = player
        avpController.view.frame.size.height = videoView.frame.size.height - 20
        avpController.view.frame.size.width = videoView.frame.size.width
        self.videoView.addSubview(avpController.view)
    }
    
    // ********** All Button Actions ********** //
    @IBAction func ActionBack(_ sender: UIButton) {
        
        for aViewController in self.navigationController!.viewControllers {
            if aViewController is EndRideInstructionVC {
                self.navigationController?.popToViewController(aViewController, animated: true)
            }
        }
        
    }
    
    @IBAction func ActionRecordAgain(_ sender: UIButton) {
        
        for aViewController in self.navigationController!.viewControllers {
            if aViewController is EndRideInstructionVC {
                self.navigationController?.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    @IBAction func ActionSubmit(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways {
                
                print("Access")
                var currentLocation = CLLocation()
                currentLocation = locationManager.location!
                print(currentLocation.coordinate.latitude)
                print(currentLocation.coordinate.longitude)
                
                
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let fileUrl = paths[0].appendingPathComponent("output.mp4")
                if let videoData = NSData(contentsOf: fileUrl) {
                    
                    self.uploadIssueVideoAPIWebServiceCall(lat: "\(currentLocation.coordinate.latitude)", long: "\(currentLocation.coordinate.longitude)", videoData: videoData)
                }
                
            }
            else {
                print("No Access")
                AlertView.instance.showAlert(message: strLocationPrivacy, image: "IC_ErrorIcon", alertType: .success)
            }
            
        }
        else {
            
            print("Location services are not enabled")
            AlertView.instance.showAlert(message: strLocationEnable, image: "IC_ErrorIcon", alertType: .success)
        }
        
        
    }
    
    
}

// ************************************ //
// MARK:- All Custom Functions
// ************************************ //
extension EndRideVideoPlayVC {
    
    func setUIOnScreen() {
        
        
    }
    
}

// ************************************ //
// MARK:- All API Functions
// ************************************ //
extension EndRideVideoPlayVC {
    
    func uploadIssueVideoAPIWebServiceCall(lat: String, long: String, videoData: NSData) {
        
        CommonClass.loadProgressHudCycling(viewController: self)
        APIService.sharedInstance.uploadEndRideIssueVideo(video: videoData, dictionary: ["endridereqid":"\(self.strRequestID)", "lat":lat, "long":long]) { response in
            CommonClass.removeProgressHudCycling(viewController: self)
            
            print(response)
            
            if response["is_error"] as! String == "false" {
                
                let toast = Toast(text: "\(response["message"] as! String)", delay: 0.0, duration: Delay.long)
                toast.show()
                
                for aViewController in self.navigationController!.viewControllers {
                    if aViewController is OngoingRideDetails {
                        self.navigationController?.popToViewController(aViewController, animated: true)
                    }
                }
                
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







