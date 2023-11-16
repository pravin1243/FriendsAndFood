//
//  FFMyIngredientRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFMyIngredientRequestModel: FFBaseRequestModel {
    
    var userID:String?
    //https://api.friends-and-food.com/user/fr/6952/ingredients/favorites
    override func requestURL() -> String {
        
        return "user/\(UserDefault.standard.getSelectedLanguage())/\(userID ?? "")/ingredients/favorites"
        
    }

//    override func mapping(map: Map) {
//        userID <- map["user_like_id"]
//    }
}
