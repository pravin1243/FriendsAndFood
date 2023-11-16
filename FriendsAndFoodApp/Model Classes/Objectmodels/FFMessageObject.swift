//
//  FFMessageObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFMessageObject: FFBaseResponseModel {

    var id: Int?
    var fromuserid: Int?
    var touserid: Int?
    var content: String?
    var creationdate: String?
    var readdate: String?
    var messagestatus: Int?
    var images: Int?


    override func mapping(map: Map) {
        id <- map["id"]
        fromuserid <- map["from_user_id"]
        touserid <- map["to_user_id"]
        content <- map["content"]
        creationdate <- map["creation_date"]
        readdate <- map["read_date"]
        messagestatus <- map["status"]
        images <- map["images"]

    }
    
}
