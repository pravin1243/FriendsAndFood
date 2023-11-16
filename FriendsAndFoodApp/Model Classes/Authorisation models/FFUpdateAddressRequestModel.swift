//
//  FFUpdateAddressRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 24/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFUpdateAddressRequestModel: FFBaseRequestModel {
    var userid:String?
    var addresstypeid:Int?
    var zipcode:String?
    var address:String?
    var cityid:Int?
    var countryid:Int?
    var regionid:Int?


    override func requestURL() -> String {

        return "user/\(UserDefault.standard.getSelectedLanguage())/user-address/update"
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func mapping(map: Map) {
        userid <- map["user_id"]
        addresstypeid <- map["address_type_id"]
        address <- map["address"]
        zipcode <- map["zipcode"]
        cityid <- map["city_id"]
        countryid <- map["country_id"]
        regionid <- map["region_id"]

    }
}

