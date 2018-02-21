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
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dataRecord = dataSource[section]
        return dataRecord.label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextboxCell.Constant.Identifier) as! TextboxCell
        cell.tag = indexPath.row
        cell.delegate = self
        cell.section = indexPath.section
        return cell
        
    }
}
extension TextboxVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return TextboxCell.Constant.DefaultHeight
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

