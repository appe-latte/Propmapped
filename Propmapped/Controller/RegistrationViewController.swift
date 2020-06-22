//
//  RegistrationViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 24/09/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var userRegistrationButton: UIButton!
    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lnameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var existingUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refinements
        view.backgroundColor = .white
        userRegistrationButton.layer.cornerRadius = 15
        emailAddressTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        emailAddressTextField.layer.borderWidth = 1.0
        emailAddressTextField.layer.cornerRadius = 15
        emailAddressTextField.layer.masksToBounds = true
        passwordTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true
        repeatPasswordTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        repeatPasswordTextField.layer.borderWidth = 1.0
        repeatPasswordTextField.layer.cornerRadius = 15
        repeatPasswordTextField.layer.masksToBounds = true
        fnameTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        fnameTextField.layer.borderWidth = 1.0
        fnameTextField.layer.cornerRadius = 15
        fnameTextField.layer.masksToBounds = true
        lnameTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        lnameTextField.layer.borderWidth = 1.0
        lnameTextField.layer.cornerRadius = 15
        lnameTextField.layer.masksToBounds = true
        
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func userRegistrationButtonTapped(_ sender: Any) {
        //Check for mandatory input
        
        guard let userFirstName = fnameTextField.text, !userFirstName.isEmpty else
        {
            self.showMessage(messageToDisplay: "First Name is required!")
            return;
        }
        
        guard let userLastName = lnameTextField.text, !userLastName.isEmpty else
        {
            self.showMessage(messageToDisplay: "Last Name is required!")
            return;
        }
        
        guard let userEmail = emailAddressTextField.text, !userEmail.isEmpty else
        {
            self.showMessage(messageToDisplay: "Email Address is required!")
            return;
        }
        
        guard let userPassword = passwordTextField.text, !userPassword.isEmpty else
        {
            self.showMessage(messageToDisplay: "User password is required!")
            return;
        }
        
        guard let userRepeatPassword = repeatPasswordTextField.text, !userRepeatPassword.isEmpty else
        {
            self.showMessage(messageToDisplay: "User repeat password is required!")
            return;
        }
        
        if userPassword != userRepeatPassword
        {
            self.showMessage(messageToDisplay: "Password mismatch error!")
            return
        }
        
        //User email and password registration
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
            
            if let error = error
            {
                print(error.localizedDescription)
                self.showMessage(messageToDisplay: error.localizedDescription)
                return
            }
            
            if let user = user {
                
                var databaseReference : DatabaseReference!
                databaseReference = Database.database().reference()
                
                let userDetails:[String:String] = ["firstName":userFirstName, "lastName":userLastName, "userEmail":userEmail]
                databaseReference.child("users").child(user.user.uid).setValue(["userDetails":userDetails])
                
                user.user.sendEmailVerification(completion: nil)
                self.showMessage(messageToDisplay: "Email Verification sent. Please check your email and click the link to complete verification")
                
                let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = signInPage
            }
        }
        return
    }
    
    @IBAction func existingUserButtonTapped(_ sender: Any) {
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        signInPage.modalPresentationStyle = .fullScreen
        self.present(signInPage, animated: true, completion: nil)
    }
    
    public func showMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Registration Error", message: messageToDisplay, preferredStyle: .alert)
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
