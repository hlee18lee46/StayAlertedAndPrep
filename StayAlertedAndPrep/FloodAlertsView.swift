import SwiftUI

struct FloodAlertsView: View {
    @ObservedObject var apiService = APIService()  // Make sure you're observing the APIService

    var body: some View {
        VStack {
            Text("Flood Alerts for Florida")
                .font(.largeTitle)
                .padding()

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
                    }
                }
            }
        }
        .padding()
    }
}
