//
//  SideMenuContainerVC.swift
//  nlightn
//
//  Created by Abhinay Maurya on 01/11/16.
//  Copyright © 2016 nlightn. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class SideMenuContainerVC: SlideMenuController
{
    //MARK:- View Life Cycle
    override func awakeFromNib()
    {
        mainViewController = MainNavigationVC.instantiate()
        leftViewController = LeftMenuNavigationVC.instantiate()
        
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension SideMenuContainerVC
{
    struct Storyboard {
        static let ControllerID = "SideMenuContainerVC"
    }
    
    static func instantiate() -> SideMenuContainerVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Home, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! SideMenuContainerVC
    }
}

