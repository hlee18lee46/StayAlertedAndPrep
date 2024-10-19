import Foundation

// Structure for a single flood alert
struct FloodAlert: Codable, Identifiable {
    var id: String { event }
    let event: String
    let headline: String
    let description: String
    let affectedAreas: String  // Change to a string since API returns a string

    enum CodingKeys: String, CodingKey {
        case event
        case headline
        case description
        case affectedAreas = "areaDesc"
    }
    
    // Custom decoder to handle both array and string for `areaDesc`
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        event = try container.decode(String.self, forKey: .event)
        headline = try container.decode(String.self, forKey: .headline)
        description = try container.decode(String.self, forKey: .description)

        // Handle `areaDesc` as either a string or an array
        if let areaDescArray = try? container.decode([String].self, forKey: .affectedAreas) {
            affectedAreas = areaDescArray.joined(separator: ", ")
        } else {
            affectedAreas = try container.decode(String.self, forKey: .affectedAreas)
        }
    }
}

// Structure for the flood alert API response
struct FloodAlertResponse: Codable {
    let features: [FloodAlertFeature]
}

struct FloodAlertFeature: Codable {
    let id: String
    let properties: FloodAlert
}
