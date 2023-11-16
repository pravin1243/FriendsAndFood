//
//  FFGetCitiesRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFGetCitiesRequestModel: FFBaseRequestModel {
    var countryid:String?
    var regionid:String?
    var searchText:String?

    override func requestURL() -> String {
        return "local/\(UserDefault.standard.getSelectedLanguage())/cities-list"
    }
    
    override func mapping(map: Map) {
        countryid <- map["country"]
        regionid <- map["region"]
        searchText <- map["q"]

    }
}
