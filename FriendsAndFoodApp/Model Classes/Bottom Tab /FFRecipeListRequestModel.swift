//
//  FFRecipeListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/17/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFRecipeListRequestModel: FFBaseRequestModel {

    var categoryId:String?
    var ingredientId:String?
    override func mapping(map: Map) {
        categoryId <- map["category_ids"]
        ingredientId <- map["ingredient_ids"]
    }
    
    override func requestURL() -> String {
        return "recipes/\(UserDefault.standard.getSelectedLanguage())"
    }
    
}
