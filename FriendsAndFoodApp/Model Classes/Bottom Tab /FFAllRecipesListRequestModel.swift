//
//  FFAllRecipesListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 10/28/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFAllRecipesListRequestModel: FFBaseRequestModel {
    var maxResults:String?
    var page: String?

    override func requestURL() -> String {
        return "recipes/\(UserDefault.standard.getSelectedLanguage())"
    }
    override func mapping(map: Map) {
        maxResults <- map["max_results"]
        page <- map["page"]

//        typeId <- map["types"]

    }
}
