//
//  FFPostReviewRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/21/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFPostReviewRequestModel: FFBaseRequestModel {
    
    var recipeID:String?
    var review:String?
    var rating:String?
    
    override func requestURL() -> String {
        if let recipeId = recipeID {
            return "recipes/\(UserDefault.standard.getSelectedLanguage())/\(recipeId)/reviews"
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
