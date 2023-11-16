//
//  FFAddOwnerDetailsRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 10/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire


class FFAddOwnerDetailsRequestModel: FFBaseRequestModel {

    var restaurantID:String?
    var isProfessional:String?

    override func requestURL() -> String {
        if let restaurantID = restaurantID {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/add-owner-detail"
        }
        return ""
        
    }
// https://api.friends-and-food.com/restaurants/fr/add-owner-detail - POST
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        restaurantID <- map["restaurant_id"]
        isProfessional <- map["is_professional"]
    }

    
}
