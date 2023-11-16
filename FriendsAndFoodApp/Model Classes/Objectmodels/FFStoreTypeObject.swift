//
//  FFStoreTypeObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFStoreTypeObject: FFBaseResponseModel {

    var id:Int?
    var storeTypeId:Int?
    var name: String?
    var nameNormal: String?
    var plural: String?

    override func mapping(map: Map) {
        id <- map["id"]
        storeTypeId <- map["global_store_type_id"]
        name <- map["name"]
        nameNormal <- map["name_normalized"]
        plural <- map["plural"]

    }
}
