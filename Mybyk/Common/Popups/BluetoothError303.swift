//
//  BluetoothError303.swift
//  Mybyk
//
//  Created by Parth Kapadia on 02/05/22.
//

import UIKit
import Foundation

public typealias ActionTryAgain330 = () -> Void

class BluetoothError303: UIView {

    @IBOutlet var btnTryAgain: UIButton!
    @IBOutlet var parentView: UIView!
    @IBOutlet var viewInner: UIView!
    
    static let instance = BluetoothError303()
    public var ActionTryAgainPopup303: ActionTryAgain330?
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
        Bundle.main.loadNibNamed("BluetoothError303", owner: self, options: nil)
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
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert()
    {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    func HideAlert()
    {
        parentView.removeFromSuperview()
    }
    @IBAction func btnTryAgainClicked(_ sender: Any)
    {
        parentView.removeFromSuperview()
        ActionTryAgainPopup303?()
    }
    
}
