import SwiftUI
import MapKit

struct ShelterDetailView: View {
    var shelter: Shelter

    @State private var region: MKCoordinateRegion

    init(shelter: Shelter) {
        self.shelter = shelter
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: shelter.geometry.location.lat,
                                           longitude: shelter.geometry.location.lng),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(shelter.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)  // Limit to one line
                .truncationMode(.tail)  // Truncate with ellipsis
                .padding(.horizontal)

            Text(shelter.formatted_address ?? "Unknown address")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)

            // Add a Map view for the shelter location
            Map(coordinateRegion: $region, annotationItems: [shelter]) { shelter in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: shelter.geometry.location.lat,
                                                             longitude: shelter.geometry.location.lng),
                          tint: .red)
            }
            .frame(height: 300)  // Set a fixed height for the map
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Shelter Details", displayMode: .inline)
    }
}
