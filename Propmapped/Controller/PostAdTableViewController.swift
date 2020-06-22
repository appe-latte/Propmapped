//
//  PostAdTableViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 10/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
import MobileCoreServices
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import SwiftUI

class PostAdTableViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    // User interface elements
    @IBOutlet var adTitle: UITextField!
    @IBOutlet var adAddress: UITextField!
    @IBOutlet var adCity: UITextField!
    @IBOutlet var adPostcode: UITextField!
    @IBOutlet var adPropertyType: UITextField!
    //@IBOutlet var numOfBeds: UITextField!
    @IBOutlet var propValue: UITextField!
    @IBOutlet var propDescription: UITextView!
    //@IBOutlet var submitButton: UIBarButtonItem!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var imageUploadButton: UIBarButtonItem!
    @IBOutlet var propertyImageView: UIImageView!
    @IBOutlet var bedStepper: UIStepper!
    @IBOutlet var bedStepperLabel: UILabel!
    
    // Variables
    let loadingSpinner = LoadingSpinner();
    var selectedImage:Data?
    var placeholderLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        propDescription.delegate = self
        bedStepper.wraps = true
        bedStepper.autorepeat = true
        bedStepper.maximumValue = 10
    }
    
    private func setUI() {
        view.backgroundColor = .white
        self.propertyImageView.layer.cornerRadius = 10;
        self.propertyImageView.clipsToBounds = true
        self.setMobilePicker();
        self.addDoneButtonOnTextView();
        self.bedStepperLabel.text = "\(Int(self.bedStepper.value).description) beds"
        propDescription.layer.borderWidth = 0.5
        propDescription.layer.cornerRadius = 5
        propDescription.layer.borderColor = UIColor.white.cgColor
        propDescription.text = "Enter property description"
        propDescription.textColor = .lightGray
        submitButton.layer.cornerRadius = 15
    }
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        self.showMediaPicker();
    }
    
   /* @IBAction func submitButton_Clicked(_ sender: Any) {
        self.processProperty();
    } */
    
    @IBAction func submitButton_Tapped(_ sender: Any) {
        self.processProperty();
    }
    
   
    @IBAction func bedStepperChanged(_ sender: Any) {
        self.bedStepperLabel.text = "\(Int(bedStepper.value).description) beds"
    }
    
    private func processProperty() {
        if self.isFormValid() {
            self.loadingSpinner.showActivityIndicatory(uiView: self.view);
            self.uploadProperty();
        } else {
            self.simpleAlert(title: "Info", message: "Please ensure that all required fields are completed.", viewToPresentOn: self)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        propDescription.text = nil
    }
    
    func textViewDidEndEditing(_ textVew: UITextView) {
        if propDescription.text.isEmpty {
            propDescription.text = "Enter Property description"
            propDescription.textColor = .lightGray
        }
    }
    
    func uploadProperty() {
        // Activity indicator
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
        // Image storage
        let database = Database.database();
        let dbReference = database.reference()
        if let currentUser = Auth.auth().currentUser {
            print("Current User: \(currentUser.uid)")
            let uploadedPropertyRef = dbReference.child(Constants.FirebaseKeys.users).child(Constants.FirebaseKeys.property).child(UUID.init().uuidString)
            let property = self.populatePropertyDetails();
            let uniqueID = UUID.init().uuidString
            print(uniqueID);
            uploadedPropertyRef.setValue(["title":property.title , "postcode":property.postcode,
                                          "beds":property.numberOfBedrooms?.description,
                                          "value":property.valueUpTo,
                                          "city":property.city,
                                          "address":property.streetAddress,
                                          "propType":property.propertyType,
                                          "description":property.propertyDescription,
                                          "uniqueID":uniqueID,
                                          "user":currentUser.uid]) { (error, dbref) in
                                            if let error = error {
                                                print("Data could not be saved: \(error).")
                                            } else {
                                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1) ) {
                                                    self.loadingSpinner.stopAnimatingIndicator();
                                                    //print("Meta data of property \(dbref.description())")
                                                    self.positiveUpload();
                                                    print("Data saved successfully!")
                                                    if property.photo != nil {
                                                        self.uploadImage(data:property.photo!, uniqueId:uniqueID);
                                                    } else {
                                                        // no photo complete
                                                        self.positiveUpload();
                                                    }
                                                }
                                            }
            }
        }
    }
    
    private func uploadImage(data:Data, uniqueId:String) {
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
        
        // Image storage
        let storage = Storage.storage();
        let storageReference = storage.reference()
        if let currentUser = Auth.auth().currentUser {
            print("Current User: \(currentUser.uid)")
            let uploadedPropertyRef = storageReference.child(Constants.FirebaseKeys.images).child(uniqueId)
            let uploadMetadata = StorageMetadata()
            uploadMetadata.contentType = "image/jpeg"
            uploadedPropertyRef.putData(data, metadata: uploadMetadata) { (returnedUploadedMeta, error) in
                if error != nil
                {
                    print("An error has occurred \(String(describing: error?.localizedDescription))")
                    return
                } else {
                    // Positive result so we need to stop the loading spinner
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1) ) {
                        self.loadingSpinner.stopAnimatingIndicator();
                        print("Meta data of property image \(String(describing: returnedUploadedMeta))")
                        self.positiveUpload();
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1) ) {
                self.loadingSpinner.stopAnimatingIndicator();
                self.simpleAlert(title: "Error", message: "Sorry there is no current auth user", viewToPresentOn: self)
            }
        }
    }
    
    private func populatePropertyDetails () -> Property {
        var newProperty = Property();
        newProperty.title = self.adTitle.text;
        newProperty.city = self.adCity.text;
        newProperty.postcode = self.adPostcode.text;
        newProperty.propertyType = self.adPropertyType.text;
        newProperty.streetAddress = self.adAddress.text;
        newProperty.numberOfBedrooms = Int(bedStepper.value);
        newProperty.valueUpTo = self.propValue.text;
        newProperty.propertyDescription = self.propDescription.text;
        newProperty.photo = self.selectedImage;
        return newProperty;
    }
    
}

extension PostAdTableViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func isFormValid() -> Bool {
        return self.adTitle.hasText && self.adPostcode.hasText && self.adAddress.hasText && self.adPropertyType.hasText;
    }
    
    // MARK: Image Code
    
    func showMediaPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let optimizedImageData = selectedImage.jpegData(compressionQuality: 0.7)
        {
            self.propertyImageView.image = UIImage(data: optimizedImageData);
            self.selectedImage = optimizedImageData
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Alert pop-up
    func simpleAlert(title:String,message:String, viewToPresentOn:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertController.addAction(confirmAction);
        viewToPresentOn.present(alertController, animated: true) {
        }
    }
    
    // MARK: Upload message
    private func positiveUpload() {
        let title = "Success"
        let message = "Your property has successfully been uploaded."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // On confirm
            self.dismiss(animated: true) {
            }
        }
        alertController.addAction(confirmAction);
        self.present(alertController, animated: true) {
            // On presentation.
        }
    }
    
    // MARK: - Property Type Data Picker
    private func setMobilePicker() {
        let MobilePicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400) );
        MobilePicker.tag = 1;
        MobilePicker.delegate = self;
        MobilePicker.dataSource = self;
        self.adPropertyType.inputView = MobilePicker;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.Property.allTypes.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.Property.allTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.adPropertyType.text = Constants.Property.allTypes[row]
    }
 
    
    func addDoneButtonOnTextView() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.adPropertyType.inputAccessoryView = doneToolbar
    }
    
    @objc
    private func doneButtonAction () {
        self.adPropertyType.resignFirstResponder();
    }
}




