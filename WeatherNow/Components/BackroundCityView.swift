//
//  BackroundCityView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 13/12/23.
//

import SwiftUI

struct BackroundCityView: View {
    var body: some View {
        Image(.city1)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 350)
    }
}

#Preview {
    BackroundCityView()
}
