//
//  FFImageUploadRequest.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 13/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFImageUploadRequest: FFBaseRequestModel {

   
    
    override func requestURL() -> String {
        return "uploader.php"
    }
    
}
