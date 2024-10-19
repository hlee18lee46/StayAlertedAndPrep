import Foundation
import CoreLocation

class PharmacyAPIService: ObservableObject {
    @Published var pharmacies: [PharmacyPlace] = []

    // Function to search for pharmacies near a specific location
    func searchForPharmacies(near coordinate: CLLocationCoordinate2D) {
        let apiKey = "AIzaSyBMjCQSqjthzHMDx7K-c_BSAKxrew1xCZE" // Replace with your actual API key

        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=5000&type=pharmacy&key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Raw JSON Response: \(jsonResponse)")
                    
                    let response = try JSONDecoder().decode(PharmacyResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.pharmacies = response.results
                    }
                } catch {
                    print("Error decoding pharmacy data: \(error)")
                }
            } else if let error = error {
                print("Error fetching pharmacy data: \(error)")
            }
        }.resume()
    }
}

