// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let demographics = try Demographics(json)

import Foundation

// MARK: - Demographics
struct Demographics: Codable {
    let status, postcode, postcodeType: String?
    let url: String?
    let data: DemoDataClass?
    let processTime: String?
    
    enum CodingKeys: String, CodingKey {
        case status, postcode
        case postcodeType = "postcode_type"
        case url
        case data = "data"
        case processTime = "process_time"
    }
}

// MARK: Demographics convenience initializers and mutators

extension Demographics {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Demographics.self, from: data)
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
        data: DemoDataClass?? = nil,
        processTime: String?? = nil
    ) -> Demographics {
        return Demographics(
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

// MARK: - DemoDataClass
struct DemoDataClass: Codable {
    let deprivation, health: Int?
    let socialGrade: SocialGrade?
    let age: Age?
    let politics: Politics?
    let proportionWithDegree: Int?
    let vehiclesPerHousehold: String?
    let commuteMethod: CommuteMethod?
    
    enum CodingKeys: String, CodingKey {
        case deprivation, health
        case socialGrade = "social_grade"
        case age, politics
        case proportionWithDegree = "proportion_with_degree"
        case vehiclesPerHousehold = "vehicles_per_household"
        case commuteMethod = "commute_method"
    }
}

// MARK: DemoDataClass convenience initializers and mutators

extension DemoDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DemoDataClass.self, from: data)
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
        deprivation: Int?? = nil,
        health: Int?? = nil,
        socialGrade: SocialGrade?? = nil,
        age: Age?? = nil,
        politics: Politics?? = nil,
        proportionWithDegree: Int?? = nil,
        vehiclesPerHousehold: String?? = nil,
        commuteMethod: CommuteMethod?? = nil
    ) -> DemoDataClass {
        return DemoDataClass(
            deprivation: deprivation ?? self.deprivation,
            health: health ?? self.health,
            socialGrade: socialGrade ?? self.socialGrade,
            age: age ?? self.age,
            politics: politics ?? self.politics,
            proportionWithDegree: proportionWithDegree ?? self.proportionWithDegree,
            vehiclesPerHousehold: vehiclesPerHousehold ?? self.vehiclesPerHousehold,
            commuteMethod: commuteMethod ?? self.commuteMethod
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Age

struct Age: Codable {
    let the04, the59, the1014, the1519: String?
    let the2024, the2529, the3034, the3539: String?
    let the4044, the4549, the5054, the5559: String?
    let the6064, the6569, the7074, the7579: String?
    let the8084, the8589: String?
    
    enum CodingKeys: String, CodingKey {
        case the04 = "0-4"
        case the59 = "5-9"
        case the1014 = "10-14"
        case the1519 = "15-19"
        case the2024 = "20-24"
        case the2529 = "25-29"
        case the3034 = "30-34"
        case the3539 = "35-39"
        case the4044 = "40-44"
        case the4549 = "45-49"
        case the5054 = "50-54"
        case the5559 = "55-59"
        case the6064 = "60-64"
        case the6569 = "65-69"
        case the7074 = "70-74"
        case the7579 = "75-79"
        case the8084 = "80-84"
        case the8589 = "85-89"
    }
}


// MARK: Age convenience initializers and mutators

extension Age {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Age.self, from: data)
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
        the04: String?? = nil,
        the59: String?? = nil,
        the1014: String?? = nil,
        the1519: String?? = nil,
        the2024: String?? = nil,
        the2529: String?? = nil,
        the3034: String?? = nil,
        the3539: String?? = nil,
        the4044: String?? = nil,
        the4549: String?? = nil,
        the5054: String?? = nil,
        the5559: String?? = nil,
        the6064: String?? = nil,
        the6569: String?? = nil,
        the7074: String?? = nil,
        the7579: String?? = nil,
        the8084: String?? = nil,
        the8589: String?? = nil
    ) -> Age {
        return Age(
            the04: the04 ?? self.the04,
            the59: the59 ?? self.the59,
            the1014: the1014 ?? self.the1014,
            the1519: the1519 ?? self.the1519,
            the2024: the2024 ?? self.the2024,
            the2529: the2529 ?? self.the2529,
            the3034: the3034 ?? self.the3034,
            the3539: the3539 ?? self.the3539,
            the4044: the4044 ?? self.the4044,
            the4549: the4549 ?? self.the4549,
            the5054: the5054 ?? self.the5054,
            the5559: the5559 ?? self.the5559,
            the6064: the6064 ?? self.the6064,
            the6569: the6569 ?? self.the6569,
            the7074: the7074 ?? self.the7074,
            the7579: the7579 ?? self.the7579,
            the8084: the8084 ?? self.the8084,
            the8589: the8589 ?? self.the8589
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CommuteMethod
struct CommuteMethod: Codable {
    let atHome, undergroundLightRail, train, bus: String?
    let taxi, motorcycle, carDriver, carPassenger: String?
    let bicycle, foot, other: String?
    
    enum CodingKeys: String, CodingKey {
        case atHome = "at_home"
        case undergroundLightRail = "underground_light_rail"
        case train, bus, taxi, motorcycle
        case carDriver = "car_driver"
        case carPassenger = "car_passenger"
        case bicycle, foot, other
    }
}

// MARK: CommuteMethod convenience initializers and mutators

extension CommuteMethod {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CommuteMethod.self, from: data)
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
        atHome: String?? = nil,
        undergroundLightRail: String?? = nil,
        train: String?? = nil,
        bus: String?? = nil,
        taxi: String?? = nil,
        motorcycle: String?? = nil,
        carDriver: String?? = nil,
        carPassenger: String?? = nil,
        bicycle: String?? = nil,
        foot: String?? = nil,
        other: String?? = nil
    ) -> CommuteMethod {
        return CommuteMethod(
            atHome: atHome ?? self.atHome,
            undergroundLightRail: undergroundLightRail ?? self.undergroundLightRail,
            train: train ?? self.train,
            bus: bus ?? self.bus,
            taxi: taxi ?? self.taxi,
            motorcycle: motorcycle ?? self.motorcycle,
            carDriver: carDriver ?? self.carDriver,
            carPassenger: carPassenger ?? self.carPassenger,
            bicycle: bicycle ?? self.bicycle,
            foot: foot ?? self.foot,
            other: other ?? self.other
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Politics
struct Politics: Codable {
    let results: Results?
    let constituences: [String]?
}

// MARK: Politics convenience initializers and mutators

extension Politics {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Politics.self, from: data)
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
        results: Results?? = nil,
        constituences: [String]?? = nil
    ) -> Politics {
        return Politics(
            results: results ?? self.results,
            constituences: constituences ?? self.constituences
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Results
struct Results: Codable {
    let conservative, labour, liberalDemocrats, ukip: String?
    let greenParty: String?
    
    enum CodingKeys: String, CodingKey {
        case conservative = "Conservative"
        case labour = "Labour"
        case liberalDemocrats = "Liberal Democrats"
        case ukip = "UKIP"
        case greenParty = "Green Party"
    }
}

// MARK: Results convenience initializers and mutators

extension Results {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Results.self, from: data)
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
        conservative: String?? = nil,
        labour: String?? = nil,
        liberalDemocrats: String?? = nil,
        ukip: String?? = nil,
        greenParty: String?? = nil
    ) -> Results {
        return Results(
            conservative: conservative ?? self.conservative,
            labour: labour ?? self.labour,
            liberalDemocrats: liberalDemocrats ?? self.liberalDemocrats,
            ukip: ukip ?? self.ukip,
            greenParty: greenParty ?? self.greenParty
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SocialGrade
struct SocialGrade: Codable {
    let ab, c1, c2, de: String?
}

// MARK: SocialGrade convenience initializers and mutators

extension SocialGrade {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SocialGrade.self, from: data)
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
        ab: String?? = nil,
        c1: String?? = nil,
        c2: String?? = nil,
        de: String?? = nil
    ) -> SocialGrade {
        return SocialGrade(
            ab: ab ?? self.ab,
            c1: c1 ?? self.c1,
            c2: c2 ?? self.c2,
            de: de ?? self.de
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

