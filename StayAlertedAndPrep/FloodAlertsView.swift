import SwiftUI

struct FloodAlertsView: View {
    @ObservedObject var apiService = APIService()  // Make sure you're observing the APIService

    var body: some View {
        VStack {

            if apiService.floodAlerts.isEmpty {
                Text("Loading flood alerts...") // Display while data is loading
                    .onAppear {
                        apiService.getFloodAlerts()  // Fetch the flood alerts on view load
                    }
            } else {
                ScrollView {
                    ForEach(apiService.floodAlerts, id: \.id) { alert in  // Bind `id` correctly
                        VStack(alignment: .leading, spacing: 10) {
                            Text(alert.event) // Display event title
                                .font(.headline)
                            Text(alert.description) // Display event description
                                .font(.subheadline)
                            Text("Affected Areas: \(alert.affectedAreas)")  // Display affected areas
                                .font(.footnote)
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
        }
        .padding(.top) // Final padding adjustment for layout
        .navigationTitle("Flood Alerts")
        .navigationBarTitleDisplayMode(.inline) // Use inline title to reduce top margin
    }
}
