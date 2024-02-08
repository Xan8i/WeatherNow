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
    @State var isCelsius = true
    
    @ObservedObject var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            Group {
                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather, locationManager: locationManager)
                            .navigationDestination(for: Router.Destination.self) { destination in
                                switch destination {
                                case .sevenDaysWeather(let weather, let allRowData):
                                    SevenDaysWeatherView(weather: weather, allRowData: allRowData)
                                case .weekdayWeather(let weather, let rowData):
                                    WeekdayWeatherView(weather: weather, rowData: rowData)
                                }
                            }
                            .toolbar {
                                Button("Change to " + (isCelsius ? "°F" : "°C")) {
                                    isCelsius.toggle()
                                    Task {
                                        await getWeather(location: location)
                                    }
                                }
                                .bold()
                            }
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

        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        .environmentObject(router)
    }
    
    func getWeather(location: CLLocationCoordinate2D) async {
        do {
            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude, units: isCelsius ? .celsius : .fahrenheit)
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
