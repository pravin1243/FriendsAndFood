//
//  FFRecipeListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/3/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFEntranceListRequestModel: FFBaseRequestModel {
    var typeId: String?
    
    override func requestURL() -> String {
        return "recipes/\(UserDefault.standard.getSelectedLanguage())"
    }
    override func mapping(map: Map) {
        typeId <- map["type_ids"]
//        typeId <- map["types"]

    }
}
