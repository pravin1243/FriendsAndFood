//
//  FFReviewListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/18/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper


class FFReviewListRequestModel: FFBaseRequestModel {

    var recipeID:String?
    var maxResults:String?
    
    override func requestURL() -> String {
        if let recipeId = recipeID {
            return "recipes/\(UserDefault.standard.getSelectedLanguage())/\(recipeId)/reviews"
        }
        return ""
        
    }
    override func mapping(map: Map) {
        maxResults <- map["max_results"]
    }
    

    
}
