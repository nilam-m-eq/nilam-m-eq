//
//  Extensions.swift
//  Mybyk
//
//  Created by Parth Kapadia on 06/07/21.
//

import UIKit

// uicolor init simplified
extension UIColor{
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}
