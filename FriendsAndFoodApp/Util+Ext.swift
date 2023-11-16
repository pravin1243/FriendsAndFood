//
//  Util+Ext.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 11/17/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

typealias Rational = (num : Int, den : Int)

func rationalApproximation(of x0 : Double, withPrecision eps : Double = 1.0E-6) -> Rational {
    var x = x0
    var a = x.rounded(.down)
    var (h1, k1, h, k) = (1, 0, Int(a), 1)

    while x - a > eps * Double(k) * Double(k) {
        x = 1.0/(x - a)
        a = x.rounded(.down)
        (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
    }
    return (h, k)
}

