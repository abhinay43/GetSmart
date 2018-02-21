//
//  TextboxCell.swift
//  GetSmart
//
//  Created by Abhinay on 22/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

protocol TextboxCellDelegate:class {
    func didProvidedTheAnswer(index:Int, section:Int, answer:String)
}

class TextboxCell: UITableViewCell
{
    //MARK:-
    @IBOutlet fileprivate weak var txtfield: UITextField!
    
    //MARK:- Public Var
    var section = 0
    
    var delegate:TextboxCellDelegate!
    
    //MARK:- Private Var
    
    //MARK:-
    override func awakeFromNib(){
        super.awakeFromNib()
        txtfield.delegate = self
    }
    
    //MARK:- IBAction
    
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension TextboxCell
{
    struct Constant {
        static let Identifier = "TextboxCell"
        static let DefaultHeight:CGFloat = 44.0
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
}

extension TextboxCell:UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField.text != "" {
            let trimmedString = textField.text!.trimmingCharacters(in: .whitespaces)
            if trimmedString != ""{
                self.delegate.didProvidedTheAnswer(index: self.tag, section:section, answer:trimmedString)
            }
        }
    }
}

