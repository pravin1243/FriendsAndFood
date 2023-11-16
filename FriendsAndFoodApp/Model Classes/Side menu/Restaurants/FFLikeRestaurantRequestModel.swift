//
//  FFLikeRestaurantRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Luminescent Digital on 24/07/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFLikeRestaurantRequestModel: FFBaseRequestModel {

    var restaurantid:Int?
    
    override func requestURL() -> String {
        
        if let id =   FFBaseClass.sharedInstance.getUser()?.id, let restId = restaurantid  {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/restaurants/favorites/\(restId)"
        }
        return ""
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.put
    }
}
