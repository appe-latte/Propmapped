//
//  CrimeStatsTableViewController.swift
//  Propmapped
//
//  Created by James Jamarsoft on 24/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class DemoGraphicsTableViewController: UITableViewController {
    
    // User interface Elements
    let loadingSpinner = LoadingSpinner();
    
    // Variables
    var postCode = "";
    var demoData:Demographics?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.postCode = UserDefaults.standard.string(forKey: Constants.Keys.postCode) ?? "";
        if self.postCode != "" {
            self.setUI()
            self.loadData();
        } else {
            self.simpleAlert(title: "Info", message: "Sorry it does not appear we could obtain a location for you.  Please return to the map screen and try again", viewToPresentOn: self);
            self.loadingSpinner.stopAnimatingIndicator();
        }
    }
    
    func setUI() {
        self.navigationItem.title = "DEMOGRAPHICS: \(self.postCode)";
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
    }
    
    
    func loadData() {
        // We use this method to query the api and receive the parsed data
        let api = DemoGraphAPI();
        api.submitRequest(postCode:self.postCode) { (data) in
            if let demo = data {
                self.demoData = demo;
                // Execute the UI Update on the main thread.
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                    self.loadingSpinner.stopAnimatingIndicator()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.demoData?.data != nil {
            if section == 0 {
                return 3
            }
            if let count = self.demoData?.data?.politics?.constituences?.count {
                return count;
            }
        }
        return 0;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        cell.headLine.text = "";
        cell.subLine.text = "";
        
        if indexPath.section == 0 {
            return self.demoCellText(cell: cell, row: indexPath.row)
        } else if indexPath.section == 1 {
            if let cont = self.demoData?.data?.politics?.constituences?[indexPath.row] {
                cell.headLine.text = cont;
                cell.subLine.text = "";
                return cell;
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            // Politics
            if let results = self.demoData?.data?.politics?.results {
                let message = "Conservative: \(results.conservative ?? "")\nLabour: \(results.labour ?? "")\nLiberal Democrats: \(results.liberalDemocrats ?? "")\nUKIP: \(results.ukip ?? "")\nGreen Party: \(String(describing: results.greenParty ?? ""))"
                self.simpleAlert(title: "Political Parties", message: message, viewToPresentOn: self)
            }
            
        } else if indexPath.section == 0 && indexPath.row == 1 {
            // Age
            if let age = self.demoData?.data?.age {
                let message = "0-4 : \(age.the04 ?? "")%\n5-9 : \(age.the59 ?? "")%\n10-14 : \(age.the1014 ?? "")%\n15-19 : \(age.the1519 ?? "")%\n20-24 : \(age.the2024 ?? "")%\n25-29 : \(age.the2529 ?? "")%\n30-34 : \(age.the3034 ?? "")%\n35-39 : \(age.the3539 ?? "")%\n40-44 : \(age.the4044 ?? "")%\n45-49 : \(age.the4549 ?? "")%\n50-54 : \(age.the5054 ?? "")%\n55-59 : \(age.the5559 ?? "")%\n60-64 : \(age.the6064 ?? "")%\n65-69 : \(age.the6569 ?? "")%\n70-74 : \(age.the7074 ?? "")%\n75-79 : \(age.the7579 ?? "")%\n80-84 : \(age.the8084 ?? "")%\n85-89 : \(age.the8589 ?? "")%\n"
                
                self.simpleAlert(title: "Age Groups", message: message, viewToPresentOn: self)
            }
        }
    }
    
    func demoCellText(cell:DataTableViewCell, row:Int) -> DataTableViewCell {
        switch row  {
        case 0:
            cell.headLine.text = "Politics"
            cell.subLine.text = "Press for more information"
            return cell;
        case 1:
            cell.headLine.text = "Age"
            cell.subLine.text = "Press for more information"
            return cell;
        case 2:
            cell.headLine.text = "Proportion With Degree"
            cell.subLine.text = "\(self.demoData?.data?.proportionWithDegree?.description ?? "")%"
            return cell;
        default:
            return cell
        }
    }
    
}

extension DemoGraphicsTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Statistics"
        } else if section == 1 {
            return "Constituences"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    /* Both sections required for < ios 13 and > 13 */
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // This is for the section headers
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        header.textLabel?.textColor = .white;
        
        if #available(iOS 13.0, *) {
            header.backgroundView?.backgroundColor =  UIColor(red:1.00, green:0.56, blue:0.55, alpha:1.0)
        } else {
            (view as? UITableViewHeaderFooterView)?.backgroundView?.backgroundColor =  UIColor(red:1.00, green:0.56, blue:0.55, alpha:1.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func simpleAlert(title:String,message:String, viewToPresentOn:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // On confirm
        }
        alertController.addAction(confirmAction);
        viewToPresentOn.present(alertController, animated: true) {
            // On presentation.
        }
    }
    
}
