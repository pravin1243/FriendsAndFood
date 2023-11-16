//
//  FFAddRecipeRequestModel.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 14/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class FFAddRecipeRequestModel: FFBaseRequestModel {

    var isEdit:Bool?
    var id:String?
    var name:String?
    var description:String?
    var interest:String?
    var img0:String?
    var img1:String?
    var img2:String?
    var img3:String?
    var img4:String?
    var img5:String?
    
    var typeId:String?
    var toughnessID:String?
    var prepTime:String?
    var bakingTime:String?
    var personCnt:String?
    var categoryId:String?
    var steps:[FFStepObject]?
    var ingredients:[FFIngredientUploadObject]?
    var images:[FFRecipeTypeObject]?
    
    var deleteUrls:String?
    var ok:String?
    var isPrivate: Int?
    var deletedsteps: [String]?
    override func requestMethod() -> HTTPMethod {
        if isEdit == true {
            return HTTPMethod.post
        }else {
            return HTTPMethod.post
        }
        
    }
    
    override func requestURL() -> String {
        if isEdit == true {
            if let id = id {
                return "recipes/\(UserDefault.standard.getSelectedLanguage())/\(id)"
            }
        }else {
        
            return "recipes/\(UserDefault.standard.getSelectedLanguage())"
        }
     return ""
    }
    
    override func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        interest <- map["interests"]
        typeId <- map["type_id"]
        toughnessID <- map["toughness_id"]
        prepTime <- map["preparation_time"]
        bakingTime <- map["baking_time"]
        personCnt <- map["nb_persons"]
        categoryId <- map["category_id"]
        ok <- map["ok"]
        isPrivate <- map["is_private"]
        var cnt = 0
        while ( cnt < (ingredients?.count)!) {
            ingredients![cnt].id <- map["ingredients[\(cnt)][id]"]
            ingredients![cnt].quantity <- map["ingredients[\(cnt)][quantity]"]
            ingredients![cnt].measureId <- map["ingredients[\(cnt)][measure_id]"]
            cnt = cnt + 1
        }
        
        var stepCnt = 0
        while (stepCnt < (steps?.count)! ){
            steps![stepCnt].name <- map["steps[\(stepCnt)][name]"]
            steps![stepCnt].isdefault <- map["steps[\(stepCnt)][is_default]"]
            steps![stepCnt].position <- map["steps[\(stepCnt)][position]"]
            stepCnt = stepCnt + 1
        }
        
        img0 <- map["img0"]
        img1 <- map["img1"]
        img2 <- map["img2"]
        img3 <- map["img3"]
        img4 <- map["img4"]
        img5 <- map["img5"]
        
        deleteUrls <- map["deleted_images"]
        deletedsteps <- map["deleted_steps"]
    }
}
