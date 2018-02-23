//
//  AnswerCell.swift
//  GetSmart
//
//  Created by Abhinay on 19/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

protocol AnswerCellDelegate:class {
    func didClickOnSelection(tag:Int, btnSelection:UIButton)
}

class AnswerCell: UITableViewCell
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var btnSelectOption: UIButton!
    @IBOutlet fileprivate weak var lblAnswerResult: UILabel!
    @IBOutlet fileprivate weak var imgAnswerResult: UIImageView!
    @IBOutlet fileprivate weak var lblSeperator: UIView!
    
    //MARK:- Public Var
    var data:DataRecord!{
        didSet{
            self.btnSelectOption.setTitle(data.answerProvided, for: .normal)
            
            if data.answerProvided == ArticleContentHelper.Constant.defaultQuestionTitle{
                self.lblAnswerResult.isHidden = true
                self.imgAnswerResult.isHidden = true
            }else{
                self.lblAnswerResult.isHidden = false
                self.imgAnswerResult.isHidden = false
                
                if data.answerProvided != data.right_answer{
                    imgAnswerResult.image = UIImage(named:"exclamation")
                    self.lblAnswerResult.text = "Incorrect"
                }else{
                    imgAnswerResult.image = UIImage(named:"check-alt")
                    self.lblAnswerResult.text = "Correct"
                }
            }
        }
    }
    
    var delegate:AnswerCellDelegate!
    
    //MARK:- Private Var
    
    //MARK:-
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.lblSeperator.backgroundColor = ArticleListHelper.sharedInstance.selectedColor
    }
    
    //MARK:- IBAction
    @IBAction func didClickOnSelection()
    {
        self.delegate.didClickOnSelection(tag: self.tag, btnSelection: self.btnSelectOption)
    }

}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension AnswerCell
{
    struct Constant {
        static let Identifier = "AnswerCell"
        static let DefaultHeight:CGFloat = 50.0
        static let HeightWithAnswer:CGFloat = 70.0
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
    static func registerClass(tableView:UITableView){
        tableView.register(AnswerCell.self, forCellReuseIdentifier: Constant.Identifier)
    }
    
}
