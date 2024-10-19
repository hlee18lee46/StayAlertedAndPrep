import SwiftUI
import MapKit
import Combine

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default location (e.g., San Francisco)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var showLandingPage = true // Initially show the landing page

    var body: some View {
        if showLandingPage {
            LandingPageView(showLandingPage: $showLandingPage)
        } else {
            TabView {
                FloodAlertsView()
                    .tabItem {
                        Label("Flood Alert", systemImage: "cloud.rain")
                    }
                
                // Disaster News Tab - Displays FEMA API Data
                DisasterNewsView()
                    .tabItem {
                        Image(systemName: "newspaper")
                        Text("Disaster News")
                    }
                GrocerySearchView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Grocery Stores")
                    }
                /*
                 MoreView()  // Add this line
                 .tabItem {
                 Label("More", systemImage: "ellipsis")
                 }
                 */
                SheltersView()
                    .tabItem {
                        Label("Shelters", systemImage: "house.fill")
                    }
                
                
                
                // Food Search Tab (Sign-in Required)
                /*
                 Text("Food Search")
                 .tabItem {
                 Image(systemName: "fork.knife")
                 Text("Food Search")
                 }
                 */
                // Medication Search Tab (Sign-in Required)
                PharmacySearchView()  // Add the PharmacySearchView here
                    .tabItem {
                        Label("Pharmacies", systemImage: "cross.fill")
                    }
                
            }
            .onAppear {
                locationManager.startTracking()  // Start location tracking
            }
        }
    }
}
