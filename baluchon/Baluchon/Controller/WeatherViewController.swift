//
//  WeatherViewController.swift
//  baluchon
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var newYorkTempLabel: UILabel!
    @IBOutlet weak var newYorkMinMaxLabel: UILabel!
    @IBOutlet weak var newYorkHumidityLabel: UILabel!
    @IBOutlet weak var newYorkWindSpeedLabel: UILabel!
    @IBOutlet weak var newYorkDescriptionLabel: UILabel!
    @IBOutlet weak var newYorkImageView: UIImageView!
    
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWeather()

        // Do any additional setup after loading the view.
    }
    
    private func initializeWeather(){
        weatherService.getWeather(city: "Nice"){ (success, data) in
            if success, let data = data {
                guard let temp = data.main["temp"], let min = data.main["temp_min"], let max = data.main["temp_max"], let humidity = data.main["humidity"], let windSpeed = data.wind["speed"] else{return}
                self.newYorkTempLabel.text = String(temp) + "°"
                self.newYorkMinMaxLabel.text = "Min: " + String(min) + "° / Max: " + String(max) + "°"
                self.newYorkHumidityLabel.text = "Humidity: " + String(humidity) + " %"
                self.newYorkWindSpeedLabel.text = "Wind speed: " + String(windSpeed) + " km/h"
                for weather in data.weather{
                    let description = weather.description
                    let icon = weather.icon
                    self.newYorkImageView.image = UIImage(named: icon)
                    self.newYorkDescriptionLabel.text = description

                }
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
