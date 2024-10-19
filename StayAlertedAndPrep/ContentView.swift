import SwiftUI
import MapKit
import Combine

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default location (e.g., San Francisco)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        TabView {
            SheltersView()
                .tabItem {
                    Label("Shelters", systemImage: "house.fill")
                }
            // Flood Zone Tab
            Text("Flood Zone")
                .tabItem {
                    Image(systemName: "cloud.rain")
                    Text("Flood Zone")
                }
            FloodAlertsView()
                .tabItem {
                    Label("Flood Alert", systemImage: "cloud.rain")
                }
            // Hurricane Tracker Tab
            Text("Hurricane Tracker")
                .tabItem {
                    Image(systemName: "tropicalstorm")
                    Text("Hurricane Tracker")
                }

            // Disaster News Tab - Displays FEMA API Data
            DisasterNewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Disaster News")
                }

            // Food Search Tab (Sign-in Required)
            Text("Food Search (Sign-in Required)")
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Food Search")
                }

            // Medication Search Tab (Sign-in Required)
            Text("Medication Search (Sign-in Required)")
                .tabItem {
                    Image(systemName: "pills")
                    Text("Medication Search")
                }

            // Health Care Tab (Sign-in Required)
            Text("Health Care (Sign-in Required)")
                .tabItem {
                    Image(systemName: "heart.text.square")
                    Text("Health Care")
                }
        }
        .onAppear {
            locationManager.startTracking()  // Start location tracking
        }
    }
}
