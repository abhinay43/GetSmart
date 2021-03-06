//
//  LoginVC.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/25/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit

class LoginVC: UIViewController
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtEmail: UITextField!    
    @IBOutlet fileprivate weak var txtPassword: UITextField!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageAppearance()
        self.initialSetting()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    fileprivate func pageAppearance(){
        self.view.backgroundColor = GetSmartConstant.Color.GrayColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    fileprivate func initialSetting()
    {
        txtEmail.text = "speak2pearl@gmail.com"
        txtPassword.text = "test123"
        
        txtEmail.delegate = self
    }
    
    fileprivate func checkEmailValidation() -> Bool
    {
        guard let emailText = txtEmail.text else{
            return false
        }
        
        if emailText.count > 0{
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValid = emailTest.evaluate(with: emailText)
            
            if isValid == false{
                self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provided email id is not valid")
                txtEmail.text = ""
                return false
            }
            return true
        }
        return false
    }
    
    fileprivate func switchToStoryboard(name: String)
    {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        let controller = storyboard.instantiateInitialViewController()
        let vindow = UIApplication.shared.windows.first
        
        if let mainVindow = vindow {
            UIView.transition(with: mainVindow, duration: 0.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                mainVindow.rootViewController = controller
            }, completion: nil)
        }
    }
    
    //MARK:- IBAction
    @IBAction func didClickOnLogin(_ sender: UIButton)
    {
        
        if txtEmail.text?.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the email id.")
            return
        }
        if txtPassword.text?.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the password .")
            return
        }
        
        if self.checkEmailValidation() == false{
            return
        }
        
        self.showLoadIndicator(title: "Processing..")
        
        if (txtEmail.text?.count)! > 0{
            LoginHelper.loginWithMailID(mail: txtEmail.text!, password:txtPassword.text!, completionHandler: {[weak self] (status, message) in
                self?.hideLoadIndicator()
                if status{
                    UserHelper.rememberUserLogin(value: true)//Remember Login
                    //Add reminder notification after 2 weeks
                    self?.switchToStoryboard(name: GetSmartConstant.Storyboard.Article)
                }else{
                  self?.showAlert(title: GetSmartConstant.Alert.Error, message: message)
                }
            })
        }
    }
    
    
    //MARK:- Other
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RegistrationVC.Storyboard.SegueID{
            let vc = segue.destination as! RegistrationVC
            vc.delegate = self
        }
    }

}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension LoginVC
{
    struct Storyboard {
        static let ControllerID = "LoginVC"
        static let SegueID = "LoginSegue"
    }
    
    static func instantiate() -> LoginVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! LoginVC
    }
}

extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginVC:RegistrationDelegate{
    func userAlredayRegistered(email: String) {
        self.txtEmail.text = email
    }
}

