//
//  UserDefault.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 25/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import Foundation
class UserDefault: NSObject {
    
    static let standard = UserDefault()
    let defaults = UserDefaults.standard
    
    func clearAll(){
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
            defaults.synchronize()
        }
    }
    
    func setCurrentDeviceToken(token: String) {
        defaults.set(token, forKey: "deviceToken")
    }
    
    func getCurrentDeviceToken() -> String{
        if let token = defaults.value(forKey: "deviceToken") as? String{
            return token
        }
        return "abc"
    }
    
    func setCurrentUserId(userId: Int) {
        defaults.set(userId, forKey: "userId")
    }
    
    func getCurrentUserId() -> Int?{
        if let userId = defaults.value(forKey: "userId") as? Int{
            return userId
        }
        return nil
    }
    
    func setUserName(name: String) {
        defaults.set(name, forKey: "UserName")
    }
    
    func getUserName() -> String{
        if let name = defaults.value(forKey: "UserName") as? String{
            return name
        }
        return ""
    }
    
    func setUserEmail(email: String) {
        defaults.set(email, forKey: "email")
    }
    
    func getUserEmail() -> String{
        if let email = defaults.value(forKey: "email") as? String{
            return email
        }
        return ""
    }
    
    func setUserMobile(mobile: String) {
        defaults.set(mobile, forKey: "mobile")
    }
    
    func getUserMobile() -> String{
        if let mobile = defaults.value(forKey: "mobile") as? String{
            return mobile
        }
        return ""
    }
    
    func setCurrentUserDetails(user: NSDictionary) {
        do {
            if #available(iOS 11.0, *) {
                try defaults.set(NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true), forKey: "userDetails")
            } else {
                // Fallback on earlier versions
            }
        }catch{
            debugPrint(error.localizedDescription)
        }
    }
    
    func getCurrentUserDetails() -> NSDictionary?{
        do {
             if let data = defaults.object(forKey: "userDetails") as? Data {
                 if let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSDictionary {
                     return user
                 }
             }
        }catch{
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func setSubscriptionMessage(msg: String) {
        defaults.set(msg, forKey: "SubscriptionMessage")
    }
    
    func getSubscriptionMessage() -> String{
        if let msg = defaults.value(forKey: "SubscriptionMessage") as? String{
            return msg
        }
        return ""
    }
    
    func setUserSubscriptionStatus(status: Int) {
        defaults.set(status, forKey: "SubscriptionStatus")
    }
    
    func getUserSubscriptionStatus() -> Int?{
        if let status = defaults.value(forKey: "SubscriptionStatus") as? Int{
            return status
        }
        return nil
    }
    
    
    func setSelectedLanguage(language: String) {
        defaults.set(language, forKey: "SelectedLanguage")
        NotificationCenter.default.post(name: .LanguageChanged, object: nil)
    }
    
    func getSelectedLanguage() -> String{
        if let language = defaults.value(forKey: "SelectedLanguage") as? String{
            return language
        }
        return "fr"
    }
    

    

    
    func setCurrentUserToken(token: String) {
        defaults.set(token, forKey: "userToken")
    }
    
    func getCurrentUserToken() -> String{
        if let token = defaults.value(forKey: "userToken") as? String{
            return token
        }
        return ""
    }
    
    
 
}
