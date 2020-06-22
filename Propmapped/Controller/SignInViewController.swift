//
//  SignInViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 23/09/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refinements
        view.backgroundColor = .white
        signInButton.layer.cornerRadius = 15
        emailAddressTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        emailAddressTextField.layer.borderWidth = 1.0
        emailAddressTextField.layer.cornerRadius = 15
        emailAddressTextField.layer.masksToBounds = true
        passwordTextField.layer.borderColor = UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true
        
        self.hideKeyboardWhenTappedAround()
        passwordTextField.delegate  = self
        
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        guard let userEmail = emailAddressTextField.text, !userEmail.isEmpty else
        {
            self.showMessage(messageToDisplay: "User email is required!")
            return;
        }
        
        guard let userPassword = passwordTextField.text, !userPassword.isEmpty else
        {
            self.showMessage(messageToDisplay: "User password is required!")
            return;
        }
        emailAddressTextField.endEditing(true)
        passwordTextField.endEditing(true)
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (user, error) in
            
            if let error = error
            {
                print(error.localizedDescription)
                self.showMessage(messageToDisplay: error.localizedDescription)
                return
            }
            if user != nil
            {
                self.storedToken()
                
                if !(user?.user.isEmailVerified)!
                {
                    self.needToVerifyEmail()
                    return
                }
                let mainPage = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.present(mainPage, animated: true, completion: nil)
            }
        }
    }
    
    public func needToVerifyEmail() {
        
        let alertController = UIAlertController(title: "Verification Error", message: "Email address has not been verified.", preferredStyle: .alert)
        
        let resendEmailAction = UIAlertAction(title: "Resend Email", style: .default) {(action:UIAlertAction!) in print("resendEmailAction button tapped");
            
            Auth.auth().currentUser?.sendEmailVerification(completion:
                { (error) in
                    if error == nil
                    {
                        print("Email verification request has been successfully sent")
                        try! Auth.auth().signOut()
                    } else {
                        self.showMessage(messageToDisplay: "Email verification request could not be sent. \(String(describing: error?.localizedDescription))")
                    }
            })
        }
        
        let closeAction = UIAlertAction(title: "Close", style: .cancel) {(action:UIAlertAction!) in
            //code here will trigger when "OK" button is tapped.
            print("Close button tapped")
            try! Auth.auth().signOut()
        }
        alertController.addAction(resendEmailAction)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
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
    
    private func storedToken(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        var databaseReference: DatabaseReference!
        databaseReference = Database.database().reference()
        let currentUser = Auth.auth().currentUser
        // APN Token
        if let apnsToken = appDelegate.sharedData["apnsToken"]
        {
            let userDbRef = databaseReference.child("users").child(currentUser!.uid)
            userDbRef.child("apnsToken").setValue(apnsToken)
            appDelegate.sharedData.removeValue(forKey: "apnsToken")
        }
        // Instance Token
        if let instanceIdToken = appDelegate.sharedData["instanceIdToken"]
        {
            let userDbRef = databaseReference.child("users").child(currentUser!.uid)
            userDbRef.child("instanceIdToken").setValue(instanceIdToken)
            appDelegate.sharedData.removeValue(forKey: "instanceIdToken")
        }
    }
    
    @IBAction func passwordResetButtonTapped(_ sender: UIButton) {
        let forgotPassword = self.storyboard?.instantiateViewController(withIdentifier: "PasswordResetViewController") as! PasswordResetViewController
        forgotPassword.modalPresentationStyle = .fullScreen
        self.present(forgotPassword, animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


