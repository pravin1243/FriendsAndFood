//
//  FFNicknameSearchRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 10/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFNicknameSearchRequestModel: FFBaseRequestModel {

    var searchText:String?
    
    override func requestURL() -> String {
        return "user/\(UserDefault.standard.getSelectedLanguage())/friends-suggestion"
    }
    override func mapping(map: Map) {
        searchText <- map["q"]
    }
    
}
