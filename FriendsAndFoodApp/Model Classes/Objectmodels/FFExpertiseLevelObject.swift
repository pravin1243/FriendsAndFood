//
//  FFExpertiseLevelObject.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/8/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFExpertiseLevelObject: FFBaseResponseModel {

    var id: Int?
    var globalexpertiselevelid: Int?
    var name: String?


    override func mapping(map: Map) {
        id <- map["id"]
        globalexpertiselevelid <- map["global_expertise_level_id"]
        name <- map["name"]

    }
    
}
