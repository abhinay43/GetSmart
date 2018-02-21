//
//  ArticleContentHelper.swift
//  GetSmart
//
//  Created by Abhinay on 21/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import Foundation

enum ArticleType:String
{
    case dropdown, radio, textbox
}

struct ArticleContent
{
    let pageContent:PageContent!
    let type:String?
    let data:[DataRecord]!
    
    init(dict:[String:Any])
    {
        let pageContent = dict["page_content"] as! [String:Any]
        self.pageContent = PageContent(dict:pageContent)
        
        self.type = dict["type"] as? String
        
        var dataRecords = [DataRecord]()
        
        if let records = dict["data"] as? [[String:Any]]{
            for record in records{
                let dataRecord = DataRecord(dict: record)
                dataRecords.append(dataRecord)
            }
        }
        self.data = dataRecords
        
    }
}

struct PageContent
{
    let id:Int!
    let article_id:Int!
    let page_title:String!
    let page_content:String!
    let footer_text:String?
    let created_at:String!
    let updated_at:String?
    
    
    init(dict:[String:Any])
    {
        self.id = dict["id"] as! Int
        self.article_id = dict["article_id"] as! Int
        self.page_content = dict["page_content"] as! String
        self.page_title = dict["page_title"] as! String
        self.footer_text = dict["footer_text"] as? String
        self.created_at = dict["created_at"] as! String
        self.updated_at = dict["updated_at"] as? String
    }
}

struct DataRecord
{
    let id:Int?
    let right_answer:String?
    let label:String!
    var childRecords:[DataChild]!
    var answerProvided = ArticleContentHelper.Constant.defaultQuestionTitle
    
    init(dict:[String:Any])
    {
        self.id = dict["id"] as? Int
        self.label = dict["label"] as! String
        self.right_answer = dict["right_answer"] as? String
        
        var innerChildRecords = [DataChild]()
        
        if let childRecords = dict["child"] as? [[String:Any]]{
            for record in childRecords{
               let dataChild = DataChild(dict: record)
                innerChildRecords.append(dataChild)
            }
        }
        self.childRecords = innerChildRecords
    }
    
}

struct DataChild
{
    let id:Int!
    let label:String!
    var right_answer:String?
    var answerProvided = false
    
    init(dict:[String:Any])
    {
        self.id = dict["id"] as! Int
        self.label = dict["label"] as! String
        self.right_answer = dict["right_answer"] as? String
    }
}


final class ArticleContentHelper
{
    typealias ArticleContentCompletionHandler = (_ requestSuccess:Bool) -> ()
    
    static let sharedInstance = ArticleContentHelper()
    
    //MARK:- Public Var
    var dataSource:[ArticleContent]{
        get{
            return self.articleContents
        }
    }
    
    //MARK:- Private Var
    fileprivate var articleContents = [ArticleContent]()
}

extension ArticleContentHelper
{
    func getDataSourceFromServer(completionHandler:@escaping ArticleContentCompletionHandler)
    {
        let requestURL = GetSmartConstant.API.ArticleContent
        
        HTTPRequestManager.httpRequest(url: requestURL, protocolMethod: .GET, parameters: nil, encoding: .URL) {[weak self] (response, value, statusCode) in
            
            switch response
            {
            case .Success:
                if let records = value as? [[String:Any]]
                {
                    for record in records
                    {
                        let articleContentRecord = ArticleContent(dict: record)
                        self?.articleContents.append(articleContentRecord)
                    }
                    print(self?.articleContents ?? "")
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

extension ArticleContentHelper
{
    struct Constant
    {
        static let defaultQuestionTitle = "Select option"
    }
}
