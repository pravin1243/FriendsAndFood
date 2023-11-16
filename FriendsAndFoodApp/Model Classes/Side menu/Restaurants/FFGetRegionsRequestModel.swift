//
//  FFGetRegionsRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFGetRegionsRequestModel:FFBaseRequestModel {
    var searchText:String?

    var countryid:String?
    override func requestURL() -> String {
        return "local/\(UserDefault.standard.getSelectedLanguage())/subregions-list"
    }
    
    override func mapping(map: Map) {
        countryid <- map["country"]
        searchText <- map["q"]
    }
}
