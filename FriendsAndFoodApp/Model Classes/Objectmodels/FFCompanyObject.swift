//
//  FFCompanyObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 18/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFCompanyObject: FFBaseResponseModel {

    var companyname: String?
    var companyphone: String?
    var restaurantid: Int?
    var companyaddress: String?

    override func mapping(map: Map) {
        companyname <- map["company_name"]
        companyphone <- map["company_phone"]
        restaurantid <- map["restaurant_id"]
        companyaddress <- map["company_address"]

    }
}
