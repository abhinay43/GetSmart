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
    static func registrationWithMailID(mail:String, password:String, completionHandler:@escaping RegistrationCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.Register
        let params = ["email":mail,
                      "password":password,
                      ]
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
