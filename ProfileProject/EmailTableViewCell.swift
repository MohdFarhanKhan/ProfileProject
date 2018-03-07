//
//  EmailTableViewCell.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
protocol EmailSharingDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func getNewEmail(newEmail: String)
}
class EmailTableViewCell: UITableViewCell, UITextFieldDelegate {
     var delegate : EmailSharingDelegate?
    @IBOutlet weak var emailTextField: UITextField!
    private var oldEmail : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emailTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text?.isValidEmail())!{
            oldEmail = textField.text
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
    }
    
    func textFieldDidReturn(textField: UITextField!) {
        textField.resignFirstResponder()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if (textField.text?.isValidEmail())!{
            oldEmail = textField.text
            delegate?.getNewEmail(newEmail: emailTextField.text!)
        }
        else{
            emailTextField.text = oldEmail
        }
        print(emailTextField.text as Any)
       
        
    }
    
}
