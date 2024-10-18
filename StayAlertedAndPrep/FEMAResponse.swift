//
//  FEMAResponse.swift
//  StayAlertedAndPrep
//
//  Created by Han Lee on 10/18/24.
//

import Foundation

// Structure for a single disaster declaration summary
struct DisasterSummary: Codable, Identifiable {
    var id: String { declarationTitle }  // Use declarationTitle as an id
    let declarationTitle: String
    let declarationDate: String
}

// Structure for the response from the FEMA API
struct FEMAResponse: Codable {
    let metadata: Metadata
    let disasterSummaries: [DisasterSummary]
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case disasterSummaries = "DisasterDeclarationsSummaries"
    }
}

// Metadata structure
struct Metadata: Codable {
    let count: Int
}
