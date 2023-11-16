//
//  FFUserAddressObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 23/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFUserAddressObject: FFBaseResponseModel {

    var address: String?
    var city: String?
    var addresstypeid: Int?
    var country: String?
    var zipcode: String?
    var cityid: Int?
    var countryid: Int?

    override func mapping(map: Map) {
        address <- map["address"]
        city <- map["city"]
        addresstypeid <- map["address_type_id"]
        country <- map["country"]
        zipcode <- map["zipcode"]
        cityid <- map["city_id"]
        countryid <- map["country_id"]

    }
}
