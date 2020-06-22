//
//  SearchViewController.swift
//  Propmapped
//
//  Created by James Jamarsoft on 02/12/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit


class SearchPropertyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // User Interface Elements
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var removeFilterButton: UIButton!
    @IBOutlet weak var propertyTypeTextField: UITextField!
    @IBOutlet weak var bedroomSlider: UISlider!
    @IBOutlet weak var bedroomLabel: UILabel!
    
    // Variables
    var delegate: ModalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    private func setUI() {
        self.propertyTypeTextField.text = UserDefaults.standard.string(forKey: "propType");
        self.radiusSlider.value = UserDefaults.standard.float(forKey: "radius");
        self.radiusLabel.text = "\(Int(self.radiusSlider.value).description) miles"
        self.bedroomSlider.value = UserDefaults.standard.float(forKey: "bedroom");
        self.bedroomLabel.text = "\(Int(self.bedroomSlider.value).description) bedrooms"
        self.addDoneButtonOnTextView();
        self.setMobilePicker();
        self.applyButton.layer.cornerRadius = 10.0
        self.removeFilterButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.dismiss(animated: true) {
            // Any action on dismiss?
        }
    }
    
    @IBAction func applyButton_Clicked(_ sender: Any) {
        UserDefaults.standard.set(self.propertyTypeTextField.text, forKey: "propType")
        UserDefaults.standard.set(self.radiusSlider.value, forKey: "radius")
        UserDefaults.standard.set(self.bedroomSlider.value, forKey: "bedrooms")
        self.processFilterChange();
    }
    
    func processFilterChange() {
        
        delegate?.applyFilter(radius: Int(self.radiusSlider.value), propType: self.propertyTypeTextField.text ?? "", bedNum: Int(self.bedroomSlider.value));
        //delegate?.applyFilter(radius: Int(self.bedroomSlider.value), propType: self.propertyTypeTextField.text ?? "");
        
        self.dismiss(animated: true) {
            // Completion handler.
        }
    }
    
    private func loadData() {
        
    }
    
    @IBAction func radiusChanged(_ sender: Any) {
        self.radiusLabel.text = "\(Int(self.radiusSlider.value).description) miles"
    }
    
    @IBAction func bedroomChanged(_ sender: Any) {
        self.bedroomLabel.text = "\(Int(self.bedroomSlider.value).description) bedrooms"
    }
    
    @IBAction func removeFilterButton(_ sender: Any) {
        self.simpleAlert(title: "Alert:", message: "Please confirm you wish to remove all filter criteria and show all properties on the map?", viewToPresentOn: self)
    }
    
    // MARK: - Data Picker
     private func setMobilePicker() {
         let MobilePicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400) );
         MobilePicker.tag = 1;
         MobilePicker.delegate = self;
         MobilePicker.dataSource = self;
         self.propertyTypeTextField.inputView = MobilePicker;
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
         self.propertyTypeTextField.text = Constants.Property.allTypes[row]
     }
     
     func addDoneButtonOnTextView() {
         let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
         doneToolbar.barStyle = .default
         let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
         let items = [flexSpace, done]
         doneToolbar.items = items
         doneToolbar.sizeToFit()
         self.propertyTypeTextField.inputAccessoryView = doneToolbar
     }
     
     @objc
     private func doneButtonAction () {
         self.propertyTypeTextField.resignFirstResponder();
     }
    
    func simpleAlert(title:String,message:String, viewToPresentOn:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Remove", style: .destructive) { (action) in
            // On confirm
            self.delegate?.removeFilter();
            self.dismiss(animated: true) {
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            // On Cancel
        }
        alertController.addAction(confirmAction);
        alertController.addAction(cancelAction);
        viewToPresentOn.present(alertController, animated: true) {
            // On presentation.
        }
    }
    
}


