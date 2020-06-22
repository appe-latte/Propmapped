// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rentData = try RentData(json)

import Foundation

// MARK: - RentData
struct RentData: Codable {
    let status, postcode, postcodeType: String?
    let url: String?
    let data: RentDataClass?
    let processTime: String?

    enum CodingKeys: String, CodingKey {
        case status, postcode
        case postcodeType = "postcode_type"
        case url, data
        case processTime = "process_time"
    }
}

// MARK: RentData convenience initializers and mutators

extension RentData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RentData.self, from: data)
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
        data: RentDataClass?? = nil,
        processTime: String?? = nil
    ) -> RentData {
        return RentData(
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

// MARK: - RentDataClass
struct RentDataClass: Codable {
    let longLet: LongLet?

    enum CodingKeys: String, CodingKey {
        case longLet = "long_let"
    }
}

// MARK: RentDataClass convenience initializers and mutators

extension RentDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RentDataClass.self, from: data)
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
        longLet: LongLet?? = nil
    ) -> RentDataClass {
        return RentDataClass(
            longLet: longLet ?? self.longLet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LongLet
struct LongLet: Codable {
    let pointsAnalysed: Int?
    let unit: String?
    let average: Int?
    let the70PCRange, the80PCRange, the90PCRange, the100PCRange: [Int]?
    let rawData: [RawDatum]?

    enum CodingKeys: String, CodingKey {
        case pointsAnalysed = "points_analysed"
        case unit, average
        case the70PCRange = "70pc_range"
        case the80PCRange = "80pc_range"
        case the90PCRange = "90pc_range"
        case the100PCRange = "100pc_range"
        case rawData = "raw_data"
    }
}

// MARK: LongLet convenience initializers and mutators

extension LongLet {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LongLet.self, from: data)
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
        unit: String?? = nil,
        average: Int?? = nil,
        the70PCRange: [Int]?? = nil,
        the80PCRange: [Int]?? = nil,
        the90PCRange: [Int]?? = nil,
        the100PCRange: [Int]?? = nil,
        rawData: [RawDatum]?? = nil
    ) -> LongLet {
        return LongLet(
            pointsAnalysed: pointsAnalysed ?? self.pointsAnalysed,
            unit: unit ?? self.unit,
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

// MARK: - RawDatum
struct RawDatum: Codable {
    let price: Int?
    let lat, lng: String?
    let type: TypeEnum?
}

// MARK: RawDatum convenience initializers and mutators

extension RawDatum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RawDatum.self, from: data)
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
        type: TypeEnum?? = nil
    ) -> RawDatum {
        return RawDatum(
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

enum TypeEnum: String, Codable {
    case detachedHouse = "Detached house"
    case flat = "Flat"
    case semiDetachedHouse = "Semi-detached house"
    case terracedHouse = "Terraced house"
}


