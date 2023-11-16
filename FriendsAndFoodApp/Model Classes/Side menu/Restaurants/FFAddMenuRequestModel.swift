//
//  FFAddMenuRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFAddMenuRequestModel: FFBaseRequestModel {

    var name:String?
    var price:String?
    var currencyid:String?
    var recipetypeid:String?
    var restaurantID:String?
    var isEdit:Bool?

    override func requestURL() -> String {
        if let restaurantID = restaurantID {
            if isEdit == true{
                return "restaurants/\(UserDefault.standard.getSelectedLanguage())/menus/\(restaurantID)/update_menu_recipe"

            }else{
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/menus/\(restaurantID)/add_menu_recipe"
            }
        }
        return ""
    }
    override func requestMethod() -> HTTPMethod {
       return  HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        price <- map["price"]
        currencyid <- map["currency_id"]
        recipetypeid <- map["recipe_type_id"]
    }
}
