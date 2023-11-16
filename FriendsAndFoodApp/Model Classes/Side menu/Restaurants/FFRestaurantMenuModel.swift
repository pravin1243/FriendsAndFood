//
//  FFRestaurantMenuModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 04/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFRestaurantMenuModel: FFBaseRequestModel {

    var restId:Int?
    
    override func requestURL() -> String {
        if let id = restId {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/menus/\(id)"
        }
        return ""
    }
    //https://api.friends-and-food.com/restaurants/fr/menus/3
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.get
    }
    
}
