//
//  ProfessionsHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/27/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation

struct Profession
{
    let id:String!
    let title:String!
    let p_description:String!
    
    
    init(profession:[String:Any])
    {
        self.id = profession["id"] as! String
        self.title = profession["title"] as! String
        self.p_description = profession["description"] as! String
    }
}


//Class
final class ProfessionHelper
{
    typealias ProfessionCompletionHandler = (_ requestSuccess:Bool) -> ()
    
    static let sharedInstance = ProfessionHelper()
    
    var dataSource:[Profession]{
        get{
            return professions
        }
    }
    
    fileprivate var professions = [Profession]()
}

extension ProfessionHelper
{
    //MARK:- API calling
    func getProfessions(completionHandler:@escaping ProfessionCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.Profession
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: nil , encoding: .URL) {[weak self] (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                
                if let records = value as? [[String:Any]]
                {
                    for profession in records{
                        let record = Profession(profession: profession)
                        self?.professions.append(record)
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
