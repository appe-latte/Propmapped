//
//  StampAPI.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 05/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
/*
class StampAPI: NSObject {
        
    public func submitRequest(postCode:String, completionBlock: @escaping (StampData?) -> Void) -> Void {
        
        var urlString = "\(Constants.APIData.apiStampURL)&postcode=\(String(describing: postCode))"
                  urlString = urlString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                  print("URL: \(urlString)");
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let res = response as? HTTPURLResponse {
                print(res)
                print("Stamp Duty Data")
                do {
                    let decoder = JSONDecoder()
                    if let restData = try? decoder.decode(StampData.self, from: data!) {
                        completionBlock(restData)
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
*/
