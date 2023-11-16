//
//  FFStoreListModel.swift
//  FriendsAndFoodApp
//
//  Created by Rachit Kumar on 06/08/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
class FFStoreListModel: FFBaseRequestModel {
    var typeId: String?

    override func requestURL() -> String {
            return "stores/\(UserDefault.standard.getSelectedLanguage())/type/\(typeId ?? "")"

    }
}
