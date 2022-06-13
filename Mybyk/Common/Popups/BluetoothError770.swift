//
//  BluetoothError770.swift
//  Mybyk
//
//  Created by Parth Kapadia on 02/05/22.
//

import UIKit
import Foundation

public typealias ActionTryAgain770 = () -> Void

class BluetoothError770: UIView
{
    @IBOutlet var viewPArent: UIView!
    
    @IBOutlet var btnTryAgain: UIButton!
    @IBOutlet var viewInner: UIView!
    
    static let instance = BluetoothError770()
    public var ActionTryAgain770: ActionTryAgain770?
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
        Bundle.main.loadNibNamed("BluetoothError770", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit()
    {
        viewInner.layer.cornerRadius = 10
        btnTryAgain.layer.cornerRadius = 6
        viewPArent.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        viewPArent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert()
    {
        UIApplication.shared.keyWindow?.addSubview(viewPArent)
    }
    func HidePopup()
    {
        viewPArent.removeFromSuperview()
    }
    @IBAction func btnTryAgainClicked(_ sender: Any)
    {
        viewPArent.removeFromSuperview()
        ActionTryAgain770?()
    }
    
}
