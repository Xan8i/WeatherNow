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
        ZStack {
            Color(hue: 0.706, saturation: 0.936, brightness: 0.337)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(rowData.time.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day()))
                    .font(.title.bold())
               
                Text("Sunrise: " + rowData.sunrise.formatted(date: .omitted, time: .shortened) + "  -  Sunset: " + rowData.sunset.formatted(date: .omitted, time: .shortened))
               .font(.headline)
                
                Spacer()
                
            
                
                WeatherImageView(imageName: rowData.weatherImageName, font: .custom("", size: 80))
                
                Spacer()
                
                HStack {
                    Text("Max: ")
                        .font(.title2)
                    Text(rowData.temperature2MMax.roundDouble() + weather.dailyUnits.temperature2MMax)
                        .font(.title2.bold())
                        .foregroundStyle(.red)
                    
                    Text("/")
                    
                    Text("Min: ")
                        .font(.title2)
                    
                    Text(rowData.temperature2MMin.roundDouble() + weather.dailyUnits.temperature2MMin)
                        .font(.title2.bold())
                        .foregroundStyle(.blue)
                }
             
                
                 
                Spacer()
                
                VStack(alignment: .leading) {
               
                        WeatherRow(logo: "wind", name: "Wind speed", value: rowData.windSpeed10MMax.roundDouble() + weather.dailyUnits.windSpeed10MMax)
                        WeatherRow(logo: "cloud.rain", name: "Rain", value: rowData.rainSum.roundDouble() + " " + weather.dailyUnits.rainSum)
                    
                    
                  
                        WeatherRow(logo: "snow", name: "Snow", value: rowData.snowfallSum.roundDouble() + " " + weather.dailyUnits.snowfallSum)
                        WeatherRow(logo: "cloud.heavyrain", name: "Showers", value: rowData.showersSum.roundDouble() + " " + weather.dailyUnits.showersSum)
                }
                .padding(30)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .foregroundStyle(Color(hue: 0.706, saturation: 0.936, brightness: 0.337))
                .cornerRadius(20)
                
              
                
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeekdayWeatherView(weather: previewWeather, rowData: Transformer.transformToRowData(from: previewWeather)[0])
}
