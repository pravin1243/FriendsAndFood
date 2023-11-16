//
//  FFIngreVarietyRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFIngreVarietyRequestModel: FFBaseRequestModel {

    var ingredientId:String?

    override func requestURL() -> String {
        return "ingredients/\(UserDefault.standard.getSelectedLanguage())/variances/\(ingredientId ?? "")"
    }
}
