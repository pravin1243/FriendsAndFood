//
//  FFStoreProductCategoriesRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 08/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
class FFStoreProductCategoriesRequestModel: FFBaseRequestModel {

    var storeId: Int?
    var fromWhere: String?
override func requestURL() -> String {
    
    if let id = storeId {
        if fromWhere == "categories"{
        return "stores/\(UserDefault.standard.getSelectedLanguage())/categories/\(id)"
        }else{
            return "stores/\(UserDefault.standard.getSelectedLanguage())/\(id)/products"

        }
    }
    return ""

}
}
