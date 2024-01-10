//
//  DailyWeatherRowView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 11/12/23.
//

import SwiftUI

struct DailyWeatherRowView: View {
    let rowData: RowData
    let image: String
   
    
    var body: some View {
        HStack(spacing: 30) {
            VStack(alignment: .listRowSeparatorLeading)  {
                Text(rowData.time.formatted(Date.FormatStyle().weekday(.wide)))
                    .font(.title2.bold())
                Text(rowData.time.formatted(.dateTime.month().day()))
                    .font(.title3)
            }
            
            Spacer()
            
            WeatherImageView(imageName: image, font: .title)
            
            VStack {
                HStack(spacing: 2) {
                    Text(rowData.temperature2MMax.roundDouble())
                        .font(.title2.bold())
                    Text("°C")
                }
                .foregroundColor(.red)
                
                HStack(spacing: 2) {
                    Text(rowData.temperature2MMin.roundDouble())
                        .font(.title2.bold())
                    Text("°C")
                }
                .foregroundColor(.blue)
            }
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

struct DailyWeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherRowView(rowData: RowData(time: .now, temperature2MMax: 15.5, temperature2MMin: 7.7, sunrise: .now, sunset: .now, rainSum: 1.30, showersSum: 0.00, snowfallSum: 0.00, windSpeed10MMax: 8.2), image: "sun.max")
    }
}
