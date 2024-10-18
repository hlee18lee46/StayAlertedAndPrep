//
//  StayAlertedAndPrepApp.swift
//  StayAlertedAndPrep
//
//  Created by Han Lee on 10/18/24.
//

import SwiftUI

@main
struct StayAlertedAndPrepApp: App {
    @StateObject private var locationManager = LocationManager()  // Initialize LocationManager

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)  // Pass LocationManager as an environment object
        }
    }
}
