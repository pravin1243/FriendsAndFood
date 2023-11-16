//
//  FFIngredientUploadObject.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 19/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFIngredientUploadObject: FFBaseResponseModel {
    
    var id:Int?
    var quantity:Float?
    var name:String?
    var measureId:String?
    var image:String?
    
    override func mapping(map: Map) {
        id <- map["id"]
        quantity <- map["quantity"]
        name <- map["name"]
        measureId <- map["measure_id"]
    }
    
}
