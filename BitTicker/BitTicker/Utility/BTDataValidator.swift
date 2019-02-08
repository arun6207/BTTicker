//
//  BTDataValidator.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/8/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import UIKit

class BTDataValidator: NSObject {
    class func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    class func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        let length = password.count
        return length >= 6 && length <= 64
    }

}
