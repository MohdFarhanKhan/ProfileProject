//
//  AddressTableViewCell.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
protocol AddressSharingDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func getNewAddress(newAddress: String)
}
class AddressTableViewCell: UITableViewCell, UITextFieldDelegate {
    var delegate : AddressSharingDelegate?
    @IBOutlet weak var addressTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addressTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressTextField.resignFirstResponder()
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
        print(addressTextField.text as Any)
        delegate?.getNewAddress(newAddress: addressTextField.text!)
    }
}
