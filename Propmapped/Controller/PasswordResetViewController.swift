//
//  PasswordResetViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 30/09/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PasswordResetViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refinements
        view.backgroundColor = .white
        passwordResetButton.layer.cornerRadius = 15
        cancelButton.layer.cornerRadius = 15
        emailAddressTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        emailAddressTextField.layer.borderWidth = 1.0
        emailAddressTextField.layer.cornerRadius = 15
        emailAddressTextField.layer.masksToBounds = true
        
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        guard let userEmail = emailAddressTextField.text, !userEmail.isEmpty else {return}
        
        Auth.auth().sendPasswordReset(withEmail: userEmail) {(error) in
            if error != nil {
                self.showMessage(messageToDisplay: (error?.localizedDescription)!)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func showMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Error", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        {
            (action:UIAlertAction!) in
            
            // Code in this block will trigger alert
            print("OK button tapped");
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
