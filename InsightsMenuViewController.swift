//
//  InsightsMenuViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 13/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import CoreLocation

class InsightsMenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var cellTitles = [
        MenuCells(id: 0, title: "Council Information", text: ""),
        MenuCells(id: 1, title: "Property Demand", text: ""),
        MenuCells(id: 2, title: "Crime Statistics", text: ""),
        MenuCells(id: 3, title: "Local Schools", text: ""),
        MenuCells(id: 4, title: "Demographics", text: ""),
        //MenuCells(id: 5, title: "Restaurants", text: ""),
       // MenuCells(id: 6, title: "Stamp Duty", text: "")
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
        return "Insights"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "insightsMenuItem", for: indexPath)
        
        //MARK: Configure the cell...
        
        if indexPath.section == 0 && indexPath.row == 2 {
            cell.textLabel?.text = cellTitles[indexPath.row].title
            cell.detailTextLabel?.text = cellTitles[indexPath.row].text
        } else {
            cell.textLabel?.text = cellTitles[indexPath.row].title
        }
        
        return cell
    }
    
    // Insights Menu Item
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.performSegue(withIdentifier: "council", sender: self)
        }else if indexPath.section == 0 && indexPath.row == 1 {
            self.performSegue(withIdentifier: "demand", sender: self)
        } else if indexPath.section == 0 && indexPath.row == 2 {
            self.performSegue(withIdentifier: "crime", sender: self)
        } else if indexPath.section == 0 && indexPath.row == 3 {
            self.performSegue(withIdentifier: "schools", sender: self)
        } else if indexPath.section == 0 && indexPath.row == 4 {
            self.performSegue(withIdentifier: "demo", sender: self)
        } else if indexPath.section == 0 && indexPath.row == 5 {
            self.performSegue(withIdentifier: "restaurant", sender: self)
        }else if indexPath.section == 0 && indexPath.row == 6 {
            self.performSegue(withIdentifier: "stamp", sender: self) }
    }
}
