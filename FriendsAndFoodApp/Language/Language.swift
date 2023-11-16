//
//  Language.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 25/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

enum Language: String {
    case english    = "en"
    case french    = "fr"
    case spanish    = "es"
    case german    = "de"
    case italian    = "it"

    
    var title : String {
        switch self {
        case .english: return "english".localized
        case .french: return "french".localized
        case .spanish: return "spanish".localized
            case .german: return "german".localized
            case .italian: return "italian".localized

        }
    }
}
