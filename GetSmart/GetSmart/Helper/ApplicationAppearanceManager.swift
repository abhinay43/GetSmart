//
//  ApplicationAppearanceManager.swift
//
//  Created by Abhinay Maurya on 16/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

final class ApplicationAppearanceManager
{
    static func appLoadingAppearance()
    {
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.contentViewOpacity = 0.25
        SlideMenuOptions.hideStatusBar = false
        
        UINavigationBar.appearance().tintColor = BlackColor
        UINavigationBar.appearance().barTintColor = GetSmartConstant.Color.GrayColor
     //   UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 27),NSForegroundColorAttributeName:WhiteColor]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "verdana", size: 28) ?? UIFont.systemFont(ofSize: 31),NSAttributedStringKey.foregroundColor:GetSmartConstant.Color.BlueColor]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17),NSAttributedStringKey.foregroundColor:DarkGray], for: .normal)
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: WhiteColor], for: .selected)
        UITabBar.appearance().backgroundColor = BlackColor
        UITabBar.appearance().tintColor = WhiteColor
    }
    
    
    
}
