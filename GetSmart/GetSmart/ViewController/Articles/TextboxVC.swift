//
//  TextboxVC.swift
//  GetSmart
//
//  Created by Abhinay on 22/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class TextboxVC: UIViewController
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
        tableView.dataSource = self
        tableView.delegate = self
        TextboxCell.registerNib(tableView: tableView)
        
    }
    
    fileprivate func pageAppearance (){
        // self.tableView.backgroundColor = BlackColor
    }
    
    
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension TextboxVC
{
    struct Storyboard {
        static let ControllerID = "TextboxVC"
    }
    
    static func instantiate() -> TextboxVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Article, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! TextboxVC
    }
}

extension TextboxVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextboxCell.Constant.Identifier) as! TextboxCell
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
extension TextboxVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return TextboxCell.Constant.DefaultHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = dataSource[section].label!
        return label.height(withConstrainedWidth: self.view.frame.size.width, font: UIFont.systemFont(ofSize: 15.0)) + ExtraSpaceInTableHeader
    }
}

extension TextboxVC:TextboxCellDelegate
{
    func didProvidedTheAnswer(index:Int, section:Int, answer:String)
    {
//        let dataRecord = dataSource[section]
//        dataRecord.right_answer = answer
//        
//        dataSource[section] = dataRecord
        
        self.tableView.reloadData()
    }
}

