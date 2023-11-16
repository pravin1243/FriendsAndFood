//
//  FFRestaurantListCityWiseRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 07/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFRestaurantListCityWiseRequestModel: FFBaseRequestModel {

    var city_id: String?
    var page: String?

    override func requestURL() -> String {
     
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/getrbci"
        
        
//        https://api.friends-and-food.com/restaurants/fr/getrbci?city_id=1220&page=1

        
//        return "user/fr/1/restaurants"
//        https://api.friends-and-food.com/restaurants/fr/rwco?country_id=1&page=1
//        https://api.friends-and-food.com/user/fr/1/restaurants
//        /restaurants/{lang}/rwsearch
    }
    
    override func mapping(map: Map) {
        city_id <- map["city_id"]
        page <- map["page"]
    }
}
