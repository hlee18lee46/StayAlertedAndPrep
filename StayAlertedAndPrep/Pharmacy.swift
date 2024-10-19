import Foundation

// Structure for an individual pharmacy
struct PharmacyPlace: Codable, Identifiable {
    let place_id: String  // Google Places ID
    let name: String
    let formatted_address: String?  // Optional since it might not always be present
    let vicinity: String?  // Optional vicinity field
    let geometry: PharmacyGeometry  // Location information
    var id: String { place_id }  // Conformance to Identifiable
}

// Structure for geometry (renamed to `PharmacyGeometry` to avoid conflicts)
struct PharmacyGeometry: Codable {
    let location: PharmacyLocation  // Renamed from `Location`
}

// Structure for the location (renamed to `PharmacyLocation` to avoid conflicts)
struct PharmacyLocation: Codable {
    let lat: Double
    let lng: Double
}

// Structure for the API response
struct PharmacyResponse: Codable {
    let results: [PharmacyPlace]  // Results array contains pharmacy places
}
