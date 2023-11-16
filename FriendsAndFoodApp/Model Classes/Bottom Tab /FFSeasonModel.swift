//
//  FFSeasonModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 22/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFSeasonModel: FFBaseRequestModel {

    var categoryId:String?
    var ingredientId:String?
    override func mapping(map: Map) {
        ingredientId <- map["id"]
    }
    override func requestURL() -> String {
        return "ingredients/\(UserDefault.standard.getSelectedLanguage())/season"
    }
    

    
}
