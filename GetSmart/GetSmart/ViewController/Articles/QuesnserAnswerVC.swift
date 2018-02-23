//
//  QuesnserAnswerVC.swift
//  GetSmart
//
//  Created by Abhinay on 19/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit
import ActionSheetPicker

class QuesnserAnswerVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    //MARK:- Private vars
    fileprivate weak var pickerView = UIPickerView()
    
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
        AnswerCell.registerNib(tableView: tableView)

    }
    
    fileprivate func pageAppearance (){
        // self.tableView.backgroundColor = BlackColor
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

extension QuesnserAnswerVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let data = dataSource[indexPath.section]
        
        if data.answerProvided == ArticleContentHelper.Constant.defaultQuestionTitle{
            return AnswerCell.Constant.DefaultHeight
        }else{
            return AnswerCell.Constant.HeightWithAnswer
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.Constant.Identifier) as! AnswerCell
        cell.tag = indexPath.section
        cell.delegate = self
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
extension QuesnserAnswerVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        (cell as! AnswerCell).data = dataSource[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = dataSource[section].label!
        let height = title.height(withConstrainedWidth: self.view.frame.size.width, font: UIFont.systemFont(ofSize: 15.0)) + ExtraSpaceInTableHeader
        return height
    }
    
    
}

extension QuesnserAnswerVC:AnswerCellDelegate
{
    func didClickOnSelection(tag: Int, btnSelection: UIButton)
    {
        let records = self.dataSource[tag].childRecords
        var labels = [String]()
        
        for record in records!{
            labels.append(record.label)
        }
        
        ActionSheetStringPicker.show(withTitle: "Select option", rows: labels, initialSelection: 0, doneBlock: {[weak self]
            picker, value, index in
            
            self?.dataSource[tag].answerProvided = index as! String
            self?.tableView.reloadData()
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: btnSelection)
        
    }
}
