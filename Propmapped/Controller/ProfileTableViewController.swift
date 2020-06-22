//
//  ProfileTableViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 08/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileTableViewController : UITableViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var returnButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let currentUser = Auth.auth().currentUser
        if currentUser == nil
        {
            self.showMessage(messageToDisplay: "User could not be read")
            return
        }
        print("User ID is: \(String(describing: currentUser?.uid))")
        print("User Email is: \(String(describing: currentUser?.email))")
        print("Is the email verified?: \(String(describing: currentUser?.isEmailVerified))")
        
        var databaseReference: DatabaseReference!
        databaseReference = Database.database().reference()
        databaseReference.child("users").child((currentUser?.uid)!).child("userDetails").observe(DataEventType.value) {(snapshot) in
            
            let userDetailsData = snapshot.value as? NSDictionary
            let firstName = userDetailsData?["firstName"] as? String ?? ""
            let lastName = userDetailsData?["lastName"] as? String ?? ""
            let userEmail = userDetailsData!["userEmail"] as? String ?? ""
            
            self.firstNameLabel.text! = self.firstNameLabel.text! + " " + firstName
            self.lastNameLabel.text! = self.lastNameLabel.text! + " " + lastName
            self.emailAddressLabel.text! = self.emailAddressLabel.text! + " " + userEmail
        }
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        let menuReturn = self.storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = menuReturn
    }
    
    public func showMessage(messageToDisplay: String) {
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
