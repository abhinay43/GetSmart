//
//  ArticleCell.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/28/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit
import Kingfisher
import UICircularProgressRing

class ArticleCell: UITableViewCell
{

    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var lblDescription: UILabel!
    @IBOutlet fileprivate weak var imgArticle: UIImageView!
    @IBOutlet fileprivate weak var activityIndicator:   UIActivityIndicatorView!
    
    
    //MARK:- Public Vars
    
    
    
    //MARK:- View Life Cycle
    
    //MARK:-
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK:- Private Methods
    
    //MARK:- Public Methods
    
    
}


/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension ArticleCell
{
    struct Constant {
        static let Identifier = String(describing: ArticleCell.self)
        static let Height:CGFloat = 100.0
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
}





