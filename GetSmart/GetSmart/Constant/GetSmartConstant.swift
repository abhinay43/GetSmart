//
//  GetSmartConstant.swift
//  GetSmart
//
//  Created by Abhinay on 12/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

struct GetSmartConstant
{
    static let AppName = "Get Smart"
    
    struct Color {
        static let RedColor = UIColor(red: 234.0/255.0, green: 109.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        static let SkyColor = UIColor(red: 130.0/255.0, green: 177.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        static let GrayColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        static let BlueColor = UIColor(red: 17.0/255.0, green: 33.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        static let GreenColor = UIColor(red: 76.0/255.0, green: 175.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        static let LightGreenColor = UIColor(red: 201.0/255.0, green: 222.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        
    }
    
    struct Font
    {
        static let Verdana = "Verdana"
    }
    
    struct Storyboard {
        static let Main = "Main"
        static let Article = "Article"
    }
    
    struct Alert {
        static let Success = "Success!!"
        static let Error = "Error!!"
        static let Fail = "Failed!!"
        static let Warning = "Warning!!"
        static let Wait = "Please wait!!"
        static let Ooooops = "Ooooops!!"
        static let SomethingWentWrong = "Something went wrong!!"
        static let InternetNotComing = "The internet connection appears to be offline. You will need internet connection to access some links and videos"
    }
    
    struct Notification {
        
    }
    
    struct Image {
        static let CompressQuality:CGFloat = 0.40
    }
    
    struct API {
        static let Base            = "https://dkbsmart-raviweb.c9users.io/"
        static let BaseAPI         = Base + "api/"
        static let Login           = BaseAPI + "login?"
        static let Register        = BaseAPI + "register?"
        static let ArticleList     = BaseAPI + "articlelist"
        static let ArticleContent  = BaseAPI + "pages?article_id=1"
        static let Resources       = BaseAPI + "resources"
        static let Progress        = BaseAPI + "progress"
    }
    
    struct Login {
        static let adminEmail = "info@dkbmd.com"
    }
    
    struct HTML {
        static let FormatForWKWebviewToFullScreen = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
    }
    
    static let OneSignalId = "a858a67d-dbf7-4f96-b661-a121ca9863b8"
}

let TabbarSize:CGFloat = 50.0
let ExtraSpaceInTableHeader:CGFloat = 20.0
