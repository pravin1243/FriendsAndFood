//
//  FFUpdateProfessionalInfoRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 24/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFUpdateProfessionalInfoRequestModel: FFBaseRequestModel {
    var companyname:String?
    var companyidentificationnumber:String?
    var jobid:String?
    var userid:String?

    override func requestURL() -> String {

        return "user/\(UserDefault.standard.getSelectedLanguage())/professional-data/update"
    }

    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    override func mapping(map: Map) {
        companyname <- map["company_name"]
        companyidentificationnumber <- map["company_identification_number"]
        jobid <- map["job_id"]
        userid <- map["user_id"]

    }
}
