//
//  DrawView.swift
//  DrawButton
//
//  Created by ktrkathir on 26/01/19.
//  Copyright © 2019 ktrkathir. All rights reserved.
//

import UIKit

/// DrawSwitchView
@IBDesignable class SwipeButtonView: UIView {
    
    /// Radius of background view
    @IBInspectable var radius: CGFloat = 10.0
    
    /// Background hint view
    @IBInspectable var hint: String = ""
    
    /// drag image
    @IBInspectable var image: UIImage?
    
    /// state
    private var isSuccess: Bool = false
    
    /// Completion handler
    private var completionHandler: ((_ status: String) -> ())?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        setUp()
    }
    
    public var hintLabel: UILabel = UILabel()
    
    public var swipeImageView: UIImageView = UIImageView()
    
    public var swipeImageViewAreaBig: UIImageView = UIImageView()
    
    public var swipeImage: UIImageView = UIImageView()
    
    private func setUp() {
        
        swipeImage.image = UIImage(named: "IC_SwipeRight")
        swipeImage.frame = CGRect(x: frame.height + 13, y: 11, width: 31, height: 24)
        self.addSubview(swipeImage)
        
        hintLabel.frame = CGRect(x: frame.height + 31 + 21, y: 0, width: frame.width - frame.height + 31 + 16, height: frame.height)
        self.addSubview(hintLabel)
        hintLabel.textColor = UIColor.white
        hintLabel.textAlignment = .left
        hintLabel.font = UIFont(name: "Rubik Medium", size: 14.0)
        hintLabel.text = hint
        //Rubik Medium 14.0
        
        
        swipeImageView.image = image?.imageWithInsets(insetDimen: 5.0)
        swipeImageView.frame = CGRect(x: 10, y: 5, width: 30, height: 30)
        swipeImageView.backgroundColor = UIColor.white
      //  swipeImageView.layer.cornerRadius = (frame.height - 10) / 2
        swipeImageView.layer.cornerRadius = 15
        swipeImageView.layer.borderColor = UIColor.clear.cgColor
        swipeImageView.layer.borderWidth = 5
//        swipeImageView.image?.addPadding(2.0)
        //alignmentRectInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.addSubview(swipeImageView)
        swipeImageView.isUserInteractionEnabled = true
        
        
        swipeImageViewAreaBig.frame = CGRect(x: -20, y: 0, width: 100, height: self.frame.height)
        swipeImageViewAreaBig.isUserInteractionEnabled = true
       // swipeImageViewAreaBig.backgroundColor = .yellow
        self.addSubview(swipeImageViewAreaBig)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first, swipeImageViewAreaBig == touch.view {
            print("Touches began")
            
            if let complete = self.completionHandler {
                complete("TouchBegan")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        
      //  print("Lable swipeImageView",hintLabel.frame.width)
      //  print("image swipeImageView",swipeImageView.frame.width)
      //  print("iamge",swipeImage.frame.width)
        
        let getFrameVal = hintLabel.frame.width - 44
        
        
        
        
        if let touch = touches.first, swipeImageViewAreaBig == touch.view
        {
            print("TOUCH",touch.view?.bounds.width)
            let touchedPosition = touch.location(in: self)
            
            //let alpha = (1.0 -  touchedPosition.x / frame.width)
           // swipeImageView.alpha = alpha
            
            if touchedPosition.x > (frame.height/2)
            {
                print("x position",touchedPosition.x)
                print("getValue",getFrameVal)
                
                if touchedPosition.x == getFrameVal
                {
                    setToDefault()
                   // setToDefault()
                }
                else
                {
                    swipeImageView.center = CGPoint(x: touchedPosition.x, y: swipeImageView.frame.midY)
                }
               //
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first, swipeImageViewAreaBig == touch.view
        {
            // let touchedPosition = touch.location(in: self)
            if let complete = self.completionHandler {
                complete("TouchEnded")
            }
            setToDefault()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if let touch = touches.first, swipeImageViewAreaBig == touch.view {
            
            if let complete = self.completionHandler {
                complete("TouchCancelled")
            }
            setToDefault()
        }
    }
    
    /// Set to default
    private func setToDefault() {
        
        if self.frame.midX > swipeImageView.center.x
        { // Move to initial
            UIView.animate(withDuration: 0.25, animations: {
                self.swipeImageView.frame.origin = CGPoint(x: 10, y: 5)
                self.swipeImageView.alpha = 1.0
            }) { (isFinished) in
                if isFinished {
                    self.isSuccess = false
                    
                    if let complete = self.completionHandler {
                        complete("Fail")
                    }
                }
            }
        } else if self.frame.midX < swipeImageView.center.x { // Move to final
            let xPosi = self.frame.width - (self.swipeImageView.frame.width + 5)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.swipeImageView.frame.origin = CGPoint(x: xPosi, y: 5)
                self.swipeImageView.alpha = 0.1
            }) { (isFinished) in
                if isFinished {
                    self.isSuccess = true
                    
                    if let complete = self.completionHandler {
                        
                        UIView.animate(withDuration: 0.25, animations: {
                            self.swipeImageView.frame.origin = CGPoint(x: 10, y: 5)
                            self.swipeImageView.alpha = 1.0
                        }) { (isFinished) in
                            
                        }
                        
                        complete("Finish")
                    }
                }
            }
        }
    }
    
    /// Handle action
    ///
    /// - Parameter completed: with completion
    public func handleAction(_ completed: @escaping((_ status: String) -> ()) ) {
        
        completionHandler = completed
    }
    
    /// Update hint value
    ///
    /// - Parameter text: by string
    public func updateHint(text: String) {
        hintLabel.text = text
    }
    
}
extension UIImage {

  func imageWithInsets(insetDimen: CGFloat) -> UIImage {

      return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))

  }

  

  func imageWithInset(insets: UIEdgeInsets) -> UIImage {

    UIGraphicsBeginImageContextWithOptions(

        CGSize(width: self.size.width + insets.left + insets.right,
               
               height: self.size.height + insets.top + insets.bottom), false, self.scale)

    let origin = CGPoint(x: insets.left, y: insets.top)

      self.draw(at: origin)

    let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()

      return imageWithInsets!

  }

  

}

