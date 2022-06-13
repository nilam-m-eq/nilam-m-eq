//
//  OngoingRideCancelRequestAlert.swift
//  Mybyk
//
//  Created by Parth Kapadia on 24/03/22.
//

import UIKit
import Foundation

public typealias YesClosure = () -> Void
public typealias NoClosure = () -> Void

class OngoingRideCancelRequestAlert: UIView
{
    @IBOutlet weak var lbMSg: UILabel!
    @IBOutlet var btnNo: UIButton!
    @IBOutlet var viewMain: UIView!
    @IBOutlet var imgWarning: UIImageView!
    @IBOutlet var btnYes: UIButton!
    
    public typealias YesClosure = () -> Void
    public typealias NoClosure = () -> Void
    
    @IBOutlet var parentView: UIView!
    public var ActionYes: YesClosure?
    public var ActionNo: NoClosure?
    
    static let instance = OngoingRideCancelRequestAlert()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("OngoingRideCancelRequestAlert", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit()
    {
        viewMain.layer.cornerRadius = 10
        imgWarning.image = imgWarning.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imgWarning.tintColor = UIColor(red: 65.0/255.0, green: 205.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        
        btnYes.layer.cornerRadius = 10.0
        btnNo.layer.cornerRadius = 10.0
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func btnYesClicked(_ sender: Any)
    {
        parentView.removeFromSuperview()
        ActionYes?()
    }
    @IBAction func btnNoClicked(_ sender: Any)
    {
        parentView.removeFromSuperview()
        ActionNo?()
    }
    func HidePopup()
    {
        parentView.removeFromSuperview()
    }
    func showMsg(txtmsg : String)
    {
        lbMSg.text = txtmsg
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
}
