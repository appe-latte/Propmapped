//
//  CrimeData.swift
//  Propmapped
//
//  Created by James Jamarsoft on 24/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.

import Foundation

// MARK: - CrimeData
struct CrimeData: Codable {
    let status, radius: String?
    let population, crimesLast12M, crimesPerThousand: Int?
    let crimeRating: String?
    let types: [String: Int]?
    let observations: [String]?
    let processTime: String?

    enum CodingKeys: String, CodingKey {
        case status, radius, population
        case crimesLast12M = "crimes_last_12m"
        case crimesPerThousand = "crimes_per_thousand"
        case crimeRating = "crime_rating"
        case types
        case observations = "observations"
        case processTime
    }
}

// MARK: CrimeData convenience initializers and mutators

extension CrimeData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CrimeData.self, from: data)
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
        population: Int?? = nil,
        crimesLast12M: Int?? = nil,
        crimesPerThousand: Int?? = nil,
        crimeRating: String?? = nil,
        types: [String: Int]?? = nil,
        observations: [String]?? = nil,
        processTime: String?? = nil
    ) -> CrimeData {
        return CrimeData(
            status: status ?? self.status,
            radius: radius ?? self.radius,
            population: population ?? self.population,
            crimesLast12M: crimesLast12M ?? self.crimesLast12M,
            crimesPerThousand: crimesPerThousand ?? self.crimesPerThousand,
            crimeRating: crimeRating ?? self.crimeRating,
            types: types ?? self.types,
            observations: observations ?? self.observations,
            processTime: processTime ?? self.processTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
