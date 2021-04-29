//
//  User.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-28.
//

import Foundation

struct User: Codable {

    var name: Name
    var location: Location
    var email: String
    var dob: DateOfBirth
    var phone: String
    var picture: Picture
    var nat: String
    
}

struct Name: Codable {
    var title, first, last: String
}

struct Location: Codable {
    var street: Street
    var city, state, country: String
    var postcode: PostCode
}

enum PostCode: Codable {
    case int(Int)
    case string(String)
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = .int(try container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            self = .string(try container.decode(String.self))
        }
    }
}

struct Street: Codable {
    var number: Int
    var name: String
}

struct DateOfBirth: Codable {
    var date: String
    var age: Int
}

struct Picture: Codable {
    var large, medium: String
}
