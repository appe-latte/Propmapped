//
//  RestaurantData.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 02/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import Foundation

// MARK: - Restaurant Data
struct RestaurantData: Codable {
    let status, postcode : String?
    let data : RestDataClass?

    enum CodingKeys: String, CodingKey {
        case status
        case postcode
        case data
    }
}

// MARK: Restaurant convenience initializers and mutaters

extension RestaurantData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RestaurantData.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        status : String?? = nil,
        postcode : String?? = nil,
        data : RestDataClass?? = nil
        
    ) -> RestaurantData {
        return RestaurantData(
            status : status ?? self.status,
            postcode : postcode ?? self.postcode,
            data : data ?? self.data
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataClass Data
struct RestDataClass: Codable {
    let avgHygiene : String?
    let propBad : Int?
    let rating : String?
    let nearby : NearbyDataClass?

    enum CodingKeys: String, CodingKey {
        case avgHygiene = "average_hygiene"
        case propBad = "proportion_bad"
        case rating
        case nearby
    }
}

// MARK: Restaurant convenience initializers and mutaters

extension RestDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RestDataClass.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        avgHygiene : String?? = nil,
        propBad : Int?? = nil,
        rating : String?? = nil,
        nearby : NearbyDataClass?? = nil
        
    ) -> RestDataClass {
        return RestDataClass(
            avgHygiene : avgHygiene ?? self.avgHygiene,
            propBad : propBad ?? self.propBad,
            rating : rating ?? self.rating,
            nearby : nearby ?? self.nearby
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - NearbyDataClass

struct NearbyDataClass: Codable {
    let name : String?
    let address : String?
    let type : String?
    let hygiene : String?
    let ratingDate : String?
    let distance : String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case address
        case type
        case hygiene
        case ratingDate = "rating_date"
        case distance
    }
}

// MARK: NearbyDataClass convenience initializers and mutators

extension NearbyDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(NearbyDataClass.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name : String?? = nil,
        address : String?? = nil,
        type : String?? = nil,
        hygiene : String?? = nil,
        ratingDate : String?? = nil,
        distance : String?? = nil
    ) -> NearbyDataClass {
        return NearbyDataClass(
            name : name ?? self.name,
            address : address ?? self.address,
            type : type ?? self.type,
            hygiene : hygiene ?? self.hygiene,
            ratingDate : ratingDate ?? self.ratingDate,
            distance : distance ?? self.distance
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
