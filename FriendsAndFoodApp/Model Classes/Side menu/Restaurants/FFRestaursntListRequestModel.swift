//
//  FFRestaursntListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 19/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFRestaursntListRequestModel: FFBaseRequestModel {

    var country_id: String?
    var page: String?
    var maxResults:String?

    override func requestURL() -> String {
     
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/rwco"
        
        
//        return "user/fr/1/restaurants"
//        https://api.friends-and-food.com/restaurants/fr/rwco?country_id=1&page=1
//        https://api.friends-and-food.com/user/fr/1/restaurants
//        /restaurants/{lang}/rwsearch
    }
    
    override func mapping(map: Map) {
        country_id <- map["country_id"]
        page <- map["page"]
        maxResults <- map["max_results"]

    }
}
