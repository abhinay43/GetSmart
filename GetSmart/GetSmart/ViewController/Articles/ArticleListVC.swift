//
//  ArticleListVC.swift
//  GetSmart
//
//  Created by Abhinay on 20/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class ArticleListVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    //MARK:- Private vars
    fileprivate var dataSource = ArticleListHelper.sharedInstance.dataSource
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Apis
    fileprivate func initialSetting()
    {
        tableView.delegate = self
        tableView.dataSource = self
        ArticleCategoryCell.registerNib(tableView: tableView)
        
        self.loadDataSource()
    }
    
    fileprivate func pageAppearance (){
        // self.tableView.backgroundColor = BlackColor
    }
    
    fileprivate func loadDataSource()
    {
        if dataSource.count == 0{
            self.showLoadIndicator(title: "Wait..")
            ArticleListHelper.sharedInstance.getDataSourceFromServer(completionHandler: {[weak self] (status) in
                
                if status{
                    
                    self?.dataSource = ArticleListHelper.sharedInstance.dataSource
                    self?.tableView.reloadData()
                }
                self?.hideLoadIndicator()
            })
        }
    }
    
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension ArticleListVC
{
    struct Storyboard {
        static let ControllerID = "ArticleListVC"
    }
    
    static func instantiate() -> ArticleListVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! ArticleListVC
    }
}

extension ArticleListVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return ArticleCategoryCell.Constant.DefaultHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCategoryCell.Constant.Identifier) as! ArticleCategoryCell
        return cell
        
    }
}

//MARK:- Extension Delegate
extension ArticleListVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        (cell as! ArticleCategoryCell).data = dataSource[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}