//
//  FFInvitedByObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFInvitedByObject: FFBaseResponseModel {

    var userid: Int?
    var username: String?
    var isprofessional: Int?
    var isrestaurant: Int?
    var ownerofrestaurantid: Int?
    var ownerofrestaurantname: String?
    var isstore: Int?
    var ownerofstoreid: Int?
    var ownerofstorename: String?

    override func mapping(map: Map) {
        userid <- map["user_id"]
        username <- map["user_name"]
        isprofessional <- map["is_professional"]
        isrestaurant <- map["is_restaurant"]
        ownerofrestaurantid <- map["owner_of_restaurant_id"]
        ownerofrestaurantname <- map["owner_of_restaurant_name"]
        isstore <- map["is_store"]
        ownerofstoreid <- map["owner_of_store_id"]
        ownerofstorename <- map["owner_of_store_name"]

    }
}
