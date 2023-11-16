//
//  FFSearchIngredientRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 11/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper


class FFSearchIngredientRequestModel: FFBaseRequestModel {

    var searchText:String?
    
    override func requestURL() -> String {
        return "ingredients/\(UserDefault.standard.getSelectedLanguage())"
    }
    override func mapping(map: Map) {
        searchText <- map["q"]
    }
    
}
