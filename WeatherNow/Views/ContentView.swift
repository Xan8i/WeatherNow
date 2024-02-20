//
//  ContentView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 28/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var router = Router()
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            ScrollView {
                if let location = locationManager.location {
                    if let weather = viewModel.weather {
                        WeatherView(weather: weather, cityName: locationManager.cityName)
                            .navigationDestination(for: Router.Destination.self) { destination in
                                switch destination {
                                case .sevenDaysWeather(let weather, let allRowData):
                                    SevenDaysWeatherView(viewModel: SevenDaysWeatherViewModel(weather: weather, allRowData: allRowData))
                                case .weekdayWeather(let weather, let rowData):
                                    WeekdayWeatherView(viewModel: WeekdayWeatherViewModel(weather: weather, rowData: rowData))
                                }
                            }
                            .toolbar {
                                Button("Change to " + (viewModel.isCelsius ? "°F" : "°C")) {
                                    viewModel.isCelsius.toggle()
                                    Task {
                                        await viewModel.getWeather(location: location)
                                    }
                                }
                                .bold()
                            }
                    } else {
                        LoadingView()
                            .task {
                                await viewModel.getWeather(location: location)
                            }
                    }
                } else {
                    LoadingView()
                }
            }
            .overlay(alignment: .top) {
                if viewModel.isRefreshing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
            .refreshable {
                if let location = locationManager.location {
                    viewModel.isRefreshing = true
                    await viewModel.getWeather(location: location)
                    viewModel.isRefreshing = false
                }
            }
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        .environmentObject(router)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
