//
//  WeatherModel.swift
//  Weather
//
//  Created by Nick Sagan on 02.01.2022.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var temperatureString : String {
        String(round(temperature))
    }
    
    var weatherIcon: String {
        switch conditionID {
        case 200...299: return "cloud.bolt.rain"
        case 300...399: return "cloud.drizzle"
        case 500...599: return "cloud.rain"
        case 600...699: return "snowflake"
        case 700...799: return "wind"
        case 800: return "sun.max"
        case 801...899: return "cloud.sun"
        default: return "cloud.sun"
        }
    }
}
