//
//  FFGamificationObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 23/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFGamificationObject: FFBaseResponseModel {

    var points: Int?
    var levelid: Int?
    var levelstepto: Int?
    var name: String?
    var levelstepfrom: Int?
    var image: String?

    override func mapping(map: Map) {
        points <- map["points"]
        levelid <- map["level_id"]
        levelstepto <- map["level_step_to"]
        name <- map["name"]
        levelstepfrom <- map["level_step_from"]
        image <- map["image"]
    }
}
