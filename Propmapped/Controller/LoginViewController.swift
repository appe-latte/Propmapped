//
//  LoginViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 23/09/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FBSDKLoginKit
import FBSDKCoreKit
// import GoogleSignIn

class LoginViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var existingUserButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var facebookSignInButton: FBLoginButton!
    
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if user is signed in
        Auth.auth().addStateDidChangeListener(){
            auth, user in if user != nil {
                let mainPage = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                mainPage.modalPresentationStyle = .fullScreen
                self.present(mainPage, animated: true, completion: nil)
            }
        }
        //Facebook login
        facebookSignInButton.delegate = self
        facebookSignInButton.permissions = ["email"]
        
        // Background and Button refinements
        view.backgroundColor = .white
        registrationButton.layer.cornerRadius = 15
        existingUserButton.layer.cornerRadius = 15
        existingUserButton.layer.borderColor =  UIColor(red:217/255, green:93/255, blue:95/255, alpha: 1).cgColor
        existingUserButton.layer.borderWidth = 1.0
        facebookSignInButton.layer.cornerRadius = 7.5
        facebookSignInButton.layer.masksToBounds = true
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        let registrationPage = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        registrationPage.modalPresentationStyle = .fullScreen
        self.present(registrationPage, animated: true, completion: nil)
        // performSegue(withIdentifier: "registerUser", sender: self)
    }
    
    @IBAction func existingUserButtonTapped(_ sender: UIButton) {
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        signInPage.modalPresentationStyle = .fullScreen
        self.present(signInPage, animated: true, completion: nil)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Error took place \(error.localizedDescription)")
            return
        }
        print("Success")
        
        if AccessToken.current == nil
        {
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) {(user, error) in
            if let error = error {
                print("Could not sign in with your Facebook details because: \(error.localizedDescription)")
                self.showMessage(messageToDisplay: error.localizedDescription)
                LoginManager().logOut()
                return
            }
            
            // User sign-in
            print("Succesfully signed in! Your user ID is: \(String(describing: user?.user.uid))")
            print("User email address is: \(String(describing: user?.user.email))")
            
            var userDetails: [String: String] = [:]
            if let userFullName = user?.user.displayName
            {
                let userNameDetails = userFullName.components(separatedBy: .whitespaces)
                if userNameDetails.count >= 2 {
                    userDetails["firstName"] = userNameDetails[0]
                    userDetails["lastName"] = userNameDetails[1]
                }
            }
            
            //store FB user details in database
            var databaseReference: DatabaseReference!
            databaseReference = Database.database().reference()
            databaseReference.child("users").child(user!.user.uid).setValue(["userDetails": userDetails])
            
            self.storedToken()
            
            let mainPage = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            //            mainPage.modalPresentationStyle = .fullScreen
            //            self.present(mainPage, animated: true, completion: nil)
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = mainPage
        }
    }
    
    private func storedToken(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var databaseReference: DatabaseReference!
        databaseReference = Database.database().reference()
        
        let currentUser = Auth.auth().currentUser
        
        if let apnsToken = appDelegate.sharedData["apnsToken"]
        {
            let userDbRef = databaseReference.child("users").child(currentUser!.uid)
            userDbRef.child("apnsToken").setValue(apnsToken)
            appDelegate.sharedData.removeValue(forKey: "apnsToken")
        }
        
        if let instanceIdToken = appDelegate.sharedData["instanceIdToken"]
        {
            let userDbRef = databaseReference.child("users").child(currentUser!.uid)
            userDbRef.child("instanceIdToken").setValue(instanceIdToken)
            appDelegate.sharedData.removeValue(forKey: "instanceIdToken")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Sign out complete")
    }
    
    public func showMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Login Error", message: messageToDisplay, preferredStyle: .alert)
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
