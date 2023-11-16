//
//  LanguageObservable.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 25/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let LanguageChanged = NSNotification.Name("LanguageChanged")
}

protocol LanguageObservable: class {
    func addLangaugeChangeObserverToMethod(_ selector : Selector)
}

extension LanguageObservable where Self: NSObjectProtocol {
    
    func addLangaugeChangeObserverToMethod(_ selector : Selector) {
        self.perform(selector)
        NotificationCenter.default.addObserver(self, selector: selector, name: .LanguageChanged, object: nil)
    }
}
