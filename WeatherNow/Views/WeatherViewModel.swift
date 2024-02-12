//
//  WeatherViewModel.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 12/2/24.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    var weather: ResponseBody
    var locationManager: LocationManager
   
    @Published var cityName = ""
    
    func getCityName() {
        locationManager.lookUpCurrentLocation { placemark in
            self.cityName = placemark?.locality ?? "City name not found"
        }
    }
    
    init(weather: ResponseBody, locationManager: LocationManager) {
        self.weather = weather
        self.locationManager = locationManager
    }
}
