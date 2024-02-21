//
//  SevenDaysWeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 11/12/23.
//

import SwiftUI

struct SevenDaysWeatherView: View {
    @ObservedObject var viewModel: SevenDaysWeatherViewModel
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        List {
            ForEach(viewModel.allRowData, id: \.time) { rowData in
                Button {
                    router.navigateTo(destination: .weekdayWeather(weather: viewModel.weather, rowData: rowData))
                } label: {
                    DailyWeatherRowView(rowData: rowData, image: rowData.weatherImageName)
                }
            }
            .listRowBackground(EmptyView())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Image("sunny"))
        .preferredColorScheme(.dark)
        .navigationTitle("7 Day Forecast ")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SevenDaysWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SevenDaysWeatherView(viewModel: SevenDaysWeatherViewModel(weather: previewWeather, allRowData: Transformer.transformToRowData(from: previewWeather)))
                .environmentObject(Router())
        }
    }
}
