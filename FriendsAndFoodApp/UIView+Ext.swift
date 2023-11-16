//
//  UIView+Ext.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func createShadow(_ color : UIColor? = nil, opacity : Float? = nil, radius : CGFloat? = nil, width : CGFloat? = nil, height : CGFloat? = nil) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color != nil ? color!.cgColor : UIColor.black.cgColor
        self.layer.shadowOpacity = opacity != nil ? opacity! : 0.3
        self.layer.shadowRadius = radius != nil ? radius! : 4.0
        self.layer.shadowOffset = CGSize(width: (width != nil ? width! : 1.0), height: (height != nil ? height! : 3.0))
    }
    
    static var nibInstance : UIView? { return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView }
    
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        self.layer.addSublayer(border)
    }

}
