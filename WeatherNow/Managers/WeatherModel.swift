//
//  WeatherModel.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 29/11/23.
//

import Foundation

struct ResponseBody: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    let generationtimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    
    let currentUnits: CurrentUnits
    
    let current: Current
    
    let dailyUnits: DailyUnits
    
    let daily: Daily

    struct CurrentUnits: Codable, Hashable {
        let time: String
        let interval: String
        let temperature2M: String
        let rain: String
        let showers: String
        let snowfall: String
        let cloudCover: String
        let relativeHumidity2M: String
        let apparentTemperature: String
        let isDay: String
        let windSpeed10M: String
    }
    
    struct Current: Codable, Hashable {
        let time: String
        let interval: Int
        let temperature2M: Double
        let rain: Double
        let showers: Double
        let snowfall: Double
        let cloudCover: Int
        let relativeHumidity2M: Int
        let apparentTemperature: Double
        let isDay: Int
        let windSpeed10M: Double
    }
    
    struct DailyUnits: Codable, Hashable {
        let time: String
        let temperature2MMax: String
        let temperature2MMin: String
        let sunrise: String
        let sunset: String
        let rainSum: String
        let showersSum: String
        let snowfallSum: String
        let windSpeed10MMax: String
    }
    
    struct Daily: Codable, Hashable {
        let time: [String]
        let temperature2MMax: [Double]
        let temperature2MMin: [Double]
        let sunrise: [String]
        let sunset: [String]
        let rainSum: [Double]
        let showersSum: [Double]
        let snowfallSum: [Double]
        let windSpeed10MMax: [Double]
    }
    
   
    
    var isItDayTime: Bool {
        return current.isDay == 1
    }
    
    var date: Date {
        DateFormater.convertToDate(current.time)
    }
    
    var weatherImageName: String {
        if current.rain > 0 {
            return "cloud.rain"
        }
        
        if current.showers > 0 {
            return "cloud.rain"
        }
        
        if current.snowfall > 0 {
            return "cloud.snow"
        }
        
        if current.cloudCover >= 50 {
            return "cloud"
        }
        
        return "sun.max"
    }
    
    enum WeatherBackround: String {
        case sunny = "sunny"
        case cloudy = "cloudy"
        case rainy = "rainy"
        case snowy = "snowy"
    }
    
    var weatherBackround: WeatherBackround {
        if current.rain > 0 {
            return .rainy
        }
        
        if current.showers > 0 {
            return .rainy
        }
        
        if current.snowfall > 0 {
            return .snowy
        }
        
        if current.cloudCover >= 40 {
            return .cloudy
        }
        
        return .sunny
    }
}


struct RowData: Hashable {
    var time: Date
    var temperature2MMax: Double
    var temperature2MMin: Double
    var sunrise: Date
    var sunset: Date
    var rainSum: Double
    var showersSum: Double
    var snowfallSum: Double
    var windSpeed10MMax: Double
    
    var weatherImageName: String {
        if rainSum > 0 {
            return "cloud.rain"
        }
        
        if showersSum > 0 {
            return "cloud.rain"
        }
        
        if snowfallSum > 0 {
            return "cloud.snow"
        }
        
        return "sun.max"
    }
}


enum DateFormater {
    static func convertToDate(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return dateFormatter.date(from: date) ?? Date()
    }
    
    static func convertToShortDate(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date) ?? Date()
    }
    
    static func getWeekDay(_ date: Date) -> String {
        let f = DateFormatter()
        return f.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    }
}

enum Transformer {
    static func transformToRowData(from weather: ResponseBody) -> [RowData] {

        var allRowData: [RowData] = []

        for day in 0..<7 {
            let rowData = RowData(
                time: DateFormater.convertToShortDate(weather.daily.time[day]),
                temperature2MMax: weather.daily.temperature2MMax[day],
                temperature2MMin: weather.daily.temperature2MMin[day],
                sunrise: DateFormater.convertToDate(weather.daily.sunrise[day]),
                sunset: DateFormater.convertToDate(weather.daily.sunset[day]),
                rainSum: weather.daily.rainSum[day],
                showersSum: weather.daily.showersSum[day],
                snowfallSum: weather.daily.snowfallSum[day],
                windSpeed10MMax: weather.daily.windSpeed10MMax[day])

            allRowData.append(rowData)
        }

        return allRowData
    }
}


