import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    @Published var userLocation: CLLocation? = nil
    @Published var status: CLAuthorizationStatus? = nil
    @Published var userCounty: String? = nil  // To store the user's county
    
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

    // Reverse geocoding to get county or administrative area
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                // Extract the county (or subAdministrativeArea)
                if let county = placemark.subAdministrativeArea {
                    DispatchQueue.main.async {
                        self.userCounty = county
                    }
                } else {
                    print("Failed to retrieve the county from location.")
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
