//
//  FFHomeFaqModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 12/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFHomeFaqModel: FFBaseRequestModel {

    var maxresults:String?
    var page: String?
    override func mapping(map: Map) {
        maxresults <- map["max_results"]
        page <- map["page"]

    }
    override func requestURL() -> String {
        return "\(UserDefault.standard.getSelectedLanguage())/faq"
    }

}
