//
//  SevenDaysWeatherViewModel.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 12/2/24.
//

import Foundation

final class SevenDaysWeatherViewModel: ObservableObject {
    var weather: ResponseBody
    var allRowData: [RowData]
    
    init(weather: ResponseBody, allRowData: [RowData]) {
        self.weather = weather
        self.allRowData = allRowData
    }
    
}
