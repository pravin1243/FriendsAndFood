//
//  FFInviteUserRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 13/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFInviteUserRequestModel: FFBaseRequestModel {

    var isStore: Int?
    var firstname:String?
    var lastName:String?
    var email:String?
    var userid:Int?
    var restaurantid:Int?
    var storeid:Int?

    override func requestURL() -> String {
        if isStore == 1{
            return "stores/\(UserDefault.standard.getSelectedLanguage())/invite/user"

        }else{
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/invite/user"

        }
    }
    override func requestMethod() -> HTTPMethod {
       return  HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        firstname <- map["first_name"]
        lastName <- map["last_name"]
        email <- map["email"]
        userid <- map["user_id"]
        restaurantid <- map["restaurant_id"]
        storeid <- map["store_id"]

    }
}
