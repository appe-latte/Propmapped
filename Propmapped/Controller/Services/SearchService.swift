//
//  SearchService.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 17/10/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import MapKit

class SearchService {
    typealias SearchHandler = ([MKMapItem]) -> Void
    
    static func poiSearch(for poiType: POIType, around center: CLLocationCoordinate2D, completion: @escaping SearchHandler){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = poiType.rawValue
        request.region = region
        
        MKLocalSearch(request: request).start {(response, error) in
            if error != nil {
                return
            }
            
            guard let response = response else {return}
            completion(response.mapItems)
        }
        
    }
    
}
