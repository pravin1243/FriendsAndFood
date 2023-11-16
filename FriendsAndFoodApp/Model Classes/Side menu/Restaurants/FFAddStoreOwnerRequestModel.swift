//
//  FFAddStoreOwnerRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 24/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//


import Foundation
import ObjectMapper
import Alamofire


class FFAddStoreOwnerRequestModel: FFBaseRequestModel {

    var storeID:String?
    var isProfessional:String?

    override func requestURL() -> String {
        if let storeID = storeID {
            return "stores/\(UserDefault.standard.getSelectedLanguage())/add-owner-detail"
        }
        return ""
    }
// https://api.friends-and-food.com/restaurants/fr/add-owner-detail - POST
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        storeID <- map["store_id"]
        isProfessional <- map["is_professional"]
    }

    
}
