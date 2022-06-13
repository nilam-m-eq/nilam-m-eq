//
//  Blutooth660Error.swift
//  Mybyk
//
//  Created by Parth Kapadia on 02/05/22.
//

import UIKit
import Foundation

public typealias TryAgain660 = () -> Void
public typealias SubmitVideo660 = () -> Void

class Blutooth660Error: UIView
{
    @IBOutlet var viewParent: UIView!
    @IBOutlet var viewInner: UIView!
    @IBOutlet var btnEndrideAgain: UIButton!
    @IBOutlet var btnSubmitVideo: UIButton!
    
    static let instance = Blutooth660Error()
    public var ActionTryAgain660: TryAgain660?
    public var ActionSubmitVideo: SubmitVideo660?
    
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
        Bundle.main.loadNibNamed("Blutooth660Error", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit()
    {
        viewInner.layer.cornerRadius = 10
        btnSubmitVideo.layer.cornerRadius = 6
        viewParent.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        viewParent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert()
    {
        UIApplication.shared.keyWindow?.addSubview(viewParent)
    }
    func HideAlert()
    {
        viewParent.removeFromSuperview()
    }
    @IBAction func btnEndrideEgain(_ sender: Any)
    {
        viewParent.removeFromSuperview()
        ActionTryAgain660?()
    }
    @IBAction func btnEndrideSubmitVideo(_ sender: Any)
    {
        viewParent.removeFromSuperview()
        ActionSubmitVideo?()
    }
    
}
