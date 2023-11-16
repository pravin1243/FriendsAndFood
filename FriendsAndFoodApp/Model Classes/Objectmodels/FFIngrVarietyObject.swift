//
//  FFIngrVarietyObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFIngrVarietyObject: FFBaseResponseModel {

    var id:Int?
    var globalIngredientId:Int?
    var name: String?
    var nameNormal: String?
    var plural: String?
    var imageName: String?
    var imageSmall: String?
    var imageMedium: String?
    var imageLarge: String?

    override func mapping(map: Map) {
        id <- map["id"]
        globalIngredientId <- map["global_ingredient_id"]
        name <- map["name"]
        nameNormal <- map["name_normalized"]
        plural <- map["plural"]
        imageName <- map["image_name"]
        imageSmall <- map["image_small"]
        imageMedium <- map["image_medium"]
        imageLarge <- map["image_large"]

    }
}
