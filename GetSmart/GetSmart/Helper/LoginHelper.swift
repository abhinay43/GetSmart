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
    static func loginWithMailID(mail:String, password:String, completionHandler:@escaping LoginCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.Login
       // https://dkbsmart-raviweb.c9users.io/api/login?email=speak2pearl@gmail.com&password=test123
        
        let params = ["email":mail,
                      "password":password]
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: params as [String : AnyObject], encoding: .URL) { (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                if let responseValue = value as? [String:Any]
                {
                    let status = responseValue["status"] as! String
                    let message = responseValue["message"] as! String
                    
                    if let userId = responseValue["user_id"] as? Int{
                        UserHelper.setUserId(user_Id: "\(userId)")
                    }
                    if status == "Success"{
                       completionHandler(true, message)
                    }else{
                       completionHandler(false, message)
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
