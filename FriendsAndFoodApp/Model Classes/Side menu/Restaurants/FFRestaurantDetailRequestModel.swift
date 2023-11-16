//
//  FFRestaurantDetailRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 31/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFRestaurantDetailRequestModel: FFBaseRequestModel {

    var restaurantID:Int?
    var userID:String?

    override func requestURL() -> String {
        if let id = restaurantID {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/\(id)"
        }
        return ""
    }
    override func mapping(map: Map) {
          userID <- map["user_id"]

      }
}
