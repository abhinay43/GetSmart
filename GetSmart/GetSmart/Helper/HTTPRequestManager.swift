//
//  HTTPRequestManager.swift
//  Recycle
//
//  Created by Abhinay Maurya on 04/08/16.
//  Copyright © 2016 nlightn technologies. All rights reserved.
//

import Alamofire

class HTTPRequestManager
{
    enum HTTPResponse : String{
        case Success, SomethingWrong
    }
    
    enum ProtocolMethod:String{
        case GET, POST, PUT
    }
    enum ProtocolEncoding:String{
        case URL, JSON
    }
    
    
    typealias HTTPRequestCompletionHandler = (_ response:HTTPResponse, _ value:AnyObject?, _ statusCode:Int?) -> ()
    
    static func httpRequest(url urlString:String, protocolMethod method:ProtocolMethod, parameters params:[String:AnyObject]?, encoding:ProtocolEncoding, completionHandler:@escaping HTTPRequestCompletionHandler)
    {
        var requestProtocolMetohd:HTTPMethod
        switch method
        {
            case .GET:
                requestProtocolMetohd = .get
                break
            case .POST:
                requestProtocolMetohd = .post
                break
            case .PUT:
                requestProtocolMetohd = .put
                break
        }
        
        var requestEncoding:ParameterEncoding = URLEncoding()
        
        switch encoding
        {
            case .URL:
                requestEncoding = URLEncoding()
                break
            case .JSON:
                requestEncoding = JSONEncoding()
                break
        }
        
        Alamofire.request(urlString, method: requestProtocolMetohd, parameters: params, encoding: requestEncoding, headers: nil).responseJSON { response in
            let statusCode = response.response?.statusCode
            print(response)
            print(response.response ?? "")
            
            if let value = response.result.value{
                completionHandler(HTTPResponse.Success, value as AnyObject?, statusCode)
            }else{
                completionHandler(HTTPResponse.SomethingWrong, response.result.value as AnyObject? , statusCode)
            }
        }
        
//        Alamofire.request(requestProtocolMetohd, urlString, parameters: params, encoding:requestEncoding).responseJSON { response in
//                
//                let statusCode = response.response?.statusCode
//                print(response)
//                print(response.response)
//                
//                if let value = response.result.value{
//                    completionHandler(response: HTTPResponse.Success, value: value, statusCode: statusCode)
//                }else{
//                    completionHandler(response: HTTPResponse.SomethingWrong, value:response.result.value , statusCode: statusCode)
//                }
//                
//        }

    }
    

}
