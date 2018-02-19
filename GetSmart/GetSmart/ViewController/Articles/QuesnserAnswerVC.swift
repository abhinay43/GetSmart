//
//  QuesnserAnswerVC.swift
//  GetSmart
//
//  Created by Abhinay on 19/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class QuesnserAnswerVC: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension QuesnserAnswerVC
{
    struct Storyboard {
        static let ControllerID = "QuesnserAnswerVC"
    }
    
    static func instantiate() -> QuesnserAnswerVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! QuesnserAnswerVC
    }
}
