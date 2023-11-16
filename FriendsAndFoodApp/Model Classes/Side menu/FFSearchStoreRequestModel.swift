//
//  FFSearchStoreRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 06/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFSearchStoreRequestModel: FFBaseRequestModel {

    var countryid:String?
    var regionid:String?
    var cityid:String?
    var searchText:String?
    var typeid:String?
    var itemsperpage: String?
    var page: String?

    override func mapping(map: Map) {
        typeid <- map["type_id"]
        countryid <- map["country_id"]
        regionid <- map["region_id"]
        cityid <- map["city_id"]
        searchText <- map["q"]
        itemsperpage <- map["items_per_page"]
        page <- map["page"]

    }
//    https://api.friends-and-food.com/stores/fr?q=from&type_id=1&country_id=1&city_id=1220&region_id=19
    override func requestURL() -> String {
        return "stores/\(UserDefault.standard.getSelectedLanguage())"
    }
}
