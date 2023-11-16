//
//  Localization.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 17/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import UIKit

private let appleLanguagesKey = "AppleLanguages"
private var bundleKey: UInt8  = 0

enum Localization: String {
    
    case english    = "en"
    case french    = "fr"
    case spanish    = "es"
    case german    = "de"
    case italian    = "it"

    var semantic: UISemanticContentAttribute {
        switch self {
            case .english:
                return .forceLeftToRight

        default:
            return .forceLeftToRight
        }
    }
    
    static var locale: Locale {
        return Locale(identifier: Localization.language.rawValue)
    }
    
    static var language: Localization {
        get {
            if let languageArray = UserDefaults.standard.object(forKey: appleLanguagesKey) as? [String],
                let languageCode = languageArray.first,
                let language = Localization(rawValue: languageCode) {
                return language
            } else {
                let defaultLanCode = Locale.current.languageCode ?? ""
                return Localization(rawValue: defaultLanCode) ?? Localization.english
            }
        }
        set {
//            guard language != newValue else { return }
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
            
//            DateHelper.shared.updateLocale()
            Bundle.setLanguage(language.rawValue)
//            AppDelegate.sharedInstance.initializeIntialViewCOntroller()

        }
    }
}
//===========================================================
//MARK: - String  Extension
//===========================================================
extension String {
    
    var localized: String {
        return CustomLanguageBundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
    var localizedImage: UIImage? {
        return localizedImage()
            ?? localizedImage(".png")
            ?? localizedImage(".jpg")
            ?? localizedImage(".jpeg")
            ?? UIImage(named: self)
    }
    
    private func localizedImage(_ type: String = "") -> UIImage? {
        guard let imagePath = CustomLanguageBundle.main.path(forResource: self, ofType: type) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}
//===========================================================
//MARK: - Bundle  Extension
//===========================================================
class CustomLanguageBundle: Bundle {
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, CustomLanguageBundle.self)
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey,Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
