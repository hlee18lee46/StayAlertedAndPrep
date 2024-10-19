import Foundation
import CoreLocation

class GroceryAPIService: ObservableObject {
    @Published var groceryStores: [FoodPlace] = []

    func searchForGroceryStores(near coordinate: CLLocationCoordinate2D) {
        let apiKey = "AIzaSyBMjCQSqjthzHMDx7K-c_BSAKxrew1xCZE" // Replace with your actual API key
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=5000&type=grocery_or_supermarket&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Print the raw JSON response for debugging
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Raw JSON Response: \(json)")
                    }
                    
                    let groceryResponse = try JSONDecoder().decode(FoodResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.groceryStores = groceryResponse.results
                    }
                } catch {
                    print("Error decoding grocery store data: \(error)")
                }
            } else if let error = error {
                print("Error fetching grocery stores: \(error)")
            }
        }.resume()
    }
}
