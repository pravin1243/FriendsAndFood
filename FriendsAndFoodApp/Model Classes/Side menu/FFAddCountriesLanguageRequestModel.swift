//
//  FFAddCountriesLanguageRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/11/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFAddCountriesLanguageRequestModel: FFBaseRequestModel {
    
    var userid:String?
    var countryid:String?
    var languageid:String?
    override func requestURL() -> String {
            return "local/\(UserDefault.standard.getSelectedLanguage())/add_country_language"
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    override func mapping(map: Map) {
        userid <- map["user_id"]
        countryid <- map["country_id"]
        languageid <- map["language_id"]
    }

    
}
