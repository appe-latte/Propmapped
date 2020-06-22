//
//  CouncilTaxAPI.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 20/01/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class CouncilTaxAPI: NSObject {
        
    public func submitRequest(postCode:String, completionBlock: @escaping (CouncilData?) -> Void) -> Void {
        
        var urlString = "\(Constants.APIData.apiCouncilURL)&postcode=\(String(describing: postCode))"
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
                print("Council Data")
                do {
                    let decoder = JSONDecoder()
                    if let counData = try? decoder.decode(CouncilData.self, from: data!) {
                        completionBlock(counData)
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
