//
//  GeneralManager.swift
//  VSearch
//
//  Created by Abhinay Maurya on 06/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

final class GeneralManager
{
    static let sharedInstance = GeneralManager()
    
    static func applicationInitialSetUp()
    {
        //#1
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside =  true
        IQKeyboardManager.sharedManager().placeholderFont = UIFont(name: GetSmartConstant.Font.Verdana, size: 15.0)
        IQKeyboardManager.sharedManager().previousNextDisplayMode = .alwaysHide
            
        //By default load Specialties and Profession
     //   SpecialtiesHelper.sharedInstance.getSpecialties(completionHandler: { (status) in
            //
      //  })
     //   ProfessionHelper.sharedInstance.getProfessions(completionHandler: { (status) in
            //
     //   })
        
    }
    
    }
