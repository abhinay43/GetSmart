//
//  HomeVC.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/27/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit
import Reachability

class HomeVC: UIViewController
{
    //MARK:- IBOutlet

}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension HomeVC
{
    struct Storyboard {
        static let ControllerID = "HomeVC"
    }
    
    static func instantiate() -> HomeVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Home, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! HomeVC
    }
}

//MARK:- Extension UITableViewDataSource & Delegate

//MARK:- Extension Delegate

