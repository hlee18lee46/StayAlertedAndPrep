import Foundation

struct Shelter: Identifiable, Codable {
    var id = UUID()  // Automatically generate a unique ID
    let name: String
    let vicinity: String?  // Make this optional
    
    enum CodingKeys: String, CodingKey {
        case name
        case vicinity = "address"  // Use the correct key based on the actual JSON
    }
}

struct ShelterResponse: Codable {
    let results: [Shelter]
}

