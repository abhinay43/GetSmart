//
//  UIViewController+MBProgressHud.swift
//  LiqudeHire
//
//  Created by Abhinay on 16/03/16.
//  Copyright © 2016 nlightn. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController
{
    func showLoadIndicator(title text:String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = text
    }
    
    func hideLoadIndicator(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showAlert(title titleText:String, message messageText:String)
    {
        let alert = UIAlertController (title:titleText, message: messageText, preferredStyle: .alert)
        let okAction = UIAlertAction (title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertWithOk(title alertTitle:String, message alertMessage:String, completionHandler:@escaping AlertCompletionHandler )
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completionHandler(true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    typealias AlertCompletionHandler = (_ okClicked:Bool) -> Void
}
