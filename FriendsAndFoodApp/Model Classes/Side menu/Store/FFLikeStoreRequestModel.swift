//
//  FFLikeStoreRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 09/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class FFLikeStoreRequestModel: FFBaseRequestModel {

    var storeid:Int?
    
    override func requestURL() -> String {
        
        if let id =   FFBaseClass.sharedInstance.getUser()?.id, let storeId = storeid  {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(id)/stores/favorites/\(storeId)"
        }
        return ""
    }
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.put
    }
}
