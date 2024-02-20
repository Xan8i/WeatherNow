//
//  Router.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 20/1/24.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    enum Destination: Hashable {
        case sevenDaysWeather(weather: ResponseBody, allRowData: [RowData])
        case weekdayWeather(weather: ResponseBody, rowData: RowData)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigateTo(destination: Destination) {
        navPath.append(destination)
    }
}
