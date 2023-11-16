//
//  FFPlaceObject.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFPlaceObject: FFBaseResponseModel {

    var id:String?
    var idInt:Int?
    var name:String?
    var globalJobId: Int?
    var code: String?
    var flag: String?
    var countryid: Int?
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        idInt <- map["id"]
        globalJobId <- map["global_job_id"]
        code <- map["code"]
        flag <- map["flag"]
        countryid <- map["country_id"]

        
    }
}
