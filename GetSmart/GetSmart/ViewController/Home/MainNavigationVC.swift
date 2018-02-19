//
//  MainNavigationVC.swift
//  nlightn
//
//  Created by Abhinay Maurya on 01/11/16.
//  Copyright © 2016 nlightn. All rights reserved.
//

import UIKit

class MainNavigationVC: UINavigationController
{
    //MARK:- ViewCLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Public Apis

}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension MainNavigationVC
{
    struct Storyboard {
        static let ControllerID = String(describing: MainNavigationVC.self)
    }
    static func instantiate() -> MainNavigationVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Home, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! MainNavigationVC
    }
}
