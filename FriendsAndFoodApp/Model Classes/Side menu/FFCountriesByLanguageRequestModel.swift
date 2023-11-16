//
//  FFCountriesByLanguageRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
class FFCountriesByLanguageRequestModel: FFBaseRequestModel {
    
    var languageId: String?
    override func requestURL() -> String {
        if let id =   languageId {
//            return "local/\(UserDefault.standard.getSelectedLanguage())/countries_by_language/\(id)"
            return "local/\(UserDefault.standard.getSelectedLanguage())/countries-list"
        }
        return ""
    }

}
