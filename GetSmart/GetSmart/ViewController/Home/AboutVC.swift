//
//  AboutVC.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/29/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit

class AboutVC: UIViewController
{

    //MARK:-IBOutlet
    @IBOutlet fileprivate weak var webView: UIWebView!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:-Private Var
    fileprivate var isFirstTime = true
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageAppearance()
        self.initialSetting()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //ScrollHTMLHelper.setCurrentOffsetYForFile(htmlFile: "newsstandAbout", yOffset: Double(webView.scrollView.contentOffset.y))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:-
    fileprivate func pageAppearance(){
        self.title = "About"
    }
    
    fileprivate func initialSetting()
    {
        webView.delegate = self
        webView.scalesPageToFit = true
        
        let htmlFile = Bundle.main.path(forResource: "newsstandAbout", ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        webView.loadHTMLString(html!, baseURL: nil)
        
    }
    
    fileprivate func setPageToPreviousYOffset(){
//        let yDouble = ScrollHTMLHelper.getCurrentOffsetYForFile(htmlFile: "newsstandAbout")
//        let point = CGPoint(x: webView.scrollView.contentOffset.x, y: CGFloat(yDouble))
//        webView.scrollView.setContentOffset(point, animated: true)
    }
    
    //MARK:- IBAction
    @IBAction func openLeftMenu(){
        self.slideMenuController()?.openLeft()
    }
    
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension AboutVC
{
    struct Storyboard {
        static let ControllerID = "AboutVC"
    }
    
    static func instantiate() -> AboutVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Home, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! AboutVC
    }
}

extension AboutVC:UIWebViewDelegate
{
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityIndicator.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator.stopAnimating()
        if isFirstTime{
            isFirstTime = false
            setPageToPreviousYOffset()
        }
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityIndicator.stopAnimating()
    }
}



