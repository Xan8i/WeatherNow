//
//  WeekdayWeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 14/1/24.
//

import SwiftUI

struct WeekdayWeatherView: View {
    var weather: ResponseBody
    var rowData: RowData
    
    var body: some View {
        //VStack(spacing: 20) {
        ScrollView {

            Text(rowData.time.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day()))
                .padding()
                .font(.title.bold())
            
            Text("Sunrise: " + rowData.sunrise.formatted(date: .omitted, time: .shortened) + "  -  Sunset: " + rowData.sunset.formatted(date: .omitted, time: .shortened))
                .font(.headline)
                .padding(.bottom)
            
            WeatherImageView(imageName: rowData.weatherImageName, font: .custom("", size: 80))
                .padding()

            
            HStack {
                Text("Max: ")
                    .font(.title2)
                Text(rowData.temperature2MMax.roundDouble() + "°")
                    .font(.title.bold())
                
                Text("/")
                
                Text("Min: ")
                    .font(.title2)
                
                Text(rowData.temperature2MMin.roundDouble() + "°")
                    .font(.title.bold())
            }
            .padding(.bottom, 30)
            
            
            
            VStack(alignment: .leading) {
                WeatherRow(logo: "wind", name: "Wind speed", value: rowData.windSpeed10MMax.roundDouble() + weather.dailyUnits.windSpeed10MMax)
                WeatherRow(logo: "cloud.rain", name: "Rain", value: rowData.rainSum.roundDouble() + " " + weather.dailyUnits.rainSum)
                
                WeatherRow(logo: "cloud.heavyrain", name: "Showers", value: rowData.showersSum.roundDouble() + " " + weather.dailyUnits.showersSum)
                WeatherRow(logo: "snow", name: "Snow", value: rowData.snowfallSum.roundDouble() + " " + weather.dailyUnits.snowfallSum)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial.opacity(0.5))
            .cornerRadius(20)
        }
        .padding()
        .background(Image(rowData.weatherBackround.rawValue))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeekdayWeatherView(weather: previewWeather, rowData: Transformer.transformToRowData(from: previewWeather)[0])
}
