//
//  EndRideTryRequest.swift
//  Mybyk
//
//  Created by Gaurav Patel on 03/02/22.
//

import UIKit
import Foundation

public typealias TryEndingRideAgainClosure = () -> Void
public typealias SubmitVideoEndRideClosure = () -> Void

class EndRideTryRequest: UIView {
    
    static let instance = EndRideTryRequest()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var endRideTryView: UIView!
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var btnTryEndingRideAgain: UIButton!
    @IBOutlet weak var btnSubmitVideoEndRide: UIButton!
    
    public var ActionTryEndingRideAgain: TryEndingRideAgainClosure?
    public var ActionSubmitVideoEndRide: SubmitVideoEndRideClosure?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("EndRideTryRequest", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        imgViewIcon.layer.cornerRadius = imgViewIcon.frame.height / 2
        btnTryEndingRideAgain.layer.cornerRadius = 6
        btnSubmitVideoEndRide.layer.cornerRadius = 6
        
        endRideTryView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showEndRideTryRequest(title: String, message: String, iconName: String) {
        
        self.lblTitle.text = title
        self.messageLbl.text = message
        self.imgViewIcon.image = UIImage(named: iconName)
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func ActionTryEndingRideAgain(_ sender: UIButton) {
        parentView.removeFromSuperview()
        ActionTryEndingRideAgain?()
    }
    
    @IBAction func ActionSubmitVideoEndRide(_ sender: UIButton) {
        parentView.removeFromSuperview()
        ActionSubmitVideoEndRide?()
    }
    
    
}



