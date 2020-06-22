//
//  CrimeStatsTableViewController.swift
//  Propmapped
//
//  Created by James Jamarsoft on 24/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class SchoolsTableViewController: UITableViewController {
    
    // User interface Elements
    let loadingSpinner = LoadingSpinner();
    
    // Variables
    var postCode = "";
    var schoolData:SchoolData?
    let headers = Constants.SchoolsStrings.headers;
    
    
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
            self.simpleAlert(title: "Alert:", message: "Sorry it does not appear we could obtain a location for you.  Please return to the map screen and try again", viewToPresentOn: self);
            self.loadingSpinner.stopAnimatingIndicator();
        }
    }
    
    func setUI() {
        self.navigationItem.title = "SCHOOLS: \(self.postCode)";
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
    }
    
    
    func loadData() {
        // We use this method to query the api and receive the parsed data
        let api = SchoolAPI();
        api.submitRequest(postCode:self.postCode) { (data) in
            if let schools = data {
                self.schoolData = schools;
                
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
        return 3;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2;
        }else if section == 1 {
            if let count = self.schoolData?.data?.state?.nearest?.count {
                return count;
            }
        } else if section == 2 {
            if let count = self.schoolData?.data?.independent?.nearest?.count {
                return count
            }
        }
        // This will be the default if we dont have any return.
        return 0;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.headLine.text = "Progress 8 Average"
                cell.subLine.text = self.schoolData?.data?.state?.average_score
                return cell
            } else {
                cell.headLine.text = "School Rating"
                cell.subLine.text = self.schoolData?.data?.state?.rating
                return cell
            }
        } else if indexPath.section == 1 {
            // state school
            if let school = self.schoolData?.data?.state?.nearest?[indexPath.row] {
                cell.headLine.text = "School:";
                cell.subLine.text = school.name
                return cell
            }
        } else if indexPath.section == 2 {
            // Indie
            if let school = self.schoolData?.data?.independent?.nearest?[indexPath.row] {
                cell.headLine.text = "School:";
                cell.subLine.text = school.name
                return cell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            // State
            if let school = self.schoolData?.data?.state?.nearest?[indexPath.row] {
                
                let details = "\(self.headers[1]) : \(school.local_authority ?? "")\n\(self.headers[2]) : \(school.postcode ?? "")\n\(self.headers[3]) : \(school.type ?? "")\n\(self.headers[4]) : \(school.phase ?? "")\n\(self.headers[5]) : \(school.sixth_form ?? "")\n\(self.headers[6]) : \(school.rating ?? "")\n\(self.headers[7]) : \(school.num_pupils?.description ?? "")\n"
                self.simpleAlert(title: school.name ?? "", message: details, viewToPresentOn: self)
            }
        } else if indexPath.section == 2 {
            // indie
            if let school = self.schoolData?.data?.independent?.nearest?[indexPath.row] {
                let details = "\(self.headers[0]) : \(school.name ?? "")\n\(self.headers[2]) : \(school.postcode ?? "")\n\(self.headers[3]) : \(school.type ?? "")\n\(self.headers[13]) : \(school.ages ?? "")\n\(self.headers[14]) : \(school.gender ?? "")\n"
                self.simpleAlert(title: school.name ?? "", message: details, viewToPresentOn: self)
            }
        }
    }
    
}

extension SchoolsTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return Constants.SchoolsStrings.scores
        } else if section == 1 {
            return Constants.SchoolsStrings.state
        } else if section == 2 {
            return Constants.SchoolsStrings.independant
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
