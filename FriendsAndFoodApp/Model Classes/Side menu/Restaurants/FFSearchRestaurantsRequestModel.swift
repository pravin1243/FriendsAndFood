//
//  FFSearchRestaurantsRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFSearchRestaurantsRequestModel: FFBaseRequestModel {

    var countryid:String?
    var regionid:String?
    var cityid:String?
    var searchText:String?

    
    override func mapping(map: Map) {
        countryid <- map["country_id"]
        regionid <- map["region_id"]
        cityid <- map["city_id"]
        searchText <- map["q"]

    }
    
    override func requestURL() -> String {
        return "restaurant/\(UserDefault.standard.getSelectedLanguage())"
    }
}
