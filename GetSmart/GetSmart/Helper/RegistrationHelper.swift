//
//  RegistrationHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/26/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation

//Class
final class RegistrationHelper
{
    typealias RegistrationCompletionHandler = (_ requestSuccess:Bool, _ message:String) -> ()
}

extension RegistrationHelper
{
    //MARK:- API calling
    static func registrationWithMailID(mail:String, firstName:String, lastName:String, professionID:String, specialitiesID:String, completionHandler:@escaping RegistrationCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.Register
        let params = ["email":mail,
                      "first_name":firstName,
                      "last_name":lastName,
                      "profession_id":professionID,
                      "specialities_id":specialitiesID,]
        
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: params as [String : AnyObject], encoding: .URL) { (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                
                if let responseValue = value as? [String:Int]
                {
                    let status = responseValue["status"]!
                    if let userId = responseValue["userId"]{
                        UserHelper.setUserId(user_Id: "\(userId)")
                    }
                    
                    var message:String!
                    switch status
                    {
                    case 1:
                        message = "User has Successfully Registered."
                        UserHelper.rememberUserLogin(value: true)//Remember Login
                        UserHelper.setUserEmail(user_email:"\(mail)")//Save User Email Id
                        completionHandler(true, message)
                    case 2:
                        message = "Email is already in use. Try to log in or choose another email."
                        completionHandler(false, message)
                    case 3:
                        message = "Email Address is Blank, Provide Valid Email Address."
                        completionHandler(false, message)
                    case 4:
                        message = "First Name is Blank, Provide First Name."
                        completionHandler(false, message)
                    case 5:
                        message = "Last Name is Blank, Provide Last Name."
                        completionHandler(false, message)
                    case 6:
                        message = "Profession ID is Blank, Provide Profession ID."
                        completionHandler(false, message)
                    case 7:
                        message = "Specialities ID is Blank, Provide Specialities ID."
                        completionHandler(false, message)
                    default:
                        completionHandler(false, GetSmartConstant.Alert.SomethingWentWrong)
                    }
                }
                
                break
            case .SomethingWrong:
                completionHandler(false, GetSmartConstant.Alert.SomethingWentWrong)
                break
            }
        }
    }
    
}
