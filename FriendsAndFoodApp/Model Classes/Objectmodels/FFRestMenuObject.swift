//
//  FFRestMenuObject.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 04/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFRestMenuObject: FFBaseResponseModel {

    var id:Int?
    var globalMenuId:Int?
    var restaurantId: Int?
    var menuDescription: String?
    var name: String?
    var price: Int?
    var currencyId: Int?
    var recipeTypeId: Int?

    var menurecipeid: Int?

    override func mapping(map: Map) {
        id <- map["id"]
        globalMenuId <- map["global_menu_id"]
        restaurantId <- map["restaurant_id"]
        menuDescription <- map["menu_description"]
        name <- map["name"]
        price <- map["price"]
        currencyId <- map["currency_id"]
        recipeTypeId <- map["recipe_type_id"]
        menurecipeid <- map["menu_recipe_id"]

    }
}
