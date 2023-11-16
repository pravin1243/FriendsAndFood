//
//  FFReviewObject.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/18/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFReviewObject: FFBaseResponseModel {

    var id:String?
    var review:String?
    var rate:String?
    var note:Int?

    var createdDate:String?
    var userDetail:FFUserObject?
    override func mapping(map: Map) {
        id <- map["id"]
        review <- map["review"]
        rate <- map["note"]
        createdDate <- map["creation_date"]
        userDetail <- map["user"]
        note <- map["note"]
    }
}
