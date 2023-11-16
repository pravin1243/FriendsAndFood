//
//  FFBaseRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/3/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFBaseRequestModel: Mappable {
    var files:String?
    
    func requestMethod() -> HTTPMethod {
        return .get
    }
    
    func requestURL() -> String {
        fatalError("Override requestURL")
        
    }
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        
    }
}
