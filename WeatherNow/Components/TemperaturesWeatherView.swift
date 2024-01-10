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
    let units: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                WeatherImageView(imageName: imageName, font: .system(size: 60))
                
                Spacer()
                    .frame(width: 50)
                
                Text(temperature.roundDouble() + units)
                    .font(.system(size: 80))
                    .fontWeight(.bold)
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Text("Feels like")
                        .font(.headline)
                    Text(apparentTemperature.roundDouble() + units)
                        .font(.largeTitle.bold())
                }
            }
            .padding()
        }
    }
}

#Preview {
    TemperaturesWeatherView(imageName: "sun.max", temperature: 20.0, apparentTemperature: 18.0, units: "°C")
}
