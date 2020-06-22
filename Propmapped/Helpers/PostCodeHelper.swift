//
//  PostCodeHelper.swift
//  Propmapped
//
//  Created by James Jamarsoft on 25/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import CoreLocation

class PostCodeHelper: NSObject {
    
    
    func getAddressFromLatLon(latitude: Double, withLongitude longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        let lat = latitude
        let lon = longitude
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                if let pm = placemarks?.first {
                    UserDefaults.standard.set(pm.postalCode ?? "", forKey: Constants.Keys.postCode)
                }
        })
    }
    
    func latAndLongFromAddress(postCode:String,completionBlock: @escaping (CLLocation?) -> Void) -> Void {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString("\(postCode)") { (placemarks, error) in
            guard
                let location = placemarks?.first?.location
            else {
                // handle no location found
                completionBlock(nil)
                return;
            }

            if let finalLocation = location as? CLLocation {
                completionBlock(finalLocation);
            } else {
                completionBlock(nil)
            }
        }
    }
}
