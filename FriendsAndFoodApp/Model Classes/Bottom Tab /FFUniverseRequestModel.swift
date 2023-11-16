//
//  FFUniverseRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 27/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFUniverseRequestModel: FFBaseRequestModel {

    var type:String?
    override func mapping(map: Map) {
        type <- map["type"]

    }
    override func requestURL() -> String {
        return "categories/\(UserDefault.standard.getSelectedLanguage())/universes"
    }
}
