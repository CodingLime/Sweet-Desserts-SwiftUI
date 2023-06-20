import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let token: String
    let email: String
    let password: String
}

struct UserCredentials: Codable {
    let email: String
    let password: String
}

struct RegistrationData: Codable {
    let name: String
    let email: String
    let password: String
}

struct AuthToken: Codable {
    let token: String
}

/**
 Identifiable is a protocol from the SwiftUI framework. By conforming to Identifiable, the struct provides a way to uniquely identify instances of the Appetizer type.
 The protocol requires the struct to have a property called id of a type that conforms to the Hashable protocol. In this case, the id property is of type Int.
 
 Conforming to Identifiable is useful in SwiftUI because it allows you to use the struct instances in views that require a collection of identifiable elements, such as List or ForEach.
 SwiftUI can identify and track individual elements efficiently based on their unique id property.
 */
