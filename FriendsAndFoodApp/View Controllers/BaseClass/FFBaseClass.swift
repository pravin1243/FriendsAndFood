//
//  FFBaseClass.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/8/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFBaseClass: NSObject {

    static let sharedInstance  = FFBaseClass()
    var currentUser: FFUserObject?
    var currentJwt:String?
    var currentFavouriteIndex:Int?
    var isAddFriend:Bool? = false

    static var primaryColor:UIColor = {
        return UIColor(red: 149/255, green: 197/255, blue: 59/255, alpha: 1)
    }()
    
     func saveUser(user:FFBaseResponseModel?){
        if let user = user?.user {
            currentUser = user
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.setValue(data, forKey: "FF_USER_DETAILS")
            UserDefaults.standard.synchronize()
        }
        if let jwt = user?.jwt {
            currentJwt = jwt
            UserDefaults.standard.setValue(currentJwt, forKey: "FF_JWT")
            UserDefaults.standard.synchronize()
        }
    }
    
    func getUser() -> FFUserObject?{
        
        if let data = UserDefaults.standard.value(forKey: "FF_USER_DETAILS") as? Data {
            
            if let user =  NSKeyedUnarchiver.unarchiveObject(with: data) as? FFUserObject {
                
                self.currentUser = user
                return user
            }
        }
        
        if let jwt = UserDefaults.standard.value(forKey: "FF_JWT") as? String{
            self.currentJwt = jwt
        }
        
        return nil
    }
    
    func getJWT() -> String?{
        if let jwt = UserDefaults.standard.value(forKey: "FF_JWT") as? String{
            self.currentJwt = jwt
            return self.currentJwt
        }
        
        return nil

    }
    
    /*****************************************************/
    //MARK: -                     Setter Methods
    /*****************************************************/
    func setStringValue(stringValue: String! , key : String! ) {
        
        var token = ""
        token = stringValue
        if token.isEmpty == false {
            UserDefaults.standard.set(token, forKey: key)
            UserDefaults.standard.synchronize()
        }
        else {
            UserDefaults.standard.set("", forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    // Get Sesstion Token
     func getStringValue(key : String!) -> String {
         
         var token = UserDefaults.standard.value(forKey: key)
         if (token == nil) {
             token = ""
         }
         return token as! String
     }
    
    func clearUser(){
        UserDefaults.standard.setValue(nil, forKey: "FF_USER_DETAILS")
        UserDefaults.standard.synchronize()
    }
    
    
     func showAlert(mesage:String, title:String? = "", view: UIViewController?, action:(() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: mesage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.cancel, handler: { (alertAction) in
            action?()
        }))
        
        if let view = view {
            view.present(alert, animated: true, completion: nil)
        } else {
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentAlertWithTitle(title: String, message: String, view: UIViewController?, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        if let view = view {
                  view.present(alertController, animated: true, completion: nil)
              } else {
                  (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.present(alertController, animated: true, completion: nil)
              }
    }

    
     func showError(error:Error, view: UIViewController?) {
        if error.localizedDescription == "The Internet connection appears to be offline."{
   
            presentAlertWithTitle(title: "Erreur de réseau", message: "Impossible de se connecter à Friends & Food. Veuillez vérifier la connexion réseau de votre appareil.",view: view, options: "Annuler", "Réessayer") { (option) in
                print("option: \(option)")
                switch(option) {
                    case 0:
                        print("option one")
                        break
                    case 1:
                        print("option two")
                    default:
                        break
                }
            }

            
            
        }else{
            showAlert(mesage: error.localizedDescription, title: NSLocalizedString("Error", comment: ""), view: view)
        }
    }
    
    
    
    func toHtmlEncodedString(encodedString:String) -> String {
        guard let encodedData = encodedString.data(using: .utf8) else {
            return ""
        }
        
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            return( attributedString.string)
        } catch {
            print("Error: \(error)")
            
        }
        return ""
    }

    
}
extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
