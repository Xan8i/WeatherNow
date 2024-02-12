//
//  WeekdayWeatherViewModel.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 12/2/24.
//

import Foundation

final class WeekdayWeatherViewModel: ObservableObject {
    var weather: ResponseBody
    var rowData: RowData
    
    init(weather: ResponseBody, rowData: RowData) {
        self.weather = weather
        self.rowData = rowData
    }
}
