//
//  FFStoreTypeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 31/07/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation

class FFStoreTypeRequestModel: FFBaseRequestModel {
    
    override func requestURL() -> String {
            return "stores/\(UserDefault.standard.getSelectedLanguage())/store_type"

    }

}
