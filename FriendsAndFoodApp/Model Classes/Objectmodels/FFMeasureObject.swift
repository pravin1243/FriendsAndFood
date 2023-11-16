//
//  FFMeasureObject.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 11/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFMeasureObject: FFBaseResponseModel {
    
    var id:String?
    var idInt:Int?
    var name:String?
    var code:String?
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        code <- map["code"]
        idInt <- map["id"]
    }
    
    
}
