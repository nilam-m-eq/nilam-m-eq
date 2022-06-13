//
//  AlertView.swift
//  CustomAlert
//
//  Created by SHUBHAM AGARWAL on 31/12/18.
//  Copyright © 2018 SHUBHAM AGARWAL. All rights reserved.
//

import Foundation
import UIKit

public typealias OkClosure = () -> Void

class AlertView: UIView
{
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet var viewError: UIView!
    public var ActionOk: OkClosure?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit()
    {
        viewError.layer.cornerRadius = 30
        viewError.clipsToBounds = true
        
//        img.layer.cornerRadius = 30
//        img.layer.borderColor = UIColor.white.cgColor
//        img.layer.borderWidth = 2
        
        doneBtn.layer.cornerRadius = 6
        
        alertView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    enum AlertType {
        case success
        case failure
    }
    
    func showAlert(message: String, image: String, alertType: AlertType)
    {
        self.messageLbl.text = message
        //img.image = UIImage(named: "IC_ErrorIcon")
        img.image = img.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        img.tintColor = UIColor.white
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func onClickDone(_ sender: Any)
    {
        parentView.removeFromSuperview()
        ActionOk?()
    }
    
}
