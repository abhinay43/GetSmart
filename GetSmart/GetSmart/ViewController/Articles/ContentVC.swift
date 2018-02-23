//
//  ContentVC.swift
//  GetSmart
//
//  Created by Abhinay on 22/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class ContentVC: UIViewController
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtView: UITextView!
    
    //MARK:- Public vars
    var dataSource:PageContent!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Apis
    fileprivate func initialSetting()
    {
        txtView.text = dataSource.page_content
        
    }
    
    fileprivate func pageAppearance (){
        // self.tableView.backgroundColor = BlackColor
    }
    
    
    

}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension ContentVC
{
    struct Storyboard {
        static let ControllerID = "ContentVC"
    }
    
    static func instantiate() -> ContentVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! ContentVC
    }
}
