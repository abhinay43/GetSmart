//
//  WebVC.swift
//  GetSmart
//
//  Created by Abhinay on 22/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController
{
    //MARK:- Private vars
    fileprivate var webView : WKWebView!
    
    //MARK:- Public vars
    var dataSource:PageContent!

    //MARK:- View Life Cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        self.initialSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Private Apis
    fileprivate func initialSetting()
    {
        // init and load request in webview.
        var rect = self.view.frame
        rect.size.height -= TabbarSize + 125.0
        
        webView = WKWebView(frame: rect)
        webView.navigationDelegate = self
        
        let html_content_string = dataSource.page_content!.html2String
        let metaData = GetSmartConstant.HTML.FormatForWKWebviewToFullScreen
        let htmlString = metaData + html_content_string
        
        webView.loadHTMLString(htmlString, baseURL: nil)
        self.view.addSubview(webView)
    }
    
    fileprivate func pageAppearance (){
    }

}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension WebVC
{
    struct Storyboard {
        static let ControllerID = "WebVC"
    }
    
    static func instantiate() -> WebVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! WebVC
    }
}

extension WebVC:WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("finish to load")
    }
}

