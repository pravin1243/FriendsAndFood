//
//  FFSpecialDietObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 27/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFSpecialDietObject: FFBaseResponseModel {

    var specialdiet: String?

    override func mapping(map: Map) {
        specialdiet <- map["specialdiet"]
    }
}
