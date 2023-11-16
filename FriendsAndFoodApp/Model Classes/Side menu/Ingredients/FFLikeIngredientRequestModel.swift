//
//  FFLikeIngredientRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/28/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFLikeIngredientRequestModel: FFBaseRequestModel {

    var recipeId:String?
    
    var ingredientids: [String]?
    var isMultiple: Bool?

    override func requestURL() -> String {
        if let id =  FFBaseClass.sharedInstance.getUser()?.id , let recipeID = recipeId{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/ingredients/favorites/\(recipeID)"
        }
        return ""
    }
    
    
    override func requestMethod() -> HTTPMethod {
        if isMultiple == true {
            return HTTPMethod.post
        }else {
            return HTTPMethod.put
        }

    }
    
    override func mapping(map: Map) {
        ingredientids <- map["ingredient_ids"]

    }
}


