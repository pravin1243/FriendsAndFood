//
//  FFRecipeTypeObject.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/7/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFRecipeTypeObject: FFBaseResponseModel {

    var id:Int?
    var stringId:String?
    var name:String?
    var name_normalized:String?
    var plural:String?
    var quantity:String?
    var quantityInt:Int?
    var quantityFloat:Float?
    var isSelected:Bool?

    var nutritions:[FFRecipeTypeObject]?
    var image:String?
    var familyImage:[FFRecipeTypeObject]?
    var familyImageObject:FFRecipeTypeObject?
    var checked:Int?
    var isLiked:String?
    var measure:FFMeasureObject?
    var isLike:Int?
    var imageSmall: String?
    var imageMedium: String?
    var imageLarge: String?
    var small: String?
    var medium: String?
    var large: String?
    var checkedInt:Int?

    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        name <- map["name"]
        name_normalized <- map["name_normalized"]
        plural <- map["plural"]
        quantity <- map["quantity"]
        nutritions <- map["nutrition"]
        image <- map["image"]
        stringId <- map["id"]
        familyImage <- map["images"]
        familyImageObject <- map["images"]
        checked <- map["checked"]
        isLiked <- map["is_liking"]
        measure <- map["measure"]
        quantityInt <- map["quantity"]
        quantityFloat <- map["quantity"]
        isLike <- map["is_like"]
        imageSmall <- map["image_small"]
        imageMedium <- map["image_medium"]
        imageLarge <- map["image_large"]

        small <- map["small"]
        medium <- map["medium"]
        large <- map["large"]

        checkedInt <- map["checked"]

    }
    
}
