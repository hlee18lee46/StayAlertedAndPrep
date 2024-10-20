import SwiftUI

struct DisasterNewsView: View {
    @ObservedObject var apiService = APIService()
    @EnvironmentObject var locationManager: LocationManager
    @State private var stateName: String? = nil
    
    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {

                // Show the disaster data once fetched
                if apiService.disasterSummaries.isEmpty {
                    Text("Fetching disaster data...")
                        .onAppear {
                            apiService.reverseGeocode(location: userLocation) { state in
                                if let state = state {
                                    self.stateName = state // Store the state name
                                    apiService.getDisasterDataBasedOnState(state: state)
                                } else {
                                    print("Unable to retrieve state from location.")
                                }
                            }
                        }
                } else if apiService.disasterSummaries.isEmpty {
                    // No disasters found, show the message with the state name
                    Text("No recent disasters found in the last 30 days for \(stateName ?? "your state").")
                        .padding()
                } else {
                    ScrollView {
                        ForEach(apiService.disasterSummaries) { summary in
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Disaster Declaration: \(summary.declarationTitle)")
                                    .font(.headline)
                                Text("Date: \(summary.declarationDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(maxWidth: .infinity)  // Ensure the width is consistent
                        }
                    }
                }
            } else {
                Text("Fetching location...")
            }
        }
        .padding(.top) // Final padding adjustment for layout
        .navigationTitle("Disaster")
        .navigationBarTitleDisplayMode(.inline) // Use inline title to reduce top margin
        .onAppear {
            locationManager.startTracking()  // Start location tracking again
        }
        .onDisappear {
            locationManager.stopTracking()  // Optionally stop location tracking
        }
    }
}
