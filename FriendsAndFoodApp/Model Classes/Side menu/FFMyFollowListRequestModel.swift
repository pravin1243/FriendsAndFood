//
//  FFMyFollowListRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 28/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation

class FFMyFollowListRequestModel: FFBaseRequestModel {

    var whichType: String?
    var userId: Int?
    override func requestURL() -> String {
        if let id =   userId {
            if whichType == "follower"{
                return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/followers"

            }else{
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/my-followed"
            }
        }
        return ""
    }
}
