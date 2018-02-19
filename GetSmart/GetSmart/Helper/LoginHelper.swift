//
//  LoginHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/26/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation

//Class
final class LoginHelper
{
    typealias LoginCompletionHandler = (_ requestSuccess:Bool, _ message:String) -> ()
}

extension LoginHelper
{
    //MARK:- API calling
    static func loginWithMailID(mail:String, completionHandler:@escaping LoginCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.Login
        let params = ["email":mail]
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: params as [String : AnyObject], encoding: .URL) { (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                if let responseValue = value as? [String:Any]
                {
                    let status = responseValue["status"] as! Int
                    if let userId = responseValue["userId"] as? Int{
                        UserHelper.setUserId(user_Id: "\(userId)")
                    }
                    var message:String!
                    switch status
                    {
                    case 0:
                        message = "This email was not found in our database. Please create an account."
                        completionHandler(false, message)
                    case 1:
                        UserHelper.setUserEmail(user_email:"\(mail)")//Save User Email Id
                        message = "User has logged in."
                        completionHandler(true, message)
                    case 2:
                        message = "Email Address is Blank, Provide Proper Email Address."
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
