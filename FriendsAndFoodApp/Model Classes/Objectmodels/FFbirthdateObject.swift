//
//  FFbirthdateObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 23/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFbirthdateObject: FFBaseResponseModel {

    var date: String?
    var timezone: String?
    var timezonetype: Int?

    override func mapping(map: Map) {
        date <- map["date"]
        timezone <- map["timezone"]
        timezonetype <- map["timezone_type"]

    }
}

