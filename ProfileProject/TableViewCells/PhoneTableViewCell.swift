//
//  PhoneTableViewCell.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
protocol PhoneSharingDelegate: class {
     func getNewCode(newCode: String)
    func getNewPhoneNumber(newNumber: String)
}
class PhoneTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return codeCountryArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let codeDict = codeCountryArray[row]
        var keyValueString = "Code : Country"
        for (key, value) in codeDict{
            keyValueString = "\(key) : \(value)"
        }
        return keyValueString
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let codeDict = codeCountryArray[row]
        var codeString = "Code"
        for (key, _) in codeDict{
            codeString = key
        }
        countryCodeTextField.text = codeString
    }

    var countryCode : String?
    var phoneNumber : String?
    var delegate : PhoneSharingDelegate?
    var codeCountryArray : [[String:String]] = []
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       countryCodeTextField.delegate = self
        phoneTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCurrentCountryCode(_:)), name: NSNotification.Name(rawValue: "countryCodeNotification"), object: nil)
   }
    
    @objc func showCurrentCountryCode(_ notification: NSNotification) {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let code = dict["countryCode"] as? String{
                countryCodeTextField.text=code
                self.delegate?.getNewCode(newCode: code)
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (codeCountryArray.count<=0){
            codeCountryArray = CodeManager.sharedInstance.getCodeCountryArray()
            if codeCountryArray.count<=0{
            return false
            }
        }
        let pickerView = UIPickerView()
        pickerView.delegate = self
        countryCodeTextField.inputView = pickerView
       return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        if textField != phoneTextField{
            return true
        }
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 12
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == countryCodeTextField{
            self.delegate?.getNewCode(newCode: textField.text!)
        }
        else{
            self.delegate?.getNewPhoneNumber(newNumber: textField.text!)
        }
        
        
    }
       
}
