//
//  FFEditProfileRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 28/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFEditProfileRequestModel: FFBaseRequestModel {
    
    var id:String?
    var firstname:String?
    var lastName:String?
    var nickName:String?
    var email:String?
    var password:String?
    var image:String?
    var ok:String?
    var gender:String?
    var birthdate:String?
    var phone:String?
    var isprofessional:String?

    
    override func requestURL() -> String {
        if let userid = id {
            return "user/\(UserDefault.standard.getSelectedLanguage())/\(userid)"
        }
        return ""
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        firstname <- map["first_name"]
        lastName <- map["last_name"]
        nickName <- map["nickname"]
        email <- map["email"]
        password <- map["password"]
        image <- map["img"]
        ok <- map["ok"]
        gender <- map["gender"]
        birthdate <- map["birthdate"]
        phone <- map["phone"]
        isprofessional <- map["is_professional"]

    }
}
