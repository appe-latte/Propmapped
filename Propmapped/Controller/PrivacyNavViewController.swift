//
//  PrivacyNavViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 11/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class PrivacyNavViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSegue(withIdentifier: "SegueToPrivacy", sender: self)
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("back:")))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func back(sender: UIBarButtonItem) {
        // Go back to the previous ViewController
        let menuReturn = self.storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = menuReturn
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
