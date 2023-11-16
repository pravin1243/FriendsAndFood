//
//  FFDeleteRecipeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 09/08/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class FFDeleteRecipeRequestModel: FFBaseRequestModel {
    
    var recipeid:Int?
    
    override func requestURL() -> String {
        if let id = recipeid {
            return "recipes/\(UserDefault.standard.getSelectedLanguage())/\(id)"
        }
        
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
    
}
