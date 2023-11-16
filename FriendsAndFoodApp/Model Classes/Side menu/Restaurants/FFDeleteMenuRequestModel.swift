//
//  FFDeleteMenuRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class FFDeleteMenuRequestModel: FFBaseRequestModel {
    
    var menuid:String?
    
    override func requestURL() -> String {
        if let id = menuid {
            return "restaurants/\(UserDefault.standard.getSelectedLanguage())/menus/\(id)/delete_menu_recipe"
        }
        return ""
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.get
    }
    
}
