import CoreLocation
import Foundation


class APIService: ObservableObject {
    @Published var disasterSummaries: [DisasterSummary] = []
    @Published var stateName: String? = ""
    @Published var floodAlerts: [FloodAlert] = []  // Ensure this exists
    @Published var shelters: [Shelter] = []
    // Fetch Flood Alerts
    func getShelters(forCounty county: String) {
        let apiKey = "AIzaSyBMjCQSqjthzHMDx7K-c_BSAKxrew1xCZE"
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=hurricane+shelters+in+\(county)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Print the raw JSON response for debugging
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Raw JSON: \(json)")  // Ensure you print the raw JSON to debug

                    // Decode the ShelterResponse
                    let response = try JSONDecoder().decode(ShelterResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.shelters = response.results
                    }
                } catch {
                    print("Error decoding shelter data: \(error)")
                }
            } else if let error = error {
                print("Error fetching shelter data: \(error)")
            }
        }.resume()
    }
    func getFloodAlerts() {
        let url = URL(string: "https://api.weather.gov/alerts/active?area=FL")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let floodAlertResponse = try JSONDecoder().decode(FloodAlertResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.floodAlerts = floodAlertResponse.features.map { $0.properties }
                    }
                    print("Fetched Flood Alerts: \(floodAlertResponse)")
                } catch {
                    print("Error decoding flood alerts: \(error)")
                }
            } else if let error = error {
                print("Error fetching flood alerts: \(error)")
            }
        }.resume()
    }
    func getDisasterDataBasedOnState(state: String) {
        // Store state name for display purposes
        self.stateName = state
        
        // FEMA Open API URL
        let femaURL = "https://www.fema.gov/api/open/v2/DisasterDeclarationsSummaries"
        
        // Date range: Last 60 days
        let iso8601DateFormatter = ISO8601DateFormatter()
        let currentDate = Date()
        let sixtyDaysAgo = Calendar.current.date(byAdding: .day, value: -60, to: currentDate)!
        let currentDateString = iso8601DateFormatter.string(from: currentDate)
        let sixtyDaysAgoString = iso8601DateFormatter.string(from: sixtyDaysAgo)
        
        // Build URL with state filter and date range
        guard let url = URL(string: "\(femaURL)?$filter=state eq '\(state)' and declarationDate ge '\(sixtyDaysAgoString)' and declarationDate le '\(currentDateString)'") else {
            print("Invalid URL")
            return
        }

        // Create the URLSession task
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let femaResponse = try JSONDecoder().decode(FEMAResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.disasterSummaries = femaResponse.disasterSummaries
                    }
                    print("Fetched Disaster Data: \(femaResponse)")
                } catch {
                    print("Error decoding disaster data: \(error)")
                }
            } else if let error = error {
                print("Error fetching disaster data: \(error)")
            }
        }.resume()
    }
    
    func reverseGeocode(location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first, let state = placemark.administrativeArea {
                completion(state)  // Return the state abbreviation (e.g., FL, CA)
            } else {
                completion(nil)
            }
        }
    }
}
