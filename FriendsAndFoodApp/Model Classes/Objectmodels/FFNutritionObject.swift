//
//  FFNutritionObject.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/23/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFNutritionObject: FFBaseResponseModel {

    var id:Int?
    var name:String?
    var quantity:String?
    var quantityFloat:Int?

    var measure:FFNutritionObject?
    var unit:String?
    var value:String?
    var nutriId: Int?
    var code:String?
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        quantity <- map["quantity"]
        quantityFloat <- map["quantity"]
        measure <- map["measure"]
        unit <- map["measure.code"]
        value <- map["value"]
        nutriId <- map["nutrition_id"]
        code <- map["code"]
    }
    
}
