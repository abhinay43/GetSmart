//
//  UIView+Utility.swift
//  Interview
//
//  Created by Abhinay Maurya on 10/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit


extension UIView
{
    func drawBorder(cornerRadius cr:CGFloat, borderWidth bw:CGFloat, borderColor bc:UIColor, maskToBound mtb:Bool){
        self.layer.cornerRadius = cr
        self.layer.borderWidth = bw
        self.layer.borderColor = bc.cgColor
        self.layer.masksToBounds = mtb
    }
    
    func drawShadow (offset ofset:CGSize, shadowRadius sr:CGFloat, cornerRadius cr:CGFloat ,shadowColor sc:UIColor, shadowOpacity so:Float, masksToBounds mb:Bool)
    {
        self.layer.shadowOffset = ofset
        self.layer.shadowRadius = sr
        self.layer.shadowColor = sc.cgColor
        self.layer.shadowOpacity = so
        self.layer.masksToBounds = mb
        self.layer.cornerRadius = cr
    }

    
    
}
