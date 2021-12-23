//
//  ExtensionUIAlertController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.12.2021.
//

import Foundation
import UIKit
import ObjectMapper


extension UIAlertController {

  /*  func isValidEmail(_ email: String) -> Bool {
        return email.characters.count > 0 && NSPredicate(format: "self matches %@", "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}").evaluate(with: email)
    }
*/
    func isValidFlatAMount(_ password: String) -> Bool {
        return password.count > 2 && password.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }

    @objc func textDidChangeInLoginAlert() {
        if let flat = textFields?[0].text,
           // let password = textFields?[1].text,
            let action = actions.last {
           action.isEnabled = isValidFlatAMount(flat)
        }
    }
}
