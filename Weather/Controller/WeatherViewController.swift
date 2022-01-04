//
//  ViewController.swift
//  Weather
//
//  Created by Nick Sagan on 30.12.2021.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    func didFailWithError(error: Error) {
        <#code#>
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        <#code#>
    }
    
    
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!
    
    @IBAction func locationPressed(_ sender: UIButton) {
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextfield.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextfield.delegate = self
        weatherManager.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextfield.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextfield.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.text = "Type something"
            return false
        }
    }
    


}

