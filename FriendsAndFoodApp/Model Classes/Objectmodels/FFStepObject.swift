//
//  FFStepObject.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 11/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFStepObject: FFBaseRequestModel {

    var id:Int?
    var name:String?
    var image:String?
    var position:String?
    var positionInt:Int?
    var isdefault:String?
    var isdefaultInt:Int?
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        position <- map["position"]
        isdefault <- map["is_default"]
        positionInt <- map["position"]
        isdefaultInt <- map["is_default"]
    }
    
}
