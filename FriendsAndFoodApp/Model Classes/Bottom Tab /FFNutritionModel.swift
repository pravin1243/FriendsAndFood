//
//  FFNutritionModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 22/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFNutritionModel: FFBaseRequestModel {

    var categoryId:String?
    var ingredientId:String?
    var page: String?
    override func mapping(map: Map) {
//        categoryId <- map["category_ids"]
//        ingredientId <- map["ingredient_id"]
//        page <- map["page"]

    }
    override func requestURL() -> String {
        return "ingredients/\(UserDefault.standard.getSelectedLanguage())/nutrition/\(ingredientId ?? "")"
    }
}
