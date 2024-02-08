//
//  WeatherRow.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 29/11/23.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2.bold())
                .frame(width: 20, height: 20)
                .padding()
//                .background(.white)
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.subheadline.bold())
                
                Text(value)
                    .font(.title.bold())
            }
        }
        .preferredColorScheme(.dark)
        
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8")
    }
}
