//
//  TemperaturesWeatherView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 13/12/23.
//

import SwiftUI

struct TemperaturesWeatherView: View {
    let imageName: String
    let temperature: Double
    let apparentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let units: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            HStack(alignment: .center) {
                Text(temperature.roundDouble())
                    .font(.system(size: 100))
                Text(units)
                    .font(.system(size: 50))
            }
            .fontWeight(.bold)
            
            HStack {
                WeatherImageView(imageName: imageName, font: .system(size: 50))
                
                Spacer()
                    .frame(width: 20)
                Text(minTemperature.roundDouble() + "° / " + maxTemperature.roundDouble() + "°")
                    .font(.largeTitle)
                    
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Text("Feels like")
                        .font(.headline)
                    HStack {
                        Text(apparentTemperature.roundDouble() + "°")
                            .font(.largeTitle)
//                        Text(units)
//                            .font(.title2)
                    }
                }
            }
            .padding()
            .fontWeight(.bold)
        }
        .padding()
    }
}

#Preview {
    TemperaturesWeatherView(imageName: "sun.max", temperature: 20.0, apparentTemperature: 18.0, minTemperature: 12.0, maxTemperature: 25.0, units: "°C")
}
