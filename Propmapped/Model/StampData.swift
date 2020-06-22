//
//  StampData.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 05/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import Foundation

// MARK: - Stamp Duty Data
struct StampData: Codable {
    let status : String?
    let country : String?
    let sdlt : Int?
    let rate : Bool?
    let firstTime : Bool?
    
    enum CodingKeys: String, CodingKey {
        case status
        case country = "country_used"
        case sdlt = "sdlt_payable"
        case rate = "additional_rate_used"
        case firstTime = "first_time_buyer"
    }
}

// MARK: Stamp Duty convenience initializers and mutaters

extension StampData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StampData.self, from: data)
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
        country : String?? = nil,
        sdlt : Int?? = nil,
        rate : Bool?? = nil,
        firstTime : Bool?? = nil
    ) -> StampData {
        return StampData(
            status: status ?? self.status,
            country: country ?? self.country,
            sdlt: sdlt ?? self.sdlt,
            rate: rate ?? self.rate,
            firstTime: firstTime ?? self.firstTime
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


