//
//  PropertyAnnotation.swift
//  Propmapped
//
//  Created by James Jamarsoft on 26/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import MapKit

class PropertyAnnotation:NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let propertyId: String?
    
    init(location: CLLocationCoordinate2D, title: String, subtitle: String, propertyId: String) {
        self.coordinate = location
        self.title = title
        self.subtitle = subtitle;
        self.propertyId = propertyId;
        super.init()
    }
    
}
