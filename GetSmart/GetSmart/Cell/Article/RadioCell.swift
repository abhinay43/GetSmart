//
//  RadioCell.swift
//  GetSmart
//
//  Created by Abhinay on 21/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

protocol RadioCellDelegate:class {
    func didSelectRadioOptioFor(index:Int, section:Int)
}

class RadioCell: UITableViewCell
{
    //MARK:-
    @IBOutlet fileprivate weak var lbltitle: UILabel!
    @IBOutlet fileprivate weak var btnRadio: UIButton!
    
    //MARK:- Public Var
    var data:DataChild!{
        didSet{
            self.lbltitle.text = data.label
            let image = data.answerProvided ? UIImage(named: "radioSelect") : UIImage(named: "radioUnselect")
            self.btnRadio.setBackgroundImage(image, for: .normal)
        }
    }
    var section = 0
    
    var delegate:RadioCellDelegate!
    
    //MARK:- Private Var
    
    //MARK:-
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    //MARK:- IBAction
    @IBAction func didClickOnSelection(){
        self.delegate.didSelectRadioOptioFor(index: self.tag, section:section)
    }
}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension RadioCell
{
    struct Constant {
        static let Identifier = "RadioCell"
        static let DefaultHeight:CGFloat = 40.0
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
}

