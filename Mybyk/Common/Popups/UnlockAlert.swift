//
//  UnlockAlert.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/04/22.
//

import UIKit
import Foundation

public typealias UnlockClosure = () -> Void

class UnlockAlert: UIView
{
    @IBOutlet var imgError: UIImageView!
    static let instance = UnlockAlert()
    
    @IBOutlet var parentView: UIView!
    
    @IBOutlet var viewError: UIView!
    @IBOutlet var viewInner: UIView!
    @IBOutlet var lbMsg: UILabel!
    
    @IBOutlet var btnOk: UIButton!
    public var ActionOk: UnlockClosure?
    /*
     @IBOutlet var btnOk: UIButton!
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("UnlockAlert", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnOkClicked(_ sender: Any)
    {
        parentView.removeFromSuperview()
        ActionOk?()
    }
    private func commonInit()
    {
        viewError.layer.cornerRadius = 30
        imgError.image = imgError.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imgError.tintColor = UIColor.white
//        img.layer.borderColor = UIColor.white.cgColor
//        img.layer.borderWidth = 2
        btnOk.layer.cornerRadius = 6
//
        viewInner.layer.cornerRadius = 10

        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    enum AlertType {
        case success
        case failure
    }
    
    func showAlert(message: String, image: String, alertType: AlertType)
    {
        self.lbMsg.text = message
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    func hide() -> Void
    {
        parentView.removeFromSuperview()
    }
}
