//
//  FFStoreDetailModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 07/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation

class FFStoreDetailModel: FFBaseRequestModel {

    var storeId: Int?
override func requestURL() -> String {
    
    if let id = storeId {
        return "stores/\(UserDefault.standard.getSelectedLanguage())/\(id)"
    }
    return ""

}
}
