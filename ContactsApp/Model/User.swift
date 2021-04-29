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
    var city, state, country, postcode: String
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
