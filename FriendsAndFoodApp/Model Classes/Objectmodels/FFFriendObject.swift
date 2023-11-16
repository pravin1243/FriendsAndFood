//
//  FFFriendObject.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 03/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFFriendObject: FFBaseResponseModel {
//    "user_id": "6929",
//    "user_invited_id": "6924",
//    "status": "1",
//    "status_invited": "1",
//    "creation_date": "2018-07-03 06:25:55",
//    "user": {
//    "id": "6924",
//    "nickname": "neethu",
//    "nickname_normalized": null,
//    "gender": null,
//    "first_name": "neethu",
//    "last_name": "m",
//    "status": "1",
//    "creation_date": "2018-05-02 08:07:13",
//    "points": "100"
//    }
    
    
//    {
//      "id" : 1,
//      "country" : null,
//      "level_id" : 0,
//      "points" : null,
//      "is_public_photo" : 0,
//      "first_name" : "Malik",
//      "city" : "1349",
//      "birthday" : null,
//      "nickname" : "malert",
//      "last_name" : "Ben Thaier",
//      "photo" : null,
//      "gender" : "Monsieur"
//    }
    
    var userId:String?
    var userInvitedId:String?
    var invitedStatus:String?
    var userDetail: FFUserObject?
    
    var id:Int?
    var country:String?
    var level_id:Int?
    var first_name:String?
    var city:String?
    var nickname:String?
    var last_name:String?
    var gender: String?
    
    var ispublicphoto: Int?
    var photo: String?
    override func mapping(map: Map) {
        userId <- map["user_id"]
        userInvitedId <- map["user_invited_id"]
        invitedStatus <- map["status_invited"]
        id <- map["id"]
        country <- map["country"]
        level_id <- map["level_id"]
        first_name <- map["first_name"]
        city <- map["city"]
        nickname <- map["nickname"]
        last_name <- map["last_name"]
        gender <- map["gender"]
        ispublicphoto <- map["is_public_photo"]
        photo <- map["photo"]

    }
    
}
