//
//  FFStoreProductCategoriesObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFStoreProductCategoriesObject: FFBaseResponseModel {

    var id: Int?
    var name: String?
    var imageicon: String?
    var products: [FFStoreProductsObject]?
    var count: Int?

    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        imageicon <- map["image_icon"]
        products <- map["products"]
    }
    
}
