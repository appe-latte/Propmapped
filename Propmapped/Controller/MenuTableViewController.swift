//
//  MenuTableViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 13/10/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

struct MenuCells {
    var id : Int
    var title : String
    var text : String
}

class MenuTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var cellTitles = [
        MenuCells(id: 0, title: "User Profile", text: ""),
        MenuCells(id: 1, title: "Privacy Policy", text: ""),
        MenuCells(id: 2, title: "Sign Out", text: "Sign out from Propmapped app.")
    ]
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Main Menu"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath)
        
        if indexPath.section == 0 && indexPath.row == 2 {
            cell.textLabel?.text = cellTitles[indexPath.row].title
            cell.detailTextLabel?.text = cellTitles[indexPath.row].text
        } else {
            cell.textLabel?.text = cellTitles[indexPath.row].title
        }
        
        return cell
    }
    
    // Menu items
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            do
            {
                Analytics.logEvent("signout", parameters: nil)
                
                for userInfo in (Auth.auth().currentUser?.providerData)! {
                    if userInfo.providerID == "facebook.com" {
                        LoginManager().logOut()
                        break
                    }
                }
                
                try Auth.auth().signOut()
                let loginReturn = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = loginReturn
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }else if indexPath.section == 0 && indexPath.row == 0 {
            let userInfo = self.storyboard?.instantiateViewController(withIdentifier: "ProfileTableViewController") as! ProfileTableViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = userInfo
        }else if indexPath.section == 0 && indexPath.row == 1 {
            let termsPage = self.storyboard?.instantiateViewController(withIdentifier: "TermsNavViewController") as! TermsNavViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = termsPage
        }
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        let mainPage = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainPage
    }
}
