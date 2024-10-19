import SwiftUI
import CoreLocation

struct SheltersView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var apiService = APIService()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {

                if let county = locationManager.userCounty {
                    if apiService.shelters.isEmpty {
                        Text("Loading shelters in \(county)...")
                            .padding(.horizontal)
                            .onAppear {
                                apiService.getShelters(forCounty: county)
                            }
                    } else {
                        ScrollView {
                            VStack(spacing: 15) { // Added spacing between cards
                                ForEach(apiService.shelters, id: \.place_id) { shelter in
                                    NavigationLink(destination: ShelterDetailView(shelter: shelter)) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(shelter.name)
                                                .font(.headline)
                                                .foregroundColor(.blue)

                                            Text(shelter.formatted_address ?? "Unknown address")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)

                                            // Display distance
                                            if let userLocation = locationManager.userLocation {
                                                let shelterLocation = CLLocation(latitude: shelter.geometry.location.lat,
                                                                                 longitude: shelter.geometry.location.lng)
                                                let distance = userLocation.distance(from: shelterLocation) / 1000 // distance in kilometers
                                                Text(String(format: "Distance: %.2f km", distance))
                                                    .font(.subheadline)
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding() // Padding inside each card
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white)
                                                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle()) // Remove default link style
                                }
                            }
                            .padding(.horizontal) // Apply padding to the list of shelters
                        }
                    }
                } else {
                    Text("Detecting your county...")
                        .padding(.horizontal)
                }
            }
            .padding(.top) // Final padding adjustment for layout
            .navigationTitle("Hurricane Shelters")
            .navigationBarTitleDisplayMode(.inline) // Use inline title to reduce top margin

        }
    }
}
