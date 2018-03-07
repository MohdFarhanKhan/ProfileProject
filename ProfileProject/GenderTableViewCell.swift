//
//  GenderTableViewCell.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
protocol GenderSharingDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func getNewGender(newGender: String)
    
}
class GenderTableViewCell: UITableViewCell {
    var delegate : GenderSharingDelegate?
    var gender : String? = "Male"
    
    @IBOutlet weak var femaleButton: DesignableButton!
    @IBOutlet weak var maleButton: DesignableButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func setMale(_ sender: Any) {
        gender = "Male"
        maleButton.backgroundColor = UIColor.green
        femaleButton.backgroundColor = UIColor.white
        delegate?.getNewGender(newGender: gender!)
        
    }
    @IBAction func setFemale(_ sender: Any) {
        gender = "Female"
        maleButton.backgroundColor = UIColor.white
        femaleButton.backgroundColor = UIColor.green
        delegate?.getNewGender(newGender: gender!)
    }
    
}
