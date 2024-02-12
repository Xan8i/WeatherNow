//
//  WeekdayWeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 14/1/24.
//

import SwiftUI

struct WeekdayWeatherView: View {
    @ObservedObject var viewModel: WeekdayWeatherViewModel
    
    
    var body: some View {
        //VStack(spacing: 20) {
        ScrollView {

            Text(viewModel.rowData.time.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day()))
                .padding()
                .font(.title.bold())
            
            Text("Sunrise: " + viewModel.rowData.sunrise.formatted(date: .omitted, time: .shortened) + "  -  Sunset: " + viewModel.rowData.sunset.formatted(date: .omitted, time: .shortened))
                .font(.headline)
                .padding(.bottom)
            
            WeatherImageView(imageName: viewModel.rowData.weatherImageName, font: .custom("", size: 80))
                .padding()

            
            HStack {
                Text("Max: ")
                    .font(.title2)
                Text(viewModel.rowData.temperature2MMax.roundDouble() + "°")
                    .font(.title.bold())
                
                Text("/")
                
                Text("Min: ")
                    .font(.title2)
                
                Text(viewModel.rowData.temperature2MMin.roundDouble() + "°")
                    .font(.title.bold())
            }
            .padding(.bottom, 30)
            
            
            
            VStack(alignment: .leading) {
                WeatherRow(logo: "wind", name: "Wind speed", value: viewModel.rowData.windSpeed10MMax.roundDouble() + viewModel.weather.dailyUnits.windSpeed10MMax)
                WeatherRow(logo: "cloud.rain", name: "Rain", value: viewModel.rowData.rainSum.roundDouble() + " " + viewModel.weather.dailyUnits.rainSum)
                
                WeatherRow(logo: "cloud.heavyrain", name: "Showers", value: viewModel.rowData.showersSum.roundDouble() + " " + viewModel.weather.dailyUnits.showersSum)
                WeatherRow(logo: "snow", name: "Snow", value: viewModel.rowData.snowfallSum.roundDouble() + " " + viewModel.weather.dailyUnits.snowfallSum)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial.opacity(0.5))
            .cornerRadius(20)
        }
        .padding()
        .background(Image(viewModel.rowData.weatherBackround.rawValue))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeekdayWeatherView(viewModel: WeekdayWeatherViewModel(weather: previewWeather, rowData: Transformer.transformToRowData(from: previewWeather)[0]))
}
