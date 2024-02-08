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
    
    @EnvironmentObject var router: Router
    @State var cityName = ""
    
    func getCityName() {
        locationManager.lookUpCurrentLocation { placemark in
            cityName = placemark?.locality ?? "City name not found"
        }
    }

    var body: some View {

        VStack(spacing: .zero) {
            HStack {
                VStack(alignment: .center) {
                    Text(cityName)
                        .font(.title.bold())
                    Text("Today, \(weather.date.formatted(.dateTime.month().day()))")
                        .fontWeight(.light)
                }
                .padding()
            }
            
            Spacer()
            
            TemperaturesWeatherView(imageName: weather.weatherImageName,
                                    temperature: weather.current.temperature2M,
                                    apparentTemperature: weather.current.apparentTemperature,
                                    minTemperature: weather.daily.temperature2MMin[0],
                                    maxTemperature: weather.daily.temperature2MMax[0],
                                    units: weather.currentUnits.apparentTemperature)
            
            Spacer()
            
            
            ConditionsView(maxTemperature: weather.daily.temperature2MMax[0],
                           maxTemperatureUnits: weather.dailyUnits.temperature2MMax,
                           minTemperature: weather.daily.temperature2MMin[0],
                           minTemperatureUnits: weather.dailyUnits.temperature2MMin,
                           windSpeed: weather.current.windSpeed10M,
                           windSpeedUnits: weather.currentUnits.windSpeed10M,
                           humidity: weather.current.relativeHumidity2M,
                           humidityUnits: weather.currentUnits.relativeHumidity2M,
                           apparentTemperature: weather.current.apparentTemperature)
            
            Spacer()
            
            Button {
                router.navigateTo(destination: .sevenDaysWeather(weather: weather, allRowData: Transformer.transformToRowData(from: weather)))
            } label: {
                Text("7 day forecast")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(white: 0.8, opacity: 0.3))
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
            
            Spacer()
        }
        .background(Image(weather.weatherBackround.rawValue))
        .preferredColorScheme(.dark)
        .onAppear(perform: getCityName)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather, locationManager: LocationManager())
            .environmentObject(Router())
    }
}
