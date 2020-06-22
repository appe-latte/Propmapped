//
//  DistanceHelper.swift
//  Propmapped
//
//  Created by James 1DayLaunch on 02/12/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import CoreLocation

class DistanceHelpers: NSObject {
    
    private func distanceBetweenTwoLocationsInMeters(cordinateOne:CLLocation, cordinateTwo:CLLocation) -> Double {
        return cordinateOne.distance(from: cordinateTwo);
    }
    
    // 1609 meter in a mile
    
    func distanceBetweenTwoLocationsInMiles(cordinateOne:CLLocation, cordinateTwo:CLLocation) -> Int {
        let meters = self.distanceBetweenTwoLocationsInMeters(cordinateOne: cordinateOne, cordinateTwo: cordinateTwo);
        return Int(meters/1609)
    }
}
