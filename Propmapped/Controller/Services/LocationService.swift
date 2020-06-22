//
//  LocationService.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 11/10/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import CoreLocation
import UIKit

protocol LocationServiceDelegate: class {
    func authorizationDenied()
    func setMapRegion(center: CLLocation)
}
class LocationService: NSObject {
    var locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        UserDefaults.standard.set("", forKey: Constants.Keys.postCode)
    }
    
    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: locationManager.requestAlwaysAuthorization()
        case .restricted:
            delegate?.authorizationDenied()
            
        case .denied:
            delegate?.authorizationDenied()
            
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
            
        default:
            break
        }
    }
    
    private func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        if let location = locations.last {
            delegate?.setMapRegion(center: location)
            PostCodeHelper().getAddressFromLatLon(latitude: location.coordinate.latitude, withLongitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}





