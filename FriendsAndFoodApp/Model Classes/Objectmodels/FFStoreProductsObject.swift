//
//  FFStoreProductsObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFStoreProductsObject: FFBaseResponseModel {

    var id: Int?
    var name: String?
    var productdescription: String?
    var namenormalized: String?
    var imagelarge: String?
    var imagemedium: String?
    var imagesmall: String?
    var storecategoryid: Int?
    var storecategoryname: String?
    var measureid: Int?
    var measurecode: String?
    var price: String?
    var weight: String?
    var currency: FFCurrencyObject?

    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        namenormalized <- map["name_normalized"]
        imagelarge <- map["image_large"]
        imagemedium <- map["image_medium"]
        imagesmall <- map["image_small"]
        storecategoryid <- map["store_category_id"]
        storecategoryname <- map["store_category_name"]
        measureid <- map["measure_id"]
        measurecode <- map["measure_code"]
        price <- map["price"]
        weight <- map["weight"]
        currency <- map["currency"]
        productdescription <- map["description"]

    }
    
}

