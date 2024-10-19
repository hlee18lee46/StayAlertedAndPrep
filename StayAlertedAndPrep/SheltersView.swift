import SwiftUI

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
                        ForEach(apiService.shelters, id: \.place_id) { shelter in  // Use place_id for unique identification
                            VStack(alignment: .leading, spacing: 10) {
                                Text(shelter.name)
                                    .font(.headline)

                                Text(shelter.formatted_address ?? "Unknown address")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
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
