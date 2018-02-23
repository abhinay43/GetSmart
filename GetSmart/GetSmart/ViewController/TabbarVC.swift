//
//  TabbavVC.swift
//  GetSmart
//
//  Created by Abhinay on 22/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController
{
    //MARK:- Private Vars
    fileprivate let dataSource = TabbarHelper.items
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        var index = 0
        for item in self.tabBar.items!
        {
            item.title = dataSource[index].title
            item.image = UIImage(named: dataSource[index].imageName)
            index += 1
            
        }
        
        
    }
    //MARK:- Other
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension TabbarVC
{
    struct Storyboard {
        static let ControllerID = "TabbarVC"
    }
    
    static func instantiate() -> TabbarVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! TabbarVC
    }
}

