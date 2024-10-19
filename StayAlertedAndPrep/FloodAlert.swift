//
//  FloodAlert.swift
//  StayAlertedAndPrep
//
//  Created by Han Lee on 10/18/24.
//

import Foundation

// Structure for a single flood alert
struct FloodAlert: Codable, Identifiable {
    var id: String { event }
    let event: String
    let headline: String
    let description: String
    let affectedAreas: [String]
    
    enum CodingKeys: String, CodingKey {
        case event
        case headline
        case description
        case affectedAreas = "areaDesc"
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
