//
//  LoginNavVC.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/25/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit

class LoginNavVC: UINavigationController
{
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension LoginNavVC
{
    struct Storyboard {
        static let ControllerID = "LoginNavVC"
    }
    
    static func instantiate() -> LoginNavVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! LoginNavVC
    }
}

