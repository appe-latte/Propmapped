//
//  MKPlacemark+Extension.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 17/10/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import MapKit


extension MKPlacemark {
    var formattedAddress: String? {
        guard
            let streetNumber = subThoroughfare,
            let streetName = thoroughfare,
            let city = locality,
            let state = administrativeArea,
            let zip = postalCode
        else {
                if let title = title{
                    return "\(title)"
                }
                else{
                    return nil
                }
        }
        
        let address = "\(streetNumber) \(streetName), \(city), \(state) \(zip)"
        return address
    }
}
