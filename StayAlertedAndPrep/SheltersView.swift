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
                        ForEach(apiService.shelters, id: \.id) { shelter in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(shelter.name)
                                    .font(.headline)
                                
                                Text(shelter.vicinity ?? "Unknown vicinity")
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
