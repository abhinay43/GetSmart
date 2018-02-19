//
//  RegistrationVC.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 7/25/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import UIKit
import DropDown

protocol RegistrationDelegate:class {
    func userAlredayRegistered(email:String)
}


class RegistrationVC: UIViewController
{

    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtMail: UITextField!
    @IBOutlet fileprivate weak var txtFirstName: UITextField!
    @IBOutlet fileprivate weak var txtLastName: UITextField!
    @IBOutlet fileprivate weak var btnSpecialty:UIButton!
    @IBOutlet fileprivate weak var btnProfession:UIButton!
    @IBOutlet fileprivate weak var lblEjournal: UILabel!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    
    //MARK:- Private 
    fileprivate var specialties = SpecialtiesHelper.sharedInstance.dataSource
    fileprivate var professions = ProfessionHelper.sharedInstance.dataSource
    fileprivate var dropDownSpecialties = DropDown()
    fileprivate var dropDownProfessions = DropDown()
    fileprivate var selectedSpeciltyId:String?
    fileprivate var selectedProfessionId:String?
    
    //MARK:- Public
    weak var delegate:RegistrationDelegate?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
        self.pageAppearance()
        // Do any additional setup after loading the view.
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
        
        //Add image on Top Bar
        let image  = UIImage(named: "navLogo")
        let imageView = UIImageView(image: image)
        self.navigationItem.titleView = imageView
        
        txtMail.delegate = self
        txtLastName.delegate = self
        txtFirstName.delegate = self
        
        dropDownSpecialties.anchorView = btnSpecialty
        
        dropDownSpecialties.bottomOffset = CGPoint(x: 0, y:(dropDownSpecialties.anchorView?.plainView.bounds.height)!)

        dropDownSpecialties.selectionAction = { [weak self] (index: Int, item: String) in
            self?.btnSpecialty.setTitle(item, for: .normal)
            self?.selectedSpeciltyId = self?.specialties[index].id
        }
        
        dropDownProfessions.anchorView = btnProfession
        dropDownProfessions.bottomOffset = CGPoint(x: 0, y:(dropDownProfessions.anchorView?.plainView.bounds.height)!)

        dropDownProfessions.selectionAction = { [weak self] (index: Int, item: String) in
            self?.btnProfession.setTitle(item, for: .normal)
            self?.selectedProfessionId = self?.professions[index].id
        }


       
    }
    
    fileprivate func pageAppearance()
    {
        let longString = lblEjournal.text!
        let eWord = "e"
        let longestWordRange = (longString as NSString).range(of: eWord)
        let attributedString = NSMutableAttributedString(string: longString)
        attributedString.setAttributes([NSAttributedStringKey.font : UIFont(name: "Verdana-Italic", size: 41) ?? UIFont.systemFont(ofSize: 41.0)], range: longestWordRange)
        lblEjournal.attributedText = attributedString
    }
    
    fileprivate func getAllProfessions()
    {
        self.showLoadIndicator(title: "Wait..")
        ProfessionHelper.sharedInstance.getProfessions(completionHandler: {[weak self] (status) in
            self?.hideLoadIndicator()
            if status{
                self?.professions = ProfessionHelper.sharedInstance.dataSource

                var allProfessionsText = [String]()
                for index in 0..<(self?.professions.count)!{
                    let professionName = self?.professions[index].title
                    allProfessionsText.append(professionName!)
                }

                self?.dropDownProfessions.dataSource = allProfessionsText
            }
        })
    }
    
    fileprivate func getAllSpecialties()
    {
        self.showLoadIndicator(title: "Wait..")
        SpecialtiesHelper.sharedInstance.getSpecialties(completionHandler: {[weak self] (status) in
            self?.hideLoadIndicator()
            if status{
                self?.specialties = SpecialtiesHelper.sharedInstance.dataSource

                var allSpecialtiesText = [String]()
                for index in 0..<(self?.specialties.count)!{
                    let specialtyName = self?.specialties[index].title
                    allSpecialtiesText.append(specialtyName!)
                }

                self?.dropDownSpecialties.dataSource = allSpecialtiesText

            }
        })
        
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
    
    @IBAction func didClickOnSelectProfession(_ sender: Any) {
        
        if professions.count == 0{
            self.getAllProfessions()
        }else{
            dropDownProfessions.show()
        }
//        
    }
    
    @IBAction func didClickOnSelectSpecialty(_ sender: Any) {
        if specialties.count == 0{
            self.getAllSpecialties()
        }else{
            dropDownSpecialties.show()
        }
    }
    
    
    @IBAction func didClickOnRegistration(_ sender: UIButton)
    {
        if txtMail.text?.characters.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the email id.")
            return
        }
        
        if self.checkEmailValidation() == false{
            return
        }
        
        if txtFirstName.text?.characters.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the first name.")
            return
        }
        
        if txtLastName.text?.characters.count == 0{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the last name.")
            return
        }
        
        if selectedSpeciltyId == nil{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the profession id.")
            return
        }
        
        if selectedProfessionId == nil{
            self.showAlert(title: GetSmartConstant.Alert.Ooooops, message: "Provide the specialities id.")
            return
        }
        
        self.showLoadIndicator(title: "Processing..")
        RegistrationHelper.registrationWithMailID(mail: txtMail.text!, firstName: txtFirstName.text!, lastName: txtLastName.text!, professionID: "\(selectedProfessionId!)", specialitiesID: "\(selectedSpeciltyId!)") {[weak self] (status, message) in
            self?.hideLoadIndicator()
            if status{
                self?.switchToStoryboard(name: GetSmartConstant.Storyboard.Home)
            }else{
                if message == "User Already Registered."{
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
