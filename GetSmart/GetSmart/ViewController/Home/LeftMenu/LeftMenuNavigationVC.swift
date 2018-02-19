//
//  LeftMenuNavigationVC.swift
//  nlightn
//
//  Created by Abhinay Maurya on 01/11/16.
//  Copyright © 2016 nlightn. All rights reserved.
//


import UIKit

class LeftMenuNavigationVC: UINavigationController
{
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension LeftMenuNavigationVC
{
    struct Storyboard {
        static let ControllerID = String(describing: LeftMenuNavigationVC.self)
    }
    
    static func instantiate() -> LeftMenuNavigationVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Home, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! LeftMenuNavigationVC
    }
}
