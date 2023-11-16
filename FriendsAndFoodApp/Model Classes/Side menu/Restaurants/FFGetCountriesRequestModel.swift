//
//  FFGetCountriesRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 26/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFGetCountriesRequestModel: FFBaseRequestModel {
//    https://api.friends-and-food.com/local/fr/countries-list
    var searchText:String?

    override func requestURL() -> String {
        return "local/\(UserDefault.standard.getSelectedLanguage())/countries-list"
    }
    
    override func mapping(map: Map) {
         searchText <- map["q"]
     }
//https://api.friends-and-food.com/local/fr/countries-list?q=Ind
}
