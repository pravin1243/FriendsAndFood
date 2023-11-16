//
//  FFDisplayHourModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 05/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
import ObjectMapper

struct FFDisplayHourModel: Codable {
    var day:String?
    var lunchFrom:[fromToTime]?
    var lunchTo:[fromToTime]?
    
    var allDayFrom:[fromToTime]?
    var allDayTo:[fromToTime]?

    var dinnerFrom:[fromToTime]?
    var dinnerTo:[fromToTime]?
    var isChecked: Int?
    
    var selectedFrom: Int?
    var selectedTo: Int?

    var isOpen: Int?

}
struct fromToTime:Codable {
    var fromTime: String?
    var toTime: String?
    var isChecked: Int?
    mutating func updateCheck(status: Int) {
        isChecked = status
    }

}
