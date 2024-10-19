import SwiftUI
import CoreLocation

struct PharmacyDetailView: View {
    let pharmacy: PharmacyPlace  // Use PharmacyPlace instead of FoodPlace

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(pharmacy.name)
                .font(.largeTitle)
                .padding(.bottom)
                .lineLimit(1)  // Limit to one line
                .truncationMode(.tail)  // Truncate with ellipsis
                .padding(.horizontal)
            Text(pharmacy.vicinity ?? "Unknown address")  // Using formatted_address for pharmacy address
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            // Map view to show the pharmacy location
            MapView(coordinate: CLLocationCoordinate2D(latitude: pharmacy.geometry.location.lat,
                                                       longitude: pharmacy.geometry.location.lng))
                .frame(height: 300)
                .cornerRadius(12)
                .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Pharmacy Details", displayMode: .inline)
    }
}


