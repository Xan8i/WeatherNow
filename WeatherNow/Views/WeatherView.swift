//
//  WeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 29/11/23.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var cityName: String
    
    @EnvironmentObject var router: Router
   

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Text(cityName)
                        .font(.title.bold())
                    Text("Today, \(weather.date.formatted(.dateTime.month().day()))")
                        .fontWeight(.light)
                }
                .padding()
            }
            
            TemperaturesWeatherView(imageName: weather.weatherImageName,
                                    temperature: weather.current.temperature2M,
                                    apparentTemperature: weather.current.apparentTemperature,
                                    minTemperature: weather.daily.temperature2MMin[0],
                                    maxTemperature: weather.daily.temperature2MMax[0],
                                    units: weather.currentUnits.apparentTemperature)

            
            ConditionsView(maxTemperature: weather.daily.temperature2MMax[0],
                           maxTemperatureUnits: weather.dailyUnits.temperature2MMax,
                           minTemperature: weather.daily.temperature2MMin[0],
                           minTemperatureUnits: weather.dailyUnits.temperature2MMin,
                           windSpeed: weather.current.windSpeed10M,
                           windSpeedUnits: weather.currentUnits.windSpeed10M,
                           humidity: weather.current.relativeHumidity2M,
                           humidityUnits: weather.currentUnits.relativeHumidity2M,
                           apparentTemperature: weather.current.apparentTemperature)
        
            
            Button {
                router.navigateTo(destination: .sevenDaysWeather(weather: weather, allRowData: Transformer.transformToRowData(from: weather)))
            } label: {
                Text("7 day forecast")
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(.ultraThinMaterial.opacity(0.5))
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
            .padding(.top, 30)
        }
        .background(Image(weather.weatherBackround.rawValue))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather, cityName: "Athens")
            .environmentObject(Router())
    }
}
