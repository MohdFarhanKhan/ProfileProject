//
//  DOBTableViewCell.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
protocol DOBSharingDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func getNewDOB(newDOB: Date)
}
class DOBTableViewCell: UITableViewCell, UITextFieldDelegate {
    var delegate : DOBSharingDelegate?
    @IBOutlet weak var dobTextField: UITextField!
    var dobDate : Date?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        dobTextField.inputView = datePickerView
        
        
        datePickerView.addTarget(self, action: #selector(self.handleDatePicker(sender:)), for: .valueChanged)
       // datePickerView.addTarget(self, action: Selector(("handleDatePicker:")), for: UIControlEvents.valueChanged)

        return true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        dobTextField.delegate = self
        
    }
    @IBAction func DoneButton(sender: UIButton) {
        
        //How to make datepicker disappear???
        dobTextField.resignFirstResponder()
        delegate?.getNewDOB(newDOB: dobDate!)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .medium
        
        dobTextField.text = timeFormatter.string(from: sender.date)
        dobDate = sender.date
    }
}
