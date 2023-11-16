//
//  FFPostContactRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 12/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class FFPostContactRequestModel: FFBaseRequestModel {
    
    var email:String?
    var subject:String?
    var message:String?
    var firstname:String?
    var lastName:String?
    var gender:String?
    var phone:String?

    override func requestURL() -> String {
            return "user/\(UserDefault.standard.getSelectedLanguage())/send-contact-mail"
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        email <- map["email"]
        subject <- map["subject"]
        message <- map["message"]
        subject <- map["subject"]
        firstname <- map["first_name"]
        lastName <- map["last_name"]
        gender <- map["gender"]
        phone <- map["phone"]

    }

    
}
