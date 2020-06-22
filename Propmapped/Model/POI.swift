//
//  POI.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 17/10/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import MapKit

enum POIType: String {
    case fastFood, supermarkets, gyms, petrol
}

class POI: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let poiType: POIType
    
    init(title: String, address: String, coordinate: CLLocationCoordinate2D, poiType: POIType) {
        self.title = title
        self.subtitle = address
        self.coordinate = coordinate
        self.poiType = poiType
        
        super.init()
    }
    
}
