import SwiftUI
import CoreLocation

struct GrocerySearchView: View {
    @StateObject private var groceryAPIService = GroceryAPIService()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {  // Wrap everything in NavigationView
            VStack {
                if let userLocation = locationManager.userLocation {
                    if groceryAPIService.groceryStores.isEmpty {
                        Text("Searching for grocery stores nearby...")
                            .onAppear {
                                groceryAPIService.searchForGroceryStores(near: userLocation.coordinate)
                            }
                    } else {
                        ScrollView {
                            ForEach(groceryAPIService.groceryStores, id: \.place_id) { store in
                                NavigationLink(destination: GroceryDetailView(grocery: store)) {  // Add NavigationLink
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(store.name)
                                            .font(.headline)

                                        Text(store.vicinity ?? "Unknown address")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        // Optionally, display distance if user's location is available
                                        if let userLoc = locationManager.userLocation {
                                            let storeLoc = CLLocation(latitude: store.geometry.location.lat,
                                                                      longitude: store.geometry.location.lng)
                                            let distance = userLoc.distance(from: storeLoc) / 1000  // distance in kilometers
                                            Text(String(format: "Distance: %.2f km", distance))
                                                .font(.subheadline)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .frame(maxWidth: .infinity)  // Ensure the width is consistent
                                }
                            }
                            .padding([.leading, .trailing], 15)  // Add padding on both sides
                        }
                    }
                } else {
                    Text("Detecting your location...")
                }
            }
            .padding(.top) // Final padding adjustment for layout
            .navigationTitle("Nearby Grocery Stores")
            .navigationBarTitleDisplayMode(.inline) // Use inline title to reduce top margin

            .onAppear {
                locationManager.startTracking()
            }
        }
    }
}
