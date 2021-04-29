//
//  UpdateEmailVC.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-29.
//

import UIKit

class UpdateEmailVC: UIViewController {

    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var error: UILabel!
    
    static var delegate: emailUpdatedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        error.text = ""
    }
    
    @IBAction func update(_ sender: UIButton) {
        let validEmailResponse: (success: Bool, message: String) = checkEmail(email: newEmailTF.text)
        
        if validEmailResponse.success {
            UpdateEmailVC.delegate?.emailUpdated(value: newEmailTF.text!)
            self.dismiss(animated: true, completion: nil)
        } else {
            error.text = validEmailResponse.message
        }
        
        print(validEmailResponse.message)
    }

    func checkEmail(email: String?) -> (Bool, String) {
        if let email = email, !email.isEmpty {
            if email.isValidEmail() {
                return (true, "Updated successfully")
            } else {
                return (false, "enter a valid email")
            }
        }
        return (false, "enter an email")
    }
}


