import SwiftUI
import CoreLocation

struct SheltersView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var apiService = APIService()

    var body: some View {
        VStack {
            Text("Nearby Hurricane Shelters")
                .font(.largeTitle)
                .padding()

            if let county = locationManager.userCounty {
                if apiService.shelters.isEmpty {
                    Text("Loading shelters in \(county)...")
                        .onAppear {
                            apiService.getShelters(forCounty: county)
                        }
                } else {
                    ScrollView {
                        ForEach(apiService.shelters, id: \.place_id) { shelter in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(shelter.name)
                                    .font(.headline)

                                Text(shelter.formatted_address ?? "Unknown address")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                // Calculate and display distance if user's location is available
                                if let userLocation = locationManager.userLocation {
                                    let shelterLocation = CLLocation(latitude: shelter.geometry.location.lat,
                                                                     longitude: shelter.geometry.location.lng)
                                    let distance = userLocation.distance(from: shelterLocation) / 1000 // distance in kilometers
                                    Text(String(format: "Distance: %.2f km", distance))
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                        }
                    }
                }
            } else {
                Text("Detecting your county...")
            }
        }
        .padding()
    }
}
