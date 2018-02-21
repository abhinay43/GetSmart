//
//  ArticleInfoPageVC.swift
//  GetSmart
//
//  Created by Abhinay on 20/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

protocol ArticleInfoPageVCDelegate {
    func changePageSelection(index:Int)
}

class ArticleInfoPageVC: UIPageViewController
{
    //MARK:- Private Vars
    fileprivate var records = ArticleContentHelper.sharedInstance.dataSource
    
    
    fileprivate lazy var weekViewControllers:[UIViewController] = { [unowned self] in
        
        var viewControllers = [UIViewController]()
        for record in self.records{
            if let type = record.type{
                if type == ArticleType.dropdown.rawValue{
                    let vc = QuesnserAnswerVC.instantiate()
                    vc.dataSource = record.data
                    viewControllers.append(vc)
                }
            }
        }
        return viewControllers
        }()
    
    
    //MARK:- Public Vars
    var pageDelegate:ArticleInfoPageVCDelegate?
    
    //MARK:- ViewC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let notificationName = Notification.Name(WeekContainerVC.NotificationName.HomePageSelectionChange)
//        NotificationCenter.default.addObserver(self, selector: #selector(WeekPageVC.openSelectedPage(_:)), name: notificationName, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        if records.count == 0
        {
            self.loadDataSource()
        }else{
            self.loadPages()
        }
    }
    
    fileprivate func loadDataSource()
    {
        self.showLoadIndicator(title: "Wait..")
        ArticleContentHelper.sharedInstance.getDataSourceFromServer(completionHandler: {[weak self] (status) in
            
            if status{
                self?.records = ArticleContentHelper.sharedInstance.dataSource
                self?.loadPages()
            }
            self?.hideLoadIndicator()
        })
    }
    
    fileprivate func loadPages()
    {
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = self.weekViewControllers.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            pageDelegate?.changePageSelection(index: 0)
        }
    }
    
    @objc fileprivate func openSelectedPage(_ notification:NSNotification)
    {
        let selectedIndex = notification.object as! Int
        let viewController = self.weekViewControllers[selectedIndex]
        if selectedIndex == 0{
            self.setViewControllers([viewController], direction: .reverse, animated: true, completion: nil)
        }
        if selectedIndex == 2{
            self.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
        }else{
            self.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
        }
        
        
    }
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension ArticleInfoPageVC
{
    struct Storyboard {
        static let ControllerID = "ArticleInfoPageVC"
        static let SegueID = "ArticleInfoPageSegue"
    }
    
}

extension ArticleInfoPageVC:UIPageViewControllerDataSource
{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = weekViewControllers.index(of: viewController as! QuesnserAnswerVC) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard weekViewControllers.count > previousIndex else {
            return nil
        }
        
        return weekViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = weekViewControllers.index(of: viewController as! QuesnserAnswerVC) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = weekViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return weekViewControllers[nextIndex]
    }
}

extension ArticleInfoPageVC:UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if let firstViewController = viewControllers!.first,
            let index = weekViewControllers.index(of: firstViewController as! QuesnserAnswerVC)
        {
            pageDelegate?.changePageSelection(index: index)
        }
    }
}


