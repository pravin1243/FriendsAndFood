//
//  FFRestaurantMenuObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 04/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFRestaurantMenuObject: FFBaseResponseModel {

    var id:Int?
    var name: String?
    var menus: [FFRestMenuObject]?
    var count: Int?

    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        menus <- map["menus"]
    }
}
