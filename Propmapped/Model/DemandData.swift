//
//  DemandData.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 25/01/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import Foundation

// MARK: - Area Demand Data
struct DemandData: Codable {
    let status, radius : String?
    let totalForSale : Int?
    let averageSale : String?
    let turnover : String?
    let daysOnMarket : Int?
    let demandRating : String?
    
    enum CodingKeys: String, CodingKey {
        case status, radius
        case totalForSale = "total_for_sale"
        case averageSale = "average_sales_per_month"
        case turnover = "turnover_per_month"
        case daysOnMarket = "days_on_market"
        case demandRating = "demand_rating"
    }
}

// MARK: Area Demand convenience initializers and mutaters

extension DemandData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DemandData.self, from: data)
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
        radius: String?? = nil,
        totalForSale: Int?? = nil,
        averageSale: String?? = nil,
        turnover: String?? = nil,
        daysOnMarket: Int?? = nil,
        demandRating: String?? = nil
    ) -> DemandData {
        return DemandData(
            status: status ?? self.status,
            radius: radius ?? self.radius,
            totalForSale: totalForSale ?? self.totalForSale,
            averageSale: averageSale ?? self.averageSale,
            turnover: turnover ?? self.turnover,
            daysOnMarket: daysOnMarket ?? self.daysOnMarket,
            demandRating: demandRating ?? self.demandRating
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

