//
//  WeatherImageView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 13/12/23.
//

import SwiftUI

struct WeatherImageView: View {
    let imageName: String
    let font: Font
    
    var body: some View {
        Image(systemName: imageName)
            .font(font)
            .foregroundColor(imageName == "sun.max" ? .yellow : .white)
            
    }
}

#Preview {
    WeatherImageView(imageName: "sun.max", font: .largeTitle)
}
