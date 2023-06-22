import Foundation

struct Dessert: Identifiable, Codable {
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
    let description: String
    let calories: Int
    let duration: Int
    let easeOfMaking: String
}
// let ingredients: String // example "- 1 3/4 cups plain / all purpose flour\r\n- 3/4 cup cocoa powder"
// let instructions: String // example "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\n"
/**
 Identifiable is a protocol from the SwiftUI framework. By conforming to Identifiable, the struct provides a way to uniquely identify instances of the Appetizer type.
 The protocol requires the struct to have a property called id of a type that conforms to the Hashable protocol. In this case, the id property is of type Int.
 
 Conforming to Identifiable is useful in SwiftUI because it allows you to use the struct instances in views that require a collection of identifiable elements, such as List or ForEach.
 SwiftUI can identify and track individual elements efficiently based on their unique id property.
 */

/**
 Decodable is a protocol from the Swift standard library.
 By conforming to Decodable, the struct specifies that it can be decoded from external representation, typically from JSON or other serialized formats.
 
 Conforming to Decodable allows you to initialize instances of the Appetizer struct from JSON data without manually parsing the data.
 By providing the necessary properties and conforming to the coding keys convention, you can use JSONDecoder to decode the JSON data into instances of the Dessert struct easily.
 */

struct DessertResponse: Decodable {
    let request: [Dessert]
}


struct MockData {
    
    static let appetizers = [sampleDessert, sampleDessert, sampleDessert]
    
    static let sampleDessert = Dessert(id: 0000001,
                                       name: "Chocolate Cake",
                                       price: 9.99,
                                       imageURL: "images/Chocolate_Cake.jpg",
                                       description: "Moist chocolate cake",
                                       calories: 350,
                                       duration: 25,
                                       easeOfMaking: "Easy")
}
