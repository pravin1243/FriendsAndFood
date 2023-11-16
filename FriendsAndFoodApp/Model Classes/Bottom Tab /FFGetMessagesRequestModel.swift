//
//  FFGetMessagesRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFGetMessagesRequestModel: FFBaseRequestModel {
    
    var userID:Int?
    override func requestURL() -> String {
        
        if let id =   userID {
            return "messages/\(UserDefault.standard.getSelectedLanguage())/user/\(id)"
        }
        return ""
    }
   
}
