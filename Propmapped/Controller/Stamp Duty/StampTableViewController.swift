//
//  StampTableViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 05/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
/*
class StampTableViewController: UITableViewController {
    
    // User interface Elements
    let loadingSpinner = LoadingSpinner();
    
    // Variables
    var postCode = "";
    //var areaDemand:DemandData?
    var stampDuty : StampData?
    
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
        self.navigationItem.title = "STAMP DUTY: \(self.postCode)";
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
    }
    
    func loadData() {
        // We use this method to query the api and receive the parsed data
        //let api = StampAPI();
        api.submitRequest(postCode: self.postCode) { (data) in
            if let stamp = data {
                self.stampDuty = stamp;
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
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //return Constants.CouncilTaxInfo.allValues.count;
            return Constants.Stamp.headers.count;
        }
        // This will be the default if we dont have any return.
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StampTableViewCell
        
        if indexPath.section == 0 {
           // cell.headLine.text = Constants.AreaDemand.headers[indexPath.row];
            cell.headLine.text = Constants.Stamp.headers[indexPath.row];
            cell.subLine.text = self.hdrSubline(row: indexPath.row);
        }
        return cell
    }
    
    private func hdrSubline(row:Int) -> String {
        switch row {
        case 0:
            return self.stampDuty?.country?.description ?? "-"
        case 1:
            return self.stampDuty?.sdlt?.description ?? "-"
        case 2:
            return self.stampDuty?.rate?.description ?? "-"
        case 3:
            return self.stampDuty?.firstTime?.description ?? "-"
        default:
            return "-"
        }
    }
}

extension StampTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Stamp Duty"
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
*/
