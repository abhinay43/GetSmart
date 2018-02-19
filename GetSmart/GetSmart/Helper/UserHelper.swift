//
//  UserHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/29/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation

final class UserHelper
{
    fileprivate static let rememberLogin = "rememberLogin"
    fileprivate static let userId = "userId"
    fileprivate static let userEmail = "userEmail"
    fileprivate static let installedDate = "installedDate"
    fileprivate static let isInstalledDate = "isInstalledDate"
    
    static func logout()
    {
        let prefs = UserDefaults.standard
        prefs.set(false, forKey: rememberLogin)
        prefs.removeObject(forKey: userEmail)
        prefs.removeObject(forKey: userId)
        prefs.synchronize()
        
       //let _ =  UserProgressCoreHelper.deleteAllRecord()
      // let _ =  ArticleCoreHelper.deleteAllRecord()
        
    }
    
    static func rememberUserLogin(value:Bool){
        let prefs = UserDefaults.standard
        prefs.set(value, forKey: rememberLogin)
        prefs.synchronize()
    }
    static func isRememberLoginSelected()->Bool{
        let prefs = UserDefaults.standard
        return prefs.bool(forKey: rememberLogin)
    }
    
    static func setUserId(user_Id:String){
        let prefs = UserDefaults.standard
        prefs.set(user_Id, forKey: userId)
        prefs.synchronize()
    }
    
    static func getUserId() -> String{
        let prefs = UserDefaults.standard
        return prefs.string(forKey: userId)!
    }
    
    static func setUserEmail(user_email:String){
        let prefs = UserDefaults.standard
        prefs.set(user_email, forKey: userEmail)
        prefs.synchronize()
    }
    
    static func getUserEmail() -> String{
        let prefs = UserDefaults.standard
        return prefs.string(forKey: userEmail)!
    }
    
    static func isAppInstalledDateSaved()
    {
        let prefs = UserDefaults.standard
        if prefs.bool(forKey: isInstalledDate){
        }else{
            saveAppInstalledDate()
        }
        
    }
    
    fileprivate static func saveAppInstalledDate()
    {
        let prefs = UserDefaults.standard
        let date = Date()
        prefs.set(date, forKey: installedDate)
        prefs.set(true, forKey: isInstalledDate)
        prefs.synchronize()
        
    }
    
    
    
}
