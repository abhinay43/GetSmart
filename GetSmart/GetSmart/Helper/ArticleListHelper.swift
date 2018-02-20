//
//  ArticleListHelper.swift
//  GetSmart
//
//  Created by Abhinay on 20/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

struct ArticleListRecord {
    let id:Int!
    let title:String!
    let created_at:String!
    let updated_at:String!
    var color = Gray
    
    init(dict:[String:Any])
    {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as! String
        self.created_at = dict["created_at"] as! String
        self.updated_at = dict["updated_at"] as! String
        self.color = UIColor.random()
    }
}

final class ArticleListHelper
{
    typealias ArticleCompletionHandler = (_ requestSuccess:Bool) -> ()
    
    static let sharedInstance = ArticleListHelper()
    
    //MARK:- Public Var
    var dataSource:[ArticleListRecord]{
        get{
            return self.ArticleListRecords
        }
    }
    
    //MARK:- Private Var
    fileprivate var ArticleListRecords = [ArticleListRecord]()
}

extension ArticleListHelper
{
    func getDataSourceFromServer(completionHandler:@escaping ArticleCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.ArticleList
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: nil, encoding: .URL) {[weak self] (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                if let records = value as? [[String:Any]]
                {
                    self?.ArticleListRecords.removeAll()
                    for record in records
                    {
                        let articleListRecord = ArticleListRecord(dict: record)
                        self?.ArticleListRecords.append(articleListRecord)
                    }
                    completionHandler(true)
                }
                break
            case .SomethingWrong:
                completionHandler(false)
                break
            }
        }
    }
}
