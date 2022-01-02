//
//  WeatherManager.swift
//  Weather
//
//  Created by Nick Sagan on 01.01.2022.
//

import Foundation
import UIKit

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?APPID=37c26fc1dd13df134b731718ed86e450&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = weatherUrl + "&q=" + cityName
        performRequest(urlString: urlString)
    }
    
    func fetchWeather (longitude: Double, latitude: Double) {
        let urlString = "\(weatherUrl)&lon=\(longitude)&lat=\(latitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // 1. URL
        guard let url = URL(string: urlString) else { return }
        
        // 2. URLSession
        let session = URLSession(configuration: .default)
        
        // 3. Task
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil { print(error as Any); return }
            guard let safeData = data else { return }
            parseJSON(weatherData: safeData)
        }
        
        // 4. Resume
        task.resume()
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
        } catch {
            print(error)
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
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
