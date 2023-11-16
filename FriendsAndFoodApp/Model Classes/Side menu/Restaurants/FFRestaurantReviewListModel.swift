//
//  FFRestaurantReviewListModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 03/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper


class FFRestaurantReviewListModel: FFBaseRequestModel {

    var restaurantID:String?
    var maxResults:String?
    
    override func requestURL() -> String {
        if let restaurantID = restaurantID {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/\(restaurantID)/reviews"
        }
        return ""
        
    }
    override func mapping(map: Map) {
        maxResults <- map["max_results"]
    }
    

    
}
