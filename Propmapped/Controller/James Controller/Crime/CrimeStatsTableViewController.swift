//
//  CrimeStatsTableViewController.swift
//  Propmapped
//
//  Created by James Jamarsoft on 24/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class CrimeStatsTableViewController: UITableViewController {
    
    // User interface Elements
    let loadingSpinner = LoadingSpinner();
    
    // Variables
    var postCode = "";
    var crimeData:CrimeData?
    var types:[(String,Int)]?
    
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
        self.navigationItem.title = "CRIME: \(self.postCode)";
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
    }
    
    
    func loadData() {
        // We use this method to query the api and receive the parsed data
        let api = CrimeAPI();
        api.submitRequest(postCode:self.postCode) { (data) in
            if let crimes = data {
                self.crimeData = crimes;
                
                self.types = crimes.types?.map({ (key: String, value: Int) in
                    return (key, value);
                })
                
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
            return Constants.CrimeHeadlines.allValues.count;
        } else if section == 1 {
            if let crimeTypes = self.types?.count {
                return crimeTypes
            }
        } else if section == 2 {
            if let observations = self.crimeData?.observations?.count {
                return observations;
            }
        }
        // This will be the default if we dont have any return.
        return 0;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CrimeCellTableViewCell
        
        // Sections
        if indexPath.section == 0 {
            // Headers
            cell.headLine.text = Constants.CrimeHeadlines.allValues[indexPath.row];
            cell.subLine.text = self.headerSubline(row: indexPath.row);
        } else if indexPath.section == 1 {
            // Crime types
            cell.headLine.text = self.types?[indexPath.row].0 ?? ""
            cell.subLine.text = self.types?[indexPath.row].1.description ?? ""
        } else if indexPath.section == 2 {
            // Observations
            cell.headLine.text = self.crimeData?.observations?[indexPath.row] ?? ""
            //cell.subLine.text = "-"
            cell.subLine.text = self.crimeData?.observations?[indexPath.row] ?? ""
        }
        return cell
    }
    
    
    private func headerSubline(row:Int) -> String {
        switch row {
        case 0:
            return self.crimeData?.population?.description ?? "-"
        case 1:
            return self.crimeData?.crimesLast12M?.description ?? "-"
        case 2:
            return self.crimeData?.crimesPerThousand?.description ?? "-"
        case 3:
            return self.crimeData?.crimeRating?.description ?? "-"
        default:
            return "-"
        }
    }
    
}

extension CrimeStatsTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Constants.CrimeHeadlines.section0
        } else if section == 1 {
            return Constants.CrimeHeadlines.section1
        } else {
            return Constants.CrimeHeadlines.section2
        }
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
            header.backgroundView?.backgroundColor = UIColor(red:1.00, green:0.56, blue:0.55, alpha:1.0)
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
