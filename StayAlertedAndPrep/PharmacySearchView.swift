import SwiftUI
import CoreLocation

struct PharmacySearchView: View {
    @StateObject private var pharmacyAPIService = PharmacyAPIService()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {

                if let userLocation = locationManager.userLocation {
                    if pharmacyAPIService.pharmacies.isEmpty {
                        Text("Searching for pharmacies nearby...")
                            .onAppear {
                                pharmacyAPIService.searchForPharmacies(near: userLocation.coordinate) // Extract coordinate
                            }
                    } else {
                        ScrollView {
                            VStack(spacing: 15) { // Added spacing between cards
                                ForEach(pharmacyAPIService.pharmacies, id: \.place_id) { pharmacy in
                                    NavigationLink(destination: PharmacyDetailView(pharmacy: pharmacy)) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(pharmacy.name)
                                                .font(.headline)
                                                .foregroundColor(.blue)

                                            Text(pharmacy.vicinity ?? "Unknown address")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)

                                            // Display distance
                                            if let userLocation = locationManager.userLocation {
                                                let pharmacyLocation = CLLocation(latitude: pharmacy.geometry.location.lat,
                                                                                 longitude: pharmacy.geometry.location.lng)
                                                let distance = userLocation.distance(from: pharmacyLocation) / 1000 // distance in kilometers
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
                            .padding(.horizontal) // Apply padding to the list of pharmacies
                        }
                    }
                } else {
                    Text("Detecting your location...")
                        .padding(.horizontal)
                }
            }
            .padding(.top) // Final padding adjustment for layout
            .navigationTitle("Nearby Pharmacies")
            .navigationBarTitleDisplayMode(.inline) // Use inline title to reduce top margin
        }
    }
}
