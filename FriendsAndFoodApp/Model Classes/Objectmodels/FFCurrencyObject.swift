//
//  FFCurrencyObject.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

class FFCurrencyObject: FFBaseResponseModel {

    var currencyid: Int?
    var code: String?
    var symbol: String?
    var id: Int?

    override func mapping(map: Map) {
        id <- map["id"]

        currencyid <- map["currency_id"]
        code <- map["code"]
        symbol <- map["symbol"]
    }
}
