//
//  SpecialtiesHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/27/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation

struct Specialty
{
    let id:String!
    let title:String!
    
    
    init(specialty:[String:Any])
    {
        self.id = specialty["id"] as! String
        self.title = specialty["title"] as! String
    }
}


//Class
final class SpecialtiesHelper
{
    typealias SpecialtiesCompletionHandler = (_ requestSuccess:Bool) -> ()
    
    static let sharedInstance = SpecialtiesHelper()
    
    var dataSource:[Specialty]{
        get{
            return specialties
        }
    }
    
    fileprivate var specialties = [Specialty]()
}

extension SpecialtiesHelper
{
    //MARK:- API calling
    func getSpecialties(completionHandler:@escaping SpecialtiesCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.Specialty
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: nil , encoding: .URL) {[weak self] (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                
                if let records = value as? [[String:Any]]
                {
                    for specialty in records{
                        let record = Specialty(specialty: specialty)
                        self?.specialties.append(record)
                    }
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
                
                break
            case .SomethingWrong:
                completionHandler(false)
                break
            }
        }
    }
    
}
