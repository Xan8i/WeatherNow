//
//  SevenDaysWeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 11/12/23.
//

import SwiftUI

struct SevenDaysWeatherView: View {
    var weather: ResponseBody
    var allRowData: [RowData]
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color(hue: 0.706, saturation: 0.936, brightness: 0.337)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                ForEach(allRowData, id: \.time) { rowData in
                    Button {
                        router.navigateTo(destination: .weekdayWeather(weather: weather, rowData: rowData))
                    } label: {
                        DailyWeatherRowView(rowData: rowData, image: rowData.weatherImageName)
                    }
                    
//                    NavigationLink {
//                        WeekdayWeatherView(weather: weather, rowData: rowData)
//                    } label: {
//                        DailyWeatherRowView(rowData: rowData, image: rowData.weatherImageName)
//                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle("7 Day Forecast ")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SevenDaysWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SevenDaysWeatherView(weather: previewWeather, allRowData: Transformer.transformToRowData(from: previewWeather))
                .environmentObject(Router())
        }
    }
}
