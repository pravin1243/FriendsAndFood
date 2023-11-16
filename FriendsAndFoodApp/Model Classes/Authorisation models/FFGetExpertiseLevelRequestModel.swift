//
//  FFGetExpertiseLevelRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/8/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFGetExpertiseLevelRequestModel: FFBaseRequestModel {
    override func requestURL() -> String {
            return "user/\(UserDefault.standard.getSelectedLanguage())/get_expertise_level"
    }
}
