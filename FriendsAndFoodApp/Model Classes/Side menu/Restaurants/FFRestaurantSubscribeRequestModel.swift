//
//  FFRestaurantSubscribeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 09/08/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFRestaurantSubscribeRequestModel: FFBaseRequestModel {

    var restId:Int?
    
    var name:String?
    var phone:String?
    var address:String?
    var city:String?
    var country:String?
    
    override func requestURL() -> String {
        if let id = restId {
            return "restaurants/\(id)/subscribe"
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        phone <- map["phone"]
        address <- map["address"]
        city <- map["city_name"]
        country <- map["country_name"]
    }
}
