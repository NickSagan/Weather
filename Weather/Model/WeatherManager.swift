//
//  WeatherManager.swift
//  Weather
//
//  Created by Nick Sagan on 01.01.2022.
//

import Foundation

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
}
