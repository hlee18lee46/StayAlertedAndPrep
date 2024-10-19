import SwiftUI
import MapKit

struct GroceryDetailView: View {
    var grocery: FoodPlace

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(grocery.name)
                .font(.largeTitle)
                .padding()

            // Use formatted_address instead of vicinity
            Text(grocery.vicinity ?? "Address not available")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            // Display a map with the location of the grocery store
            MapView(coordinate: CLLocationCoordinate2D(latitude: grocery.geometry.location.lat,
                                                       longitude: grocery.geometry.location.lng))
                .frame(height: 300)
                .cornerRadius(10)
                .padding()

            Spacer()
        }
        .navigationTitle("Grocery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
