//
//  ArticleInfoContainerVC.swift
//  GetSmart
//
//  Created by Abhinay on 20/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class ArticleInfoContainerVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var viewHeader: UIView!
    @IBOutlet fileprivate weak var heightLayoutConstraint: NSLayoutConstraint!
    
    //MARK:- Private vars
    fileprivate var dataSource = ArticleListHelper.sharedInstance.dataSource
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pageAppearance()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Apis
    fileprivate func initialSetting()
    {
        
    }
    
    fileprivate func pageAppearance (){
        let height = ArticleInfoContainerVC.space + lblTitle.bounds.size.height
        heightLayoutConstraint.constant = height
    }
    
    

}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension ArticleInfoContainerVC
{
    struct Storyboard {
        static let ControllerID = "ArticleInfoContainerVC"
        static let SegueID = "ArticleInfoContainerSegue"
    }
    
    static let space:CGFloat = 75.0
    
    static func instantiate() -> ArticleInfoContainerVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! ArticleInfoContainerVC
    }
}
