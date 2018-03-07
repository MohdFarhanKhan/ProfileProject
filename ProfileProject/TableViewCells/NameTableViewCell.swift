//
//  NameTableViewCell.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
protocol NameSharingDelegate: class {
    func getNewName(newName: String)
}
class NameTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: NameSharingDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       nameTextField.resignFirstResponder()
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
        self.delegate?.getNewName(newName: textField.text!)
        print(nameTextField.text as Any)
    }
}
