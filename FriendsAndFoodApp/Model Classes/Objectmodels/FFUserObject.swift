//
//  FFUserObject.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/8/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import ObjectMapper

class FFUserObject: NSObject, Mappable , NSCoding{
    
    var id:Int?
    var idString:String?
    var firstName:String?
    var lastName:String?
    var email:String?
    var nickName:String?
    var photo:String?
    var interests:[FFRecipeTypeObject]?
    var isProfessional:Int?
    var phone:String?
    var ownerofrestaurant:Int?
    var ownerofstore:Int?

    var ispublicphoto:Bool?
    var ispubliccontact:Bool?
    var userrestaurant:[FFCompanyObject]?
    var gender:Int?
    var birthdate: String?

//    var birthdate: FFbirthdateObject?
    var gamification: FFGamificationObject?
    var companyname:String?
    var companyidentificationnumber:String?
    var useraddress: FFUserAddressObject?
    var professionaladdress: FFUserAddressObject?
    var jobid: Int?
    var followerscount:Int?
    var followingcount:Int?
    var isfollowed:Int?
    var isfollower:Int?
    var invitedby: FFInvitedByObject?
    var storetype:String?
    
    var isStore:Int?
    var isRestaurant:Int?

    
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        idString <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        email  <- map["email"]
        nickName  <- map["nickname"]
        photo  <- map["photo"]
        interests <- map["interests"]
        isProfessional <- map["is_professional"]
        phone <- map["phone"]
        ownerofrestaurant <- map["owner_of_restaurant"]
        ispublicphoto <- map["is_public_photo"]
        ispubliccontact <- map["is_public_contact"]
        userrestaurant <- map["user_restaurant"]
        gender <- map["gender"]
        birthdate <- map["birthdate"]
        useraddress <- map["user_address"]
        gamification <- map["gamification"]
        companyname <- map["company_name"]
        companyidentificationnumber <- map["company_identification_number"]
        professionaladdress <- map["professional_address"]
        ownerofstore <- map["owner_of_store"]
        jobid <- map["job_id"]
        followerscount <- map["followers_count"]
        followingcount <- map["following_count"]
        isfollowed <- map["is_followed"]
        isfollower <- map["is_follower"]
        invitedby <- map["invited_by"]
        storetype <- map["store_type"]
        isStore <- map["is_store"]
        isRestaurant <- map["is_restaurant"]

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.id = aDecoder.decodeObject(forKey: "FFUserObject_id") as? Int
        self.firstName = aDecoder.decodeObject(forKey: "FFUserObject_firstname") as? String
        self.lastName  = aDecoder.decodeObject(forKey: "FFUserObject_lastName") as? String
        self.nickName = aDecoder.decodeObject(forKey: "FFUserObject_nickName") as? String
        self.email  = aDecoder.decodeObject(forKey: "FFUserObject_email") as? String
        self.photo  = aDecoder.decodeObject(forKey: "FFUserObject_photo") as? String
        self.isProfessional  = aDecoder.decodeObject(forKey: "FFUserObject_isprofessional") as? Int
        self.ownerofrestaurant  = aDecoder.decodeObject(forKey: "FFUserObject_ownerofrestaurant") as? Int
        self.ownerofstore  = aDecoder.decodeObject(forKey: "FFUserObject_ownerofstore") as? Int
        self.jobid  = aDecoder.decodeObject(forKey: "FFUserObject_jobid") as? Int
        self.storetype  = aDecoder.decodeObject(forKey: "FFUserObject_storetype") as? String
        self.isStore  = aDecoder.decodeObject(forKey: "FFUserObject_isStore") as? Int
        self.isRestaurant  = aDecoder.decodeObject(forKey: "FFUserObject_isRestaurant") as? Int

    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "FFUserObject_id")
        aCoder.encode(firstName, forKey: "FFUserObject_firstname")
        aCoder.encode(lastName, forKey: "FFUserObject_lastName")
        aCoder.encode(nickName, forKey: "FFUserObject_nickName")
        aCoder.encode(email, forKey: "FFUserObject_email")
        aCoder.encode(photo, forKey: "FFUserObject_photo")
        aCoder.encode(isProfessional, forKey: "FFUserObject_isprofessional")
        aCoder.encode(ownerofrestaurant, forKey: "FFUserObject_ownerofrestaurant")
        aCoder.encode(ownerofstore, forKey: "FFUserObject_ownerofstore")
        aCoder.encode(jobid, forKey: "FFUserObject_jobid")
        aCoder.encode(storetype, forKey: "FFUserObject_storetype")
        aCoder.encode(isStore, forKey: "FFUserObject_isStore")
        aCoder.encode(isRestaurant, forKey: "FFUserObject_isRestaurant")

    }
    
}
