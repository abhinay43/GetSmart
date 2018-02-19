//
//  LeftMenuVC.swift
//
//  Created by Abhinay Maurya on 01/11/16.
//  Copyright © 2016 nlightn. All rights reserved.
//


import UIKit

class LeftMenuVC: UIViewController
{
    //MARK:- Stored Properties
    fileprivate lazy var dataSource = LeftMenuHelper.dataSource
    fileprivate var homeVC:HomeVC!
    
    fileprivate lazy var aboutVC = AboutVC.instantiate()
    
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {

    }
    
    //MARK:- Private Apis
    fileprivate func initialSetting()
    {
        tableView.delegate = self
        tableView.dataSource = self
        homeVC = (self.slideMenuController()?.mainViewController as? MainNavigationVC)?.viewControllers[0] as! HomeVC
    }
    
    fileprivate func pageAppearance (){
       // self.tableView.backgroundColor = BlackColor
    }
    
    fileprivate func changeViewControllerAccordingToSelection(_ menu: Menu)
    {
        guard let mainNavigationVC = self.slideMenuController()?.mainViewController as? MainNavigationVC else{
            return
        }
        
        switch menu
        {
            case .Article:
                 mainNavigationVC.viewControllers = [homeVC]
            
            case .About:
                mainNavigationVC.viewControllers = [self.aboutVC]
            
//            case .Faculty:
//                mainNavigationVC.viewControllers = [self.facultyVC]
//                break
            
        }
    }

    fileprivate func switchToStoryboard(name: String)
    {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        let controller = storyboard.instantiateInitialViewController()
        let vindow = UIApplication.shared.windows.first
        
        if let mainVindow = vindow {
            UIView.transition(with: mainVindow, duration: 0.3, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                mainVindow.rootViewController = controller
                }, completion: nil)
        }
    }


    //MARK:- IBAction
    @IBAction fileprivate func logOut(){
        UserHelper.logout()
        self.switchToStoryboard(name: GetSmartConstant.Storyboard.Main)
    }

 }



/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension LeftMenuVC
{
    struct Storyboard{
        static let ControllerID = String(describing: LeftMenuVC.self)
    }
    
    static func instantiate() -> LeftMenuVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Home, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! LeftMenuVC
    }
}

//MARK:- Extension UITableViewDataSource & Delegate
extension LeftMenuVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.Constant.Identifier) as! MenuCell
        return cell
    }

}

//MARK:- Extension Delegate
extension LeftMenuVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let leftSection = dataSource[indexPath.row]
        (cell as! MenuCell).setData(leftSection)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        self.slideMenuController()?.closeLeft()
        changeViewControllerAccordingToSelection(Menu(rawValue: indexPath.row)!)
    }

}


