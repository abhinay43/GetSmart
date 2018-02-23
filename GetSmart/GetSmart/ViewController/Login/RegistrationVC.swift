//
//  RegistrationVC.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/25/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit

protocol RegistrationDelegate:class {
    func userAlredayRegistered(email:String)
}

class RegistrationVC: UIViewController
{

    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtMail: UITextField!
    @IBOutlet fileprivate weak var txtPassword: UITextField!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    
    //MARK:- Private
    
    //MARK:- Public
    weak var delegate:RegistrationDelegate?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
        self.pageAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: 400)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        txtMail.text = "speak2pearl@gmail.com"
        txtPassword.text = "test123"
        
        txtMail.delegate = self
        txtPassword.delegate = self
    }
    
    fileprivate func pageAppearance()
    {
        
    }
   
    fileprivate func checkEmailValidation() -> Bool
    {
        guard let emailText = txtMail.text else{
            return false
        }
        
        if emailText.count > 0{
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValid = emailTest.evaluate(with: emailText)
            
            if isValid == false{
                self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provided email id is not valid")
                txtMail.text = ""
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
            UIView.transition(with: mainVindow, duration: 0.3, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                mainVindow.rootViewController = controller
            }, completion: nil)
        }
    }
    
    //MARK:- IBAction
    @IBAction func didClickOnRegistration(_ sender: UIButton)
    {
        if txtMail.text?.characters.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the email id.")
            return
        }
        if txtPassword.text?.characters.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the password .")
            return
        }
        
        if self.checkEmailValidation() == false{
            return
        }
        
        self.showLoadIndicator(title: "Processing..")
        
        RegistrationHelper.registrationWithMailID(mail: txtMail.text!, password: txtPassword.text!) {[weak self] (status, message) in
            self?.hideLoadIndicator()
            if status{
                self?.switchToStoryboard(name: GetSmartConstant.Storyboard.Article)
            }else{
                if message == "Email Address is Already Registered."{
                    if let delegate = self?.delegate{
                       delegate.userAlredayRegistered(email: (self?.txtMail.text)!)
                        self?.showAlertWithOk(title: "", message: "User Already Registered", completionHandler: {[weak self] (status) in
                            let _ = self?.navigationController?.popViewController(animated: true)
                        })
                        
                    }
                }else{
                    self?.showAlert(title: GetSmartConstant.Alert.Error, message: message)
                }
                
            }
        }
        
    }

    
}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension

extension RegistrationVC
{
    struct Storyboard {
        static let ControllerID = "RegistrationVC"
        static let SegueID = "RegistrationSegue"
    }
    
    static func instantiate() -> RegistrationVC{
        let storyboard = UIStoryboard(name: GetSmartConstant.Storyboard.Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! RegistrationVC
    }
}

extension RegistrationVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
