//
//  FFSeasonObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 22/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFSeasonObject: FFBaseResponseModel {

    var isjanuary,isfebruary,ismarch,isapril,ismay,isjune,isjuly,isaugust,isseptember,isoctober,isnovember,isdecember:Int?
    
    override func mapping(map: Map) {
        isjanuary <- map["is_january"]
        isfebruary <- map["is_february"]
        ismarch <- map["is_march"]
        isapril <- map["is_april"]
        ismay <- map["is_may"]
        isjune <- map["is_june"]
        isjuly <- map["is_july"]
        isaugust <- map["is_august"]
        isseptember <- map["is_september"]
        isoctober <- map["is_october"]
        isnovember <- map["is_november"]
        isdecember <- map["is_december"]

    }
}
