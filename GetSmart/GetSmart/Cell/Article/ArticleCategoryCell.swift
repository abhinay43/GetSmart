//
//  ArticleCategoryCell.swift
//  GetSmart
//
//  Created by Abhinay on 20/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class ArticleCategoryCell: UITableViewCell
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var viewIndex: UIView!
    @IBOutlet fileprivate weak var lblIndex: UILabel!
    @IBOutlet fileprivate weak var txtTitle: UILabel!
    
    //MARK:- View Life Cycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.viewIndex.drawBorder(cornerRadius: 75.0/2, borderWidth: 2.0, borderColor: WhiteColor, maskToBound: true)
    }

    //MARK:- Public Var
    var data:ArticleListRecord!{
        didSet{
            self.txtTitle.text = data.title
            self.lblIndex.text = "\(self.tag)"
            self.backgroundColor = data.color
        }
    }
    
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension ArticleCategoryCell
{
    struct Constant {
        static let Identifier = "ArticleCategoryCell"
        static let DefaultHeight:CGFloat = 115.0
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
}
