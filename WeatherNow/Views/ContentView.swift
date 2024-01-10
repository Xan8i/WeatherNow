//
//  ContentView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 28/11/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        Group {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather, locationManager: locationManager)
                } else {
                    LoadingView()
                        .task {
                            await getWeather(location: location)
                        }
                }
            } else {
               LoadingView()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func getWeather(location: CLLocationCoordinate2D) async {
        do {
            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
        } catch {
            print("Error getting weather: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
