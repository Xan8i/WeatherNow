//
//  WeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 29/11/23.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    @EnvironmentObject var router: Router
   

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Text(viewModel.cityName)
                        .font(.title.bold())
                    Text("Today, \(viewModel.weather.date.formatted(.dateTime.month().day()))")
                        .fontWeight(.light)
                }
                .padding()
            }
            
            TemperaturesWeatherView(imageName: viewModel.weather.weatherImageName,
                                    temperature: viewModel.weather.current.temperature2M,
                                    apparentTemperature: viewModel.weather.current.apparentTemperature,
                                    minTemperature: viewModel.weather.daily.temperature2MMin[0],
                                    maxTemperature: viewModel.weather.daily.temperature2MMax[0],
                                    units: viewModel.weather.currentUnits.apparentTemperature)

            
            ConditionsView(maxTemperature: viewModel.weather.daily.temperature2MMax[0],
                           maxTemperatureUnits: viewModel.weather.dailyUnits.temperature2MMax,
                           minTemperature: viewModel.weather.daily.temperature2MMin[0],
                           minTemperatureUnits: viewModel.weather.dailyUnits.temperature2MMin,
                           windSpeed: viewModel.weather.current.windSpeed10M,
                           windSpeedUnits: viewModel.weather.currentUnits.windSpeed10M,
                           humidity: viewModel.weather.current.relativeHumidity2M,
                           humidityUnits: viewModel.weather.currentUnits.relativeHumidity2M,
                           apparentTemperature: viewModel.weather.current.apparentTemperature)
        
            
            Button {
                router.navigateTo(destination: .sevenDaysWeather(weather: viewModel.weather, allRowData: Transformer.transformToRowData(from: viewModel.weather)))
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
        .background(Image(viewModel.weather.weatherBackround.rawValue))
        .preferredColorScheme(.dark)
        .onAppear(perform: viewModel.getCityName)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weather: previewWeather, locationManager: LocationManager()))
            .environmentObject(Router())
    }
}
