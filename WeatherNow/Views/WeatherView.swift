//
//  WeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 29/11/23.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var locationManager: LocationManager
    
    @State var cityName = ""
    
    func getCityName() {
        locationManager.lookUpCurrentLocation { placemark in
            cityName = placemark?.locality ?? "City name not found"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                HStack {
                    VStack(alignment: .center) {
                        Text(cityName)
                            .font(.title.bold())
                        Text("Today, \(weather.date.formatted(.dateTime.month().day()))")
                            .fontWeight(.light)
                    }
                    .padding()
                    
//                    Spacer()
                }
                
                Spacer()
                
                TemperaturesWeatherView(imageName: weather.weatherImageName,
                                        temperature: weather.current.temperature2M,
                                        apparentTemperature: weather.current.apparentTemperature,
                                        minTemperature: weather.daily.temperature2MMin[0],
                                        maxTemperature: weather.daily.temperature2MMax[0],
                                        units: weather.currentUnits.apparentTemperature)
                
                Spacer()
                
//                BackroundCityView()
                
                ConditionsView(maxTemperature: weather.daily.temperature2MMax[0],
                               maxTemperatureUnits: weather.dailyUnits.temperature2MMax,
                               minTemperature: weather.daily.temperature2MMin[0],
                               minTemperatureUnits: weather.dailyUnits.temperature2MMin,
                               windSpeed: weather.current.windSpeed10M,
                               windSpeedUnits: weather.currentUnits.windSpeed10M,
                               humidity: weather.current.relativeHumidity2M,
                               humidityUnits: weather.currentUnits.relativeHumidity2M)
                
                Spacer()
                
                NavigationLink {
                    SevenDaysWeatherView(weather: weather, allRowData: Transformer.transformToRowData(from: weather))
                } label: {
                   Text("7 day forecast >")
                        .padding()
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(weather.isItDayTime ? Color(hue: 0.570, saturation: 0.745, brightness: 0.959) : Color(hue: 0.706, saturation: 0.936, brightness: 0.337))
            .preferredColorScheme(.dark)
            .onAppear(perform: getCityName)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather, locationManager: LocationManager())
        
    }
}
