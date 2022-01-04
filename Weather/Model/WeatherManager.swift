//
//  WeatherManager.swift
//  Weather
//
//  Created by Nick Sagan on 01.01.2022.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?APPID=37c26fc1dd13df134b731718ed86e450&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = weatherUrl + "&q=" + cityName
        performRequest(with: urlString)
    }
    
    func fetchWeather (longitude: Double, latitude: Double) {
        let urlString = "\(weatherUrl)&lon=\(longitude)&lat=\(latitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. URL
        guard let url = URL(string: urlString) else { return }
        
        // 2. URLSession
        let session = URLSession(configuration: .default)
        
        // 3. Task
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil { self.delegate?.didFailWithError(error: error!); return }
            guard let safeData = data else { return }
            guard let weather = self.parseJSON(weatherData: safeData) else { return }
            self.delegate?.didUpdateWeather(self, weather: weather)
        }
        
        // 4. Resume
        task.resume()
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp, description: description)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
