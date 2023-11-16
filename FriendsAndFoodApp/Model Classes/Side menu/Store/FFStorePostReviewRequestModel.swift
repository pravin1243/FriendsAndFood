//
//  FFStorePostReviewRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 03/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFStorePostReviewRequestModel: FFBaseRequestModel {
    
    var storeID:String?
    var review:String?
    var rating:String?
    
    override func requestURL() -> String {
        if let storeID = storeID {
            return "stores/\(UserDefault.standard.getSelectedLanguage())/\(storeID)/reviews"
        }
        return ""
        
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        review <- map["review"]
        rating <- map["note"]
    }

    
}
