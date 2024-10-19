import Foundation

// Structure for an individual food place (e.g., grocery store)
struct FoodPlace: Codable, Identifiable {
    let place_id: String  // Google Places ID
    let name: String
    let vicinity: String?  // Vicinity is typically returned when formatted_address is absent
    let geometry: FoodGeometry  // Holds location data
    var id: String { place_id }  // Conformance to Identifiable
}

// Structure for geometry
struct FoodGeometry: Codable {
    let location: FoodLocation
}

// Structure for the location
struct FoodLocation: Codable {
    let lat: Double
    let lng: Double
}

// Structure for the API response
struct FoodResponse: Codable {
    let results: [FoodPlace]
}
