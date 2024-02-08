//
//  WeatherManager.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 28/11/23.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, units: Units) async throws -> ResponseBody {
        
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,rain,showers,snowfall,cloud_cover,relative_humidity_2m,apparent_temperature,is_day,wind_speed_10m&hourly=&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,rain_sum,showers_sum,snowfall_sum,wind_speed_10m_max&temperature_unit=\(units.rawValue)") else {
            fatalError("Missing URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedResponse = try decoder.decode(ResponseBody.self, from: data)
        
        return decodedResponse

    }
}

enum Units: String {
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
}



