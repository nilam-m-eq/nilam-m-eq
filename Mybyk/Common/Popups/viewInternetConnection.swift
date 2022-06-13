//
//  viewInternetConnection.swift
//  Mybyk
//
//  Created by Parth Kapadia on 25/03/22.
//

import UIKit
import Foundation

public typealias OkayClosure = () -> Void

class viewInternetConnection: UIView {
    @IBOutlet var viewParent: UIView!
    @IBOutlet var viewInner: UIView!
    @IBOutlet var viewImageRound: UIView!
    @IBOutlet var imgWarnigInternet: UIImageView!
    @IBOutlet var btnOaky: UIButton!
    
    public typealias OkayClosure = () -> Void
    
    @IBOutlet var lbInternetSlot: UILabel!
    public var ActionOkay: OkayClosure?
    
    static let instance = viewInternetConnection()
    /*
    
     */
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
        Bundle.main.loadNibNamed("viewInternetConnection", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit()
    {
        viewInner.layer.cornerRadius = 8.0
        btnOaky.layer.cornerRadius = 8.0
        viewImageRound.layer.cornerRadius = 30.0
        imgWarnigInternet.image = imgWarnigInternet.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imgWarnigInternet.tintColor = UIColor.white
        
        viewParent.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    @IBAction func btnOkayClicked(_ sender: Any)
    {
        viewParent.removeFromSuperview()
        ActionOkay?()
    }
    func HidePopup()
    {
        viewParent.removeFromSuperview()
    }
    func showMsg(strmsg : String)
    {
        
        lbInternetSlot.text = strmsg
        UIApplication.shared.keyWindow?.addSubview(viewParent)
    }
}
