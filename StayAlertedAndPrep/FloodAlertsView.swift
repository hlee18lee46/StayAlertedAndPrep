import SwiftUI

struct FloodAlertsView: View {
    @ObservedObject var apiService = APIService()  // Observing the APIService

    var body: some View {
        VStack {
            Text("Flood Alerts for Florida")
                .font(.largeTitle)
                .padding()

            if apiService.floodAlerts.isEmpty {
                Text("Loading flood alerts...") // Display while data is loading
                    .onAppear {
                        apiService.getFloodAlerts()  // Fetch the flood alerts when the view appears
                    }
            } else {
                ScrollView {
                    ForEach(apiService.floodAlerts, id: \.id) { alert in  // Iterate over the flood alerts
                        VStack(alignment: .leading, spacing: 10) {
                            Text(alert.event)  // Display the event name
                                .font(.headline)

                            Text(alert.headline)  // Display the headline
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text(alert.description)  // Display the description
                                .font(.body)
                                .padding(.top, 5)

                            Text("Affected Areas:")
                                .font(.caption)
                                .padding(.top, 5)

                            ForEach(alert.affectedAreas, id: \.self) { area in
                                Text(area)  // Display affected areas
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                    }
                }
            }
        }
        .padding()
    }
}
