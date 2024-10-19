import Foundation

// Structure for an individual shelter
struct Shelter: Codable, Identifiable {
    let place_id: String  // Google Places ID, using this as a unique identifier
    let name: String
    let formatted_address: String?  // Optional since it might not always be present

    // Conformance to Identifiable protocol
    var id: String { place_id }

    enum CodingKeys: String, CodingKey {
        case place_id
        case name
        case formatted_address
    }
}

// Structure for the API response
struct ShelterResponse: Codable {
    let results: [Shelter]  // Results array contains shelters
}
