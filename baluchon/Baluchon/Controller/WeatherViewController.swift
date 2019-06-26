//
//  WeatherViewController.swift
//  baluchon
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var firstCityLabel: UILabel!
    @IBOutlet weak var firstCityTempLabel: UILabel!
    @IBOutlet weak var firstCityMinMaxLabel: UILabel!
    @IBOutlet weak var firstCityHumidityLabel: UILabel!
    @IBOutlet weak var firstCityWindSpeedLabel: UILabel!
    @IBOutlet weak var firstCityDescriptionLabel: UILabel!
    @IBOutlet weak var firstCityImageView: UIImageView!
    
    @IBOutlet weak var secondCityHumidityLabel: UILabel!
    @IBOutlet weak var secondCityLabel: UILabel!
    @IBOutlet weak var secondCityTempLabel: UILabel!
    @IBOutlet weak var secondCityMinMaxLabel: UILabel!
    @IBOutlet weak var secondCityWindSpeedLabel: UILabel!
    @IBOutlet weak var secondCityDescriptionLabel: UILabel!
    @IBOutlet weak var secondCityImageView: UIImageView!
    
    @IBOutlet weak var principalSlackView: UIStackView!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWeather()

        // Do any additional setup after loading the view.
    }

    private func toggleActivityIndicator(shown: Bool){
        weatherActivityIndicator.isHidden = shown
        principalSlackView.isHidden = !shown
    }
    
    private func refreshViews(weatherData: WeatherData){
        self.firstCityLabel.text = weatherData.list[0].name
        self.firstCityTempLabel.text = String(Int(weatherData.list[0].main["temp"]!)) + "°"
        self.firstCityMinMaxLabel.text = "min " + String(Int(weatherData.list[0].main["temp_min"]!)) + "° / max " + String(Int(weatherData.list[0].main["temp_max"]!)) + "°"
        self.firstCityHumidityLabel.text = "humidité: " + String(Int(weatherData.list[0].main["humidity"]!)) + " %"
        self.firstCityWindSpeedLabel.text = "vent: " + String(Int(weatherData.list[0].wind["speed"]!)) + " km/h"
        self.firstCityImageView.image = UIImage(named: weatherData.list[0].weather[0].icon)
        self.firstCityDescriptionLabel.text = weatherData.list[0].weather[0].description
        
        self.secondCityLabel.text = weatherData.list[1].name
        self.secondCityTempLabel.text = String(Int(weatherData.list[1].main["temp"]!)) + "°"
        self.secondCityMinMaxLabel.text = "min " + String(Int(weatherData.list[1].main["temp_min"]!)) + "° / max " + String(Int(weatherData.list[0].main["temp_max"]!)) + "°"
        self.secondCityHumidityLabel.text = "humidité: " + String(Int(weatherData.list[1].main["humidity"]!)) + " %"
        self.secondCityWindSpeedLabel.text = "vent: " + String(Int(weatherData.list[1].wind["speed"]!)) + " km/h"
        self.secondCityImageView.image = UIImage(named: weatherData.list[1].weather[0].icon)
        self.secondCityDescriptionLabel.text = weatherData.list[1].weather[0].description
    }
    
    private func initializeWeather(){
        toggleActivityIndicator(shown: false)
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, data) in
            self.toggleActivityIndicator(shown: true)
            if success, let data = data {
                self.refreshViews(weatherData: data)
            }else{
                self.presentAlert(message: "The weather data download failed")
            }
        }
    }
}
// MARK: Alerts

extension WeatherViewController {
    private func presentAlert(message: String){
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
