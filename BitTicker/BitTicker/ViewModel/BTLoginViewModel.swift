//
//  BTLoginViewModel.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/8/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit

class BTLoginViewModel: NSObject {
    
    func validateUserNameAndPassword(userName: String?, password: String?) -> (validEamil: Bool, validPassword: Bool, validCredentails: Bool) {
        if BTDataValidator.isValidEmail(userName) {
            if BTDataValidator.isValidPassword(password) {
                return (true,true,true)
            }
            else {
                return (true,false,false)
            }
        }
        else {
            return (false,false,false)
        }
    }
    func loginWithUserDeatils(username: String, password: String, completionHandler: @escaping(_ success: Bool) -> Void){
        BTNetworkServices.sharedInstance().loginWithUserDetails(userName: username, password: password) { (sucess) in
            sucess ? completionHandler(true) :  completionHandler(false)
        }
    }
    func signUpNewUser(username: String, password: String, completionHandler: @escaping(_ success: Bool) -> Void) {
        BTNetworkServices.sharedInstance().createAccount(userName: username, password: password) { (sucess) in
            sucess ? completionHandler(true) :  completionHandler(false)
            
        }
    }
    
}
