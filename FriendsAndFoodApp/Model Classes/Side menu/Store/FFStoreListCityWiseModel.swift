//
//  FFStoreListCityWiseModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 07/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFStoreListCityWiseModel: FFBaseRequestModel {

    var city_id: String?
    var page: String?

    override func requestURL() -> String {
     
            return "stores/\(UserDefault.standard.getSelectedLanguage())"
    }
    
    override func mapping(map: Map) {
        city_id <- map["city_id"]
    }
}


//https://api.friends-and-food.com/stores/fr?city_id=1220
