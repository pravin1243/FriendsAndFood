//
//  FFGetFavRestaurantListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFGetFavRestaurantListRequestModel: FFBaseRequestModel {
    var userID:String?
    var page: String?

    override func requestURL() -> String {
        
        if let id =   FFBaseClass.sharedInstance.getUser()?.id {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/mfovres"
        }
        return "restaurants"
    }
    override func mapping(map: Map) {
        userID <- map["user_id"]
        page <- map["page"]

    }
  
}
