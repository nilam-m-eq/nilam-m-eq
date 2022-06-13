//
//  MalFunction.swift
//  Mybyk
//
//  Created by Parth Kapadia on 15/11/21.
//

import UIKit
import Foundation

public typealias ProceedClosure = () -> Void
public typealias HelpClosure = () -> Void

class MalFunction: UIView
{
    
    static let instance = MalFunction()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var malFunctionView: UIView!
    @IBOutlet var img: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var messageLbl: UILabel!
    @IBOutlet var btnProceed: UIButton!
    @IBOutlet var lbIssue: UILabel!
    @IBOutlet var btnSelectAnother: UIButton!
    
    public var ActionProceed: ProceedClosure?
    public var ActionHelp: HelpClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("MalFunction", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        btnProceed.layer.cornerRadius = 6
        btnSelectAnother.layer.cornerRadius = 6
        btnProceed.shadowSecondaryBtn(frame: btnProceed.frame)
        
        malFunctionView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showMalFunction(title: String, message: String, imgName: String, strFirstBtn: String, strSecondBtn:String,strIssueName : String) {
        self.lblTitle.text = title
        self.messageLbl.text = message
        self.img.image = UIImage(named: imgName)
        self.btnProceed.setTitle(strFirstBtn, for: .normal)
        self.btnSelectAnother.setTitle(strSecondBtn, for: .normal)
        self.lbIssue.text = strIssueName
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func ActionProceedAnyway(_ sender: UIButton) {
        parentView.removeFromSuperview()
        ActionProceed?()
    }
    
    @IBAction func ActionSelectAnother(_ sender: UIButton) {
        
        parentView.removeFromSuperview()
        ActionHelp?()
    }
    
}



