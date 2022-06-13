//
//  BuzzPop.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/11/21.
//

import UIKit
import Foundation
import Lottie

public typealias BuzzAgainClosure = () -> Void
public typealias YesIDidClosure = () -> Void

class BuzzPop: UIView {
    
    static let instance = BuzzPop()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var buzzView: UIView!
    @IBOutlet var animateView: AnimationView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var messageLbl: UILabel!
    @IBOutlet var btnBuzzAgain: UIButton!
    @IBOutlet var btnYesIDid: UIButton!
    
    public var ActionBuzzAgain: BuzzAgainClosure?
    public var ActionYesIDid: YesIDidClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("BuzzPop", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        btnBuzzAgain.layer.cornerRadius = 6
        btnYesIDid.layer.cornerRadius = 6
        
        buzzView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showBuzzPopup(title: String, message: String, animationName: String) {
        
        self.lblTitle.text = title
        self.messageLbl.text = message
        
        animateView = .init(name: animationName)
        animateView.contentMode = .scaleAspectFit
        animateView.loopMode = .loop
        animateView.animationSpeed = 0.5
        animateView.play()
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func ActionBuzzAgain(_ sender: UIButton) {
        parentView.removeFromSuperview()
        ActionBuzzAgain?()
        
    }
    
    @IBAction func ActionYesIDid(_ sender: UIButton) {
        
        parentView.removeFromSuperview()
        ActionYesIDid?()
    }
    
    
    
}
