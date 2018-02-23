//
//  ArticleInfoContainerVC.swift
//  GetSmart
//
//  Created by Abhinay on 20/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit
import GTProgressBar

class ArticleInfoContainerVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var viewHeader: UIView!
    @IBOutlet fileprivate weak var heightLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var progressBar: GTProgressBar!
    @IBOutlet fileprivate weak var btnRightArrow: UIButton!
    @IBOutlet fileprivate weak var btnLeftArrow: UIButton!
    
    //MARK:- Private vars
    fileprivate var dataSource = ArticleContentHelper.sharedInstance.dataSource
    fileprivate var pageColor = GetSmartConstant.Color.LightGreenColor
    //MARK:- Public vars
    var index = 0
    var articleListIndex = 0{
        didSet{
           self.pageColor = ArticleListHelper.sharedInstance.dataSource[articleListIndex].color
        }
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
        self.pageAppearance()
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
        progressBar.progress = 0
    }
    
    fileprivate func pageAppearance ()
    {
        let height = ArticleInfoContainerVC.space + lblTitle.bounds.size.height
        heightLayoutConstraint.constant = height
        
        progressBar.barFillColor = pageColor
        progressBar.labelTextColor = pageColor
        btnRightArrow.tintColor = pageColor
        viewHeader.backgroundColor = pageColor
        
        btnRightArrow.tintColor = pageColor
        btnLeftArrow.tintColor = pageColor
    }
    
    
    
    //MARK:- IBAction
    @IBAction func didClickOnRightArrow(_ sender: Any)
    {
        let dataSource = ArticleContentHelper.sharedInstance.dataSource
        if index == dataSource.count - 1{
            return
        }
        index += 1
        let notificationName = Notification.Name(NotificationName.HomePageSelectionChange)
        NotificationCenter.default.post(name: notificationName, object: index)
        self.changePageSelection(index: index)
    }
    
    @IBAction func didClickOnLeftArrow(_ sender: Any) {
        if index == 0{
            return
        }
        index -= 1
        let notificationName = Notification.Name(NotificationName.HomePageSelectionChange)
        NotificationCenter.default.post(name: notificationName, object: index)
        
        self.changePageSelection(index: index)
    }
    
    //MARK:- Other
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == ArticleInfoPageVC.Storyboard.SegueID{
            let vc = segue.destination as! ArticleInfoPageVC
            vc.pageDelegate = self
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
    
    struct NotificationName {
        static let HomePageSelectionChange = "HomePageSelectionChange"
    }
    
    static let space:CGFloat = 75.0
    
    static func instantiate() -> ArticleInfoContainerVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! ArticleInfoContainerVC
    }
}

extension ArticleInfoContainerVC:ArticleInfoPageVCDelegate
{
    func changePageSelection(index:Int)
    {
        self.index = index
        
        let dataSource = ArticleContentHelper.sharedInstance.dataSource
        let progress = CGFloat(index + 1) / CGFloat(dataSource.count)
        progressBar.progress = progress
        let title = dataSource[index].pageContent.page_title
        lblTitle.text = title
    }
}


