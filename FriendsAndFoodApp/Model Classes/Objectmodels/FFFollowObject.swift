//
//  FFFollowObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 28/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFFollowObject: FFBaseResponseModel {

    var followerid: Int?
    var followedid: Int?
    var photo: String?
    var firstname: String?
    var lastname: String?
    var gender: Int?

    override func mapping(map: Map) {
        followerid <- map["follower_id"]
        followedid <- map["followed_id"]

        photo <- map["photo"]
        firstname <- map["first_name"]
        lastname <- map["last_name"]
        gender <- map["gender"]

    }
    
}
