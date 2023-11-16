//
//  FFMemberFavouritesRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 28/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFMemberFavouritesRequestModel: FFBaseRequestModel {
    
    var memberID:Int?
    override func requestURL() -> String {
        
        if let id =   memberID {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/member-favorites"
        }
        return ""
    }
   
}
