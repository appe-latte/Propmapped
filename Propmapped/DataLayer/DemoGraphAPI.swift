//
//  SchoolAPI.swift
//  Propmapped
//
//  Created by James Jamarsoft on 01/12/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class DemoGraphAPI: NSObject {
        
    public func submitRequest(postCode:String, completionBlock: @escaping (Demographics?) -> Void) -> Void {
        
        var urlString = "\(Constants.APIData.apiDemographicsURL)&postcode=\(String(describing: postCode))"
                  urlString = urlString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                  print("URL: \(urlString)");
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
      //  request.setValue(header, forHTTPHeaderField: "Authorization") //**
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (response as? HTTPURLResponse) != nil {
               // print(res)
                print("Demographics Data")
                do {
                    let decoder = JSONDecoder()
                    
                    if let demoData = try? decoder.decode(Demographics.self, from: data!) {
                        completionBlock(demoData)
                    } else {
                        completionBlock(nil)
                    }
                }
            }else{
                print("Error: \(String(describing: error))")
            }
        }
        mData.resume()
    }
}
