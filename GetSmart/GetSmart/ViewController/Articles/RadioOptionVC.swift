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
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioCell.Constant.Identifier) as! RadioCell
        cell.tag = indexPath.row
        cell.delegate = self
        cell.section = indexPath.section
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let title = dataSource[section].label!
        let height = title.height(withConstrainedWidth: self.view.frame.size.width, font: UIFont.systemFont(ofSize: 15.0)) + ExtraSpaceInTableHeader
        
        let width = self.tableView.frame.size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let view = UIView(frame: rect)
        view.backgroundColor = WaterGray
        
        let labelRect = CGRect(x: 15, y: 0, width: width - 20, height: height)
        let label = UILabel(frame: labelRect)
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = DarkGray
        label.text = title
        label.numberOfLines = 10
        label.backgroundColor = ClearColor
        label.textAlignment = .left
        view.addSubview(label)
        return view
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let record = dataSource[indexPath.section].childRecords[indexPath.row]
        let height = record.label.height(withConstrainedWidth: self.view.frame.size.width, font: UIFont.boldSystemFont(ofSize: 14.0)) + 10.0
        
        let cellHeight = height < RadioCell.Constant.DefaultHeight ? RadioCell.Constant.DefaultHeight:height
        
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = dataSource[section].label!
        return label.height(withConstrainedWidth: self.view.frame.size.width, font: UIFont.systemFont(ofSize: 15.0)) + ExtraSpaceInTableHeader
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
