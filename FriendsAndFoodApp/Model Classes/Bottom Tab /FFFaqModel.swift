//
//  FFFaqModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 22/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFFaqModel: FFBaseRequestModel {

    var categoryId:String?
    var ingredientId:String?
    var page: String?
    override func mapping(map: Map) {
        ingredientId <- map["ingredient_id"]
        page <- map["page"]

    }
    override func requestURL() -> String {
        return "\(UserDefault.standard.getSelectedLanguage())/faq"
    }

}
