//
//  FFUniverseObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 27/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFUniverseObject: FFBaseResponseModel {

    var id:Int?
    var universe_name: String?

    override func mapping(map: Map) {
        id <- map["id"]
        universe_name <- map["universe_name"]
    }
}
