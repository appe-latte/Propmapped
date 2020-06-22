//
//  CouncilData.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 20/01/2020.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import Foundation

// MARK: - Council Tax Data
struct CouncilData: Codable {
    let status, postcode : String?
    let postcodeType : String?
    let council : String?
    let councilRating : String?
    let year : String?
    let annualChange : String?
    let councilTax : [String: Int]?
    
    enum CodingKeys: String, CodingKey {
        case status, postcode
        case council, year
        case postcodeType = "postcode_type"
        case councilRating = "council_rating"
        case councilTax = "council_tax"
        case annualChange = "annual_change"
    }
}

// MARK: CouncilData convenience initializers and mutators

extension CouncilData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CouncilData.self, from: data)
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
        status: String?? = nil,
        postcode: String?? = nil,
        postcodeType: String?? = nil,
        council: String?? = nil,
        councilRating: String?? = nil,
        year: String?? = nil,
        annualChange: String?? = nil,
        councilTax: [String: Int]?? = nil
    ) -> CouncilData {
        return CouncilData(
            status: status ?? self.status,
            postcode: postcode ?? self.postcode,
            postcodeType: postcodeType ?? self.postcodeType,
            council: council ?? self.council,
            councilRating: councilRating ?? self.councilRating,
            year: year ?? self.year,
            annualChange: annualChange ?? self.annualChange,
            councilTax: councilTax ?? self.councilTax
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Council Tax
struct CouncilBands: Codable {
    let taxBands: TaxBands?
    //let constituences: [String]?
}

// MARK: Tax Bands convenience initializers and mutators

extension CouncilBands {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CouncilBands.self, from: data)
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
        results: TaxBands?? = nil
    ) -> CouncilBands {
        return CouncilBands(
            taxBands: taxBands ?? self.taxBands
        )
    }
}

// MARK: - Tax Bands

struct TaxBands: Codable {
    let band_a, band_b, band_c, band_d: String?
    let band_e, band_f, band_g, band_h: String?
    
    enum CodingKeys: String, CodingKey {
        case band_a = "band_a"
        case band_b = "band_b"
        case band_c = "band_c"
        case band_d = "band_d"
        case band_e = "band_e"
        case band_f = "band_f"
        case band_g = "band_g"
        case band_h = "band_h"
    }
}

// MARK: Results convenience initializers and mutators

extension TaxBands {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TaxBands.self, from: data)
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
        band_a: String?? = nil,
        band_b: String?? = nil,
        band_c: String?? = nil,
        band_d: String?? = nil,
        band_e: String?? = nil,
        band_f: String?? = nil,
        band_g: String?? = nil,
        band_h: String?? = nil
    ) -> TaxBands {
        return TaxBands(
            band_a: band_a ?? self.band_a,
            band_b: band_b ?? self.band_b,
            band_c: band_c ?? self.band_c,
            band_d: band_d ?? self.band_d,
            band_e: band_e ?? self.band_e,
            band_f: band_f ?? self.band_f,
            band_g: band_g ?? self.band_g,
            band_h: band_h ?? self.band_h
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

