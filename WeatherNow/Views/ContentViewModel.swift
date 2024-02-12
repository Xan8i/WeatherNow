//
//  ContentViewModel.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 12/2/24.
//

import Foundation
import CoreLocation

@MainActor
final class ContentViewModel: ObservableObject {
    var weatherManager = WeatherManager()
    @Published var weather: ResponseBody?
    @Published var isCelsius = true
    @Published var isRefreshing = false
    
    func getWeather(location: CLLocationCoordinate2D) async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        do {
            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude, units: isCelsius ? .celsius : .fahrenheit)
        } catch {
            print("Error getting weather: \(error)")
        }
    }
}
