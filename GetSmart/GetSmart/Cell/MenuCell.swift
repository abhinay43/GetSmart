//
//  MenuCell.swift
//  nlightn
//
//  Created by Abhinay Maurya on 01/11/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

open class MenuCell : UITableViewCell
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var lblTitle:UILabel!
    @IBOutlet fileprivate weak var menuImageView: UIImageView!
    
    //MARK:- Private Vars
    fileprivate var name:String!
    fileprivate var imgName:String!
    
    //MARK:-
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
    }
    
    open func setup() {
    }
    

    
    func setData(_ data: LeftSection){
        self.name = data.title
        self.imgName = data.imageName
        
        self.lblTitle.text = self.name
        self.menuImageView.image = UIImage(named: data.imageName)
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
    
}

/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension MenuCell
{
    struct Constant {
        static let Identifier = "MenuCell"
        static let Height = 48.0
    }
    
}
