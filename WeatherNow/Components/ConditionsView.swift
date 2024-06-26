//
//  ConditionsView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 13/12/23.
//

import SwiftUI

struct ConditionsView: View {
    let maxTemperature: Double
    let maxTemperatureUnits: String
    let minTemperature: Double
    let minTemperatureUnits: String
    let windSpeed: Double
    let windSpeedUnits: String
    let humidity: Int
    let humidityUnits: String
    let apparentTemperature: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Additional conditions:")
                .bold().padding(.bottom)
            
            
            HStack {
                WeatherRow(logo: "wind",
                           name: "Wind",
                           value: windSpeed.roundDouble() + windSpeedUnits)
                Spacer()
                
                WeatherRow(logo: "humidity",
                           name: "Humidity",
                           value: "\(humidity)" + humidityUnits)
            }
            
            
        }
        .padding()
        .padding(.bottom, 20)
        .foregroundColor(.white)
        .cornerRadius(20)
        .preferredColorScheme(.dark)

    }
}

#Preview {
    ConditionsView(maxTemperature: 20.0, maxTemperatureUnits: "°C", minTemperature: 10.0, minTemperatureUnits: "°C", windSpeed: 3.0, windSpeedUnits: "km/h", humidity: 50, humidityUnits: "%", apparentTemperature: 18.0)
}
