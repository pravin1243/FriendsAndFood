//
//  FFGetRestaurantActivityRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 24/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper


class FFGetRestaurantActivityRequestModel: FFBaseRequestModel {

    var restaurantId:Int?
    
    override func requestURL() -> String {
        return "activities/\(UserDefault.standard.getSelectedLanguage())"
    }
    
    override func mapping(map: Map) {
        restaurantId <- map["restaurant_ids"]
    }
}
