//
//  RadioOptionVC.swift
//  GetSmart
//
//  Created by Abhinay on 21/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class RadioOptionVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    //MARK:- Public vars
    var dataSource = [DataRecord]()
    
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
        RadioCell.registerNib(tableView: tableView)
        
    }
    
    fileprivate func pageAppearance (){
        // self.tableView.backgroundColor = BlackColor
    }
    
    

}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension RadioOptionVC
{
    struct Storyboard {
        static let ControllerID = "RadioOptionVC"
    }
    
    static func instantiate() -> RadioOptionVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! RadioOptionVC
    }
}

extension RadioOptionVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let dataRecord = dataSource[section]
        return dataRecord.childRecords.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return RadioCell.Constant.DefaultHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dataRecord = dataSource[section]
        return dataRecord.label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioCell.Constant.Identifier) as! RadioCell
        cell.tag = indexPath.row
        cell.delegate = self
        cell.section = indexPath.section
        return cell
        
    }
}

//MARK:- Extension Delegate
extension RadioOptionVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        (cell as! RadioCell).data = dataSource[indexPath.section].childRecords[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension RadioOptionVC:RadioCellDelegate
{
    func didSelectRadioOptioFor(index:Int, section:Int)
    {
        let dataRecord = dataSource[section]
        var dataChilds = dataRecord.childRecords!
        
        for var i in 0..<dataChilds.count
        {
            var record = dataChilds[i]
            let flag = index == i ? true : false
            record.answerProvided = flag
            dataChilds[i] = record
        }
        dataSource[section].childRecords = dataChilds
        
        
        
        self.tableView.reloadData()
    }
}
