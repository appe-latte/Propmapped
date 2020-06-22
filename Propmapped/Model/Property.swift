//
//  Property.swift
//  Propmapped
//
//  Created by James Jamarsoft on 25/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation

struct Property : Codable {
    var title:String?
    var city:String?
    var postcode:String?
    var streetAddress:String?
    var photo:Data?
    var propertyType:String?
    var numberOfBedrooms:Int?
    var valueUpTo:String?
    var uniqueId:String?
    var user:String?
    var propertyDescription:String?
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let title = value["title"] as? String,
        let postcode = value["postcode"] as? String else {
          return nil
        }
        
        self.title = title
        self.postcode = postcode
        self.numberOfBedrooms = value["beds"] as? Int
        self.valueUpTo = value["value"] as? String
        self.city = value["city"] as? String
        self.streetAddress = value["address"] as? String
        self.propertyType = value["propType"] as? String
        self.uniqueId = value["uniqueID"] as? String
        self.user = value["user"] as? String
        self.propertyDescription = value["description"] as? String
    }
}

protocol Serializable : Codable {
       func serialize() -> Data?
   }
