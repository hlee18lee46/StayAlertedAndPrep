import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    @Published var userLocation: CLLocation? = nil
    @Published var status: CLAuthorizationStatus? = nil
    @Published var userCounty: String? = nil  // To store the user's county
    @Published var userCity: String? = nil    // To store the user's city
    @Published var userState: String? = nil   // To store the user's state

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationPermissions()
    }

    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location
            reverseGeocode(location: location)  // Perform reverse geocoding when location is updated
        }
    }

    // Reverse geocoding to get county, city, and state
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                // Extract the county (or subAdministrativeArea)
                if let county = placemark.subAdministrativeArea {
                    DispatchQueue.main.async {
                        self.userCounty = county
                    }
                }
                // Extract the city (locality)
                if let city = placemark.locality {
                    DispatchQueue.main.async {
                        self.userCity = city
                    }
                }
                // Extract the state (administrativeArea)
                if let state = placemark.administrativeArea {
                    DispatchQueue.main.async {
                        self.userState = state
                    }
                }
            } else if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.status = manager.authorizationStatus
        if self.status == .authorizedWhenInUse || self.status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}
