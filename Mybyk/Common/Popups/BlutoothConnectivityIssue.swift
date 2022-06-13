//
//  BlutoothConnectivityIssue.swift
//  Mybyk
//
//  Created by Parth Kapadia on 29/04/22.
//

import UIKit
import Foundation

public typealias TryAgainClosure = () -> Void

class BlutoothConnectivityIssue: UIView
{
    static let instance = BlutoothConnectivityIssue()
    @IBOutlet var btnTryAgain: UIButton!
    @IBOutlet var viewBlutoothMain: UIView!
    @IBOutlet var viewBlutoothConnectionInnerView: UIView!
    public var ActionTryAgain: TryAgainClosure?
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
        Bundle.main.loadNibNamed("BlutoothConnectivityIssue", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit()
    {
        viewBlutoothConnectionInnerView.layer.cornerRadius = 10
        btnTryAgain.layer.cornerRadius = 6
        viewBlutoothMain.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        viewBlutoothMain.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert(alertType: AlertTryAgain)
    {
        UIApplication.shared.keyWindow?.addSubview(viewBlutoothMain)
    }
   
    enum AlertTryAgain {
        case success
    }
    @IBAction func btnTryAgain(_ sender: Any)
    {
        viewBlutoothMain.removeFromSuperview()
        ActionTryAgain?()
    }
    func hidePopup()
    {
        viewBlutoothMain.removeFromSuperview()
    }
}
