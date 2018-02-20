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
    fileprivate var dataSource = QuesnserAnswerHelper.sharedInstance.dataSource
    fileprivate weak var pickerView = UIPickerView()

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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let data = dataSource![indexPath.row]
        if data.answerProvided == QuesnserAnswerHelper.Constant.defaultQuestionTitle{
            return AnswerCell.Constant.DefaultHeight
        }else{
            return AnswerCell.Constant.HeightWithAnswer
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.Constant.Identifier) as! AnswerCell
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
        
    }
}

//MARK:- Extension Delegate
extension QuesnserAnswerVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        (cell as! AnswerCell).data = dataSource![indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension QuesnserAnswerVC:AnswerCellDelegate
{
    func didClickOnSelection(tag: Int, btnSelection: UIButton)
    {
        let records = self.dataSource![tag].answers
        
        ActionSheetStringPicker.show(withTitle: "Select option", rows: records, initialSelection: 0, doneBlock: {[weak self]
            picker, value, index in
            
            self?.dataSource![tag].answerProvided = index as! String
            self?.tableView.reloadData()
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: btnSelection)
        
    }
}
