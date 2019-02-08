//
//  BTLoginViewController.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/7/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit

class BTLoginViewController: UIViewController {
    // MARK: properties
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    let loginToMarketSegue: String =  "LoginToMarket"
    var loginViewModel: BTLoginViewModel = BTLoginViewModel()
    
    // MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureTextFields()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
    }
    func configureButtons() {
        self.signUpButton.layer.cornerRadius = self.signUpButton.frame.height/2
        self.loginButton.layer.cornerRadius = self.loginButton.frame.height/2
    }
    func configureTextFields() {
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    // MARK: UIButton Actions
    @IBAction func loginButtonClick(_ sender: Any) {
        loginWithUserDeatils()
    }
    @IBAction func signUpButtonClicked(_ sender: Any) {
        showSignupAlert()
    }
    //    // MARK: Validation Logics
    func validateUserNameAndPassword(userName: String?, password: String?) -> Bool {
        let valdiations = self.loginViewModel.validateUserNameAndPassword(userName: userName, password: password)
        if !valdiations.validEamil {
            self.showAlert(vc: self, title: "Error", message: "Please enter valid Email.")
            return valdiations.validEamil
        }
        else if !valdiations.validPassword {
            self.showAlert(vc: self, title: "Error", message: "Minimum length of password is 6.")
            return valdiations.validPassword
        }
        else {
            return valdiations.validCredentails
        }
    }
    
    // MARK: Signup AlertViewController
    func showSignupAlert() {
        let alert = UIAlertController(title: "Signup", message: "", preferredStyle: .alert)
        alert.addTextField { (userNameTextField) in
            userNameTextField.placeholder = "Enter UserName"
        }
        alert.addTextField { (passwordTextField) in
            passwordTextField.placeholder = "Enter password"
        }
        alert.addTextField { (passwordTextField) in
            passwordTextField.placeholder = "Re-enter password"
        }
        let signupButton = UIAlertAction(title: "Signup", style: .default) { (action) in
            if let username = alert.textFields?.first?.text, let password = alert.textFields?.last?.text {
                if alert.textFields?[1].text ==  alert.textFields?.last?.text {
                    if self.validateUserNameAndPassword(userName: username, password: password) {
                        self.signUpNewUser(username: username, password: password)
                    }
                }
                else{
                      self.showAlert(vc: self, title: "Error", message: "Passwords do not match")
                }
                
                
            }
        }
        let  cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(signupButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    func loginWithUserDeatils(){
        if let username = userNameTextField.text, let password = passwordTextField.text {
            if self.validateUserNameAndPassword(userName: username, password: password) {
                loginViewModel.loginWithUserDeatils(username: username, password: password) { (sucess) in
                    if sucess {
                        self.performSegue(withIdentifier: self.loginToMarketSegue, sender: self)
                    }
                    else{
                        self.showAlert(vc: self, title: "Error", message: "Invalid credentails")
                    }
                }
            }
        }
    }
    func signUpNewUser(username: String, password: String) {
        self.loginViewModel.signUpNewUser(username: username, password: password) { (sucess) in
            if sucess {
                self.performSegue(withIdentifier: self.loginToMarketSegue, sender: self)
            }
            else{
                self.showAlert(vc: self, title: "Error", message: "Unable to create user.")
            }
        }
    }
    // MARK: Error alerts
    func showAlert(vc: UIViewController, title: String = "Alert", message:String = "Under progress!!"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
extension BTLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
