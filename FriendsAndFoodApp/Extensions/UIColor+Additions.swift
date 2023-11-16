//
//  UIColor+Additions.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/4/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex:String) {
        
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = String(cString[cString.index(after: cString.startIndex)...])
        }
        
        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        } else {
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: 1.0)
        }
    }
    
    class var primary:UIColor {
        return UIColor(hex: "95c53b")
    }
}
