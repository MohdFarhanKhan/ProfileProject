//
//  ViewController.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//AttractionTableViewCell

import UIKit
import MobileCoreServices
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate, NameSharingDelegate, AddressSharingDelegate, EmailSharingDelegate, DOBSharingDelegate,PhoneSharingDelegate , GenderSharingDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet weak var photoPickerView: UIPickerView!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profileImageView: DesignableImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    var nameString: String?
    var addressString: String?
    var emailString: String?
    var dobDate: Date?
    var countryCode : String?
    var phoneNumber : String?
    var gender : String? = "Male"
    var profileImage :UIImage?
    var coverImage :UIImage?
    var isProfileImageChange : Bool?
    var imageSourceOptionsAray = ["From PhotoLibrary", "from Camera"]
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPickerView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        switch indexPath.row {
        case  0 :
                 let nameCell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell
                 nameCell.delegate = self
                 nameCell.nameTextField.text = nameString
                 cell = nameCell
            
        case  1 :
                let addressCell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
                addressCell.delegate = self
                addressCell.addressTextField.text = addressString
                cell = addressCell
        case  2 :
            let emailCell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as! EmailTableViewCell
               emailCell.delegate = self
            if let email = emailString, (email.isValidEmail()){
               emailCell.emailTextField.text = email
            }
                cell = emailCell
        case  3 :
            let dobCell = tableView.dequeueReusableCell(withIdentifier: "DOBTableViewCell", for: indexPath) as! DOBTableViewCell
            dobCell.delegate = self
            if let date = dobDate{
                let timeFormatter = DateFormatter()
                timeFormatter.dateStyle = .medium
                dobCell.dobTextField.text = timeFormatter.string(from: date)
            }
                cell = dobCell
        case  4 :
            let phoneCell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as! PhoneTableViewCell
            phoneCell.delegate = self
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let code = countryCode{
                phoneCell.countryCodeTextField.text = code
                phoneCell.countryCode = code
            }
            else if appDelegate.countryCode.count>0{
                phoneCell.countryCodeTextField.text = appDelegate.countryCode
                phoneCell.countryCode = appDelegate.countryCode
            }
            if let number = phoneNumber{
                phoneCell.phoneTextField.text = number
            }
            
               cell = phoneCell
        case  5 :
            let genderCell = tableView.dequeueReusableCell(withIdentifier: "GenderTableViewCell", for: indexPath) as! GenderTableViewCell
            genderCell.delegate = self
            genderCell.gender = gender
            if gender == "Male"{
                genderCell.maleButton.backgroundColor = UIColor.green
                genderCell.femaleButton.backgroundColor = UIColor.white
            }
            else{
                genderCell.maleButton.backgroundColor = UIColor.white
                genderCell.femaleButton.backgroundColor = UIColor.green
            }
               cell = genderCell
            
        default:
            print("Wrong value")
        }
        
        return cell!
        
    }
    @IBAction func setCoverImage(_ sender: Any) {
        isProfileImageChange = false
        if isCameraAvailable() == true{
            imageSourceOptionsAray = ["From PhotoLibrary", "from Camera"]
            photoPickerView.isHidden = false
            photoPickerView.reloadAllComponents()
        }
        else{
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            photoPickerView.isHidden = true
        }
       
    }
    @IBAction func setProfileImage(_ sender: Any) {
        isProfileImageChange = true
        if isCameraAvailable() == true{
            imageSourceOptionsAray = ["From PhotoLibrary", "from Camera"]
            photoPickerView.isHidden = false
            photoPickerView.reloadAllComponents()
        }
        else{
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            photoPickerView.isHidden = true
        }
        
    }
    
    @IBAction func submitData(_ sender: Any) {
        if let name = nameString{
        print("Name....")
        print(name)
        }
        if let address = addressString{
            print("Address....")
            print(address)
        }
        if let email = emailString{
            print("Email....")
            print(email)
        }
        if let phone = phoneNumber{
            print("PhoneNo....")
            let completePhoneNo = countryCode!+phone
            print(completePhoneNo)
        }
        if let persongender = gender{
            print("Gender....")
            print(persongender)
        }
        
        
    }
    
   
   //Protocol methods
    func getNewGender(newGender: String) {
        gender = newGender
    }
    
    func getNewCode(newCode: String) {
        countryCode = newCode
    }
    
    func getNewPhoneNumber(newNumber: String) {
        phoneNumber = newNumber
    }
    
    func getNewDOB(newDOB: Date) {
        dobDate = newDOB
    }
    
    func getNewEmail(newEmail: String) {
        emailString = newEmail
    }
    
    func getNewAddress(newAddress: String) {
        addressString = newAddress
    }
    
    func getNewName(newName: String) {
        nameString = newName
    }
  //Picker for image
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageSourceOptionsAray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return imageSourceOptionsAray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row==0{
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
        }
        else{
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
        }
        photoPickerView.isHidden = true
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            if isProfileImageChange==true{
                profileImage = image
            profileImageView.image = image
            }
            else{
               coverImage = image
                coverImageView.image = image
                
            }
            
           
            
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func isCameraAvailable()->Bool{
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
          return true
        }
        return false
    }
   
}

