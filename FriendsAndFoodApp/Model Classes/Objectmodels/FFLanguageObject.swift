//
//  FFLanguageObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFLanguageObject: FFBaseResponseModel {

    var id:Int?
    var name: String?
    var code: String?
    var flag: String?

    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        code <- map["code"]
        flag <- map["flag"]

    }
}
