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
        
    }
    
    struct Font
    {
        static let Verdana = "Verdana"
    }
    
    struct Storyboard {
        static let Main = "Main"
        static let Home = "Home"
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
        static let Base            = "http://dkbmed.freeiz.com/"
        static let BaseAPI         = Base + "api/"
        static let Login           = BaseAPI + "login?"
        static let Register        = BaseAPI + "register?"
        static let Specialty       = BaseAPI + "specialties"
        static let Profession      = BaseAPI + "professions"
        //static let Articles        = BaseAPI + "articles"
        static let Articles        = BaseAPI + "article/user/id/"
        static let ProgressInfo    = BaseAPI + "article/progress/set-progress-info"
        static let Thumb           = Base + "article_thumbs/"
        static let KeywordSearch   = BaseAPI + "article/search/keywords"
        static let TitleSearch     = BaseAPI + "article/search/title"
        static let Categories      = BaseAPI + "category/all"
        static let ArticlesInCategory = BaseAPI + "article/search/category"
        static let LastSevenDaysArticle = BaseAPI + "article/released"
        static let EmailConstant = "?email="
    }
    
    struct Login {
        static let adminEmail = "info@dkbmd.com"
    }
    
    static let OneSignalId = "a858a67d-dbf7-4f96-b661-a121ca9863b8"
}
