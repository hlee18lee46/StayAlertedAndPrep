import SwiftUI
import CoreLocation

struct PharmacyDetailView: View {
    let pharmacy: PharmacyPlace  // Use PharmacyPlace instead of FoodPlace

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(pharmacy.name)
                .font(.largeTitle)
                .padding(.bottom)

            Text(pharmacy.formatted_address ?? "Unknown address")  // Using formatted_address for pharmacy address
                .font(.subheadline)
                .foregroundColor(.gray)

            // Map view to show the pharmacy location
            MapView(coordinate: CLLocationCoordinate2D(latitude: pharmacy.geometry.location.lat,
                                                       longitude: pharmacy.geometry.location.lng))
                .frame(height: 300)
                .cornerRadius(15)
                .shadow(radius: 5)

            Spacer()
        }
        .padding()
        .navigationTitle(pharmacy.name)
    }
}
