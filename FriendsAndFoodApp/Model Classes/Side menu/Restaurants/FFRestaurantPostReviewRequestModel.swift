//
//  FFRestaurantPostReviewRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 03/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFRestaurantPostReviewRequestModel: FFBaseRequestModel {
    
    var restaurantID:String?
    var review:String?
    var rating:String?
    
    override func requestURL() -> String {
        if let restaurantID = restaurantID {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/\(restaurantID)/reviews"
        }
        return ""
        
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        review <- map["review"]
        rating <- map["note"]
    }

    
}
