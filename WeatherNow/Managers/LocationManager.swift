//
//  LocationManager.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 28/11/23.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    @Published var cityName = ""
    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestWhenInUseAuthorization()
    }

    
    
    func getCityName() {
        lookUpCurrentLocation { placemark in
            self.cityName = placemark?.locality ?? "City name not found"
        }
    }

    // MARK: CLLocationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
        
        getCityName()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.manager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                } else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        } else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {

        case .notDetermined:
            print("DEBUG: Not determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways:
            print("DEBUG: Auth always")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use")
        @unknown default:
            break
        }
    }
}
