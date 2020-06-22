// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let askingData = try AskingData(json)

import Foundation

// MARK: - AskingData
struct AskingData: Codable {
    let status, postcode, postcodeType: String?
    let url: String?
    let data: AskingDataClass?
    let processTime: String?

    enum CodingKeys: String, CodingKey {
        case status, postcode
        case postcodeType = "postcode_type"
        case url, data
        case processTime = "process_time"
    }
}

// MARK: AskingData convenience initializers and mutators

extension AskingData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AskingData.self, from: data)
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
        url: String?? = nil,
        data: AskingDataClass?? = nil,
        processTime: String?? = nil
    ) -> AskingData {
        return AskingData(
            status: status ?? self.status,
            postcode: postcode ?? self.postcode,
            postcodeType: postcodeType ?? self.postcodeType,
            url: url ?? self.url,
            data: data ?? self.data,
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

// MARK: - AskingDataClass
struct AskingDataClass: Codable {
    let pointsAnalysed, average: Int?
    let the70PCRange, the80PCRange, the90PCRange, the100PCRange: [Int]?
    let rawData: [RawAskingDatum]?

    enum CodingKeys: String, CodingKey {
        case pointsAnalysed = "points_analysed"
        case average
        case the70PCRange = "70pc_range"
        case the80PCRange = "80pc_range"
        case the90PCRange = "90pc_range"
        case the100PCRange = "100pc_range"
        case rawData = "raw_data"
    }
}

// MARK: AskingDataClass convenience initializers and mutators

extension AskingDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AskingDataClass.self, from: data)
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
        pointsAnalysed: Int?? = nil,
        average: Int?? = nil,
        the70PCRange: [Int]?? = nil,
        the80PCRange: [Int]?? = nil,
        the90PCRange: [Int]?? = nil,
        the100PCRange: [Int]?? = nil,
        rawData: [RawAskingDatum]?? = nil
    ) -> AskingDataClass {
        return AskingDataClass(
            pointsAnalysed: pointsAnalysed ?? self.pointsAnalysed,
            average: average ?? self.average,
            the70PCRange: the70PCRange ?? self.the70PCRange,
            the80PCRange: the80PCRange ?? self.the80PCRange,
            the90PCRange: the90PCRange ?? self.the90PCRange,
            the100PCRange: the100PCRange ?? self.the100PCRange,
            rawData: rawData ?? self.rawData
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RawAskingDatum
struct RawAskingDatum: Codable {
    let price: Int?
    let lat, lng: String?
    let type: PropTypeEnum?
}

// MARK: RawAskingDatum convenience initializers and mutators

extension RawAskingDatum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RawAskingDatum.self, from: data)
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
        price: Int?? = nil,
        lat: String?? = nil,
        lng: String?? = nil,
        type: PropTypeEnum?? = nil
    ) -> RawAskingDatum {
        return RawAskingDatum(
            price: price ?? self.price,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum PropTypeEnum: String, Codable {
    case detachedHouse = "Detached house"
    case flat = "Flat"
    case semiDetachedHouse = "Semi-detached house"
    case terracedHouse = "Terraced house"
}

// MARK: - Helper functions for creating encoders and decoders
