//
//  FFGetMeasureRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 11/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFGetMeasureRequestModel: FFBaseRequestModel {
    var ingredientId:String?
    
    override func requestURL() -> String {
        return "ingredients/\(UserDefault.standard.getSelectedLanguage())/measures"
    }
    
    override func mapping(map: Map) {
        ingredientId <- map["ingredient_id"]
    }
    
}
