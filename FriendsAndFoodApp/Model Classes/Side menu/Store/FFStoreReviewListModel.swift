//
//  FFStoreReviewListModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 03/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper


class FFStoreReviewListModel: FFBaseRequestModel {

    var storeID:String?
    var maxResults:String?
    
    override func requestURL() -> String {
        if let storeID = storeID {
            return "stores/\(UserDefault.standard.getSelectedLanguage())/\(storeID)/reviews"
        }
        return ""
        
    }
    override func mapping(map: Map) {
        maxResults <- map["max_results"]
    }
    

    
}
