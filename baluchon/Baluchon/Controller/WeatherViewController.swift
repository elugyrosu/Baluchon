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
    @IBOutlet weak var newYorkTempLabel: UILabel!
    @IBOutlet weak var newYorkMinMaxLabel: UILabel!
    @IBOutlet weak var newYorkHumidityLabel: UILabel!
    @IBOutlet weak var newYorkWindSpeedLabel: UILabel!
    @IBOutlet weak var newYorkDescriptionLabel: UILabel!
    @IBOutlet weak var newYorkImageView: UIImageView!
    
    @IBOutlet weak var secondCityLabel: UILabel!
    @IBOutlet weak var niceTempLabel: UILabel!
    @IBOutlet weak var niceMinMaxLabel: UILabel!
    @IBOutlet weak var niceHumidityLabel: UILabel!
    @IBOutlet weak var niceWindSpeedLabel: UILabel!
    @IBOutlet weak var niceDescriptionLabel: UILabel!
    @IBOutlet weak var niceImageView: UIImageView!
    
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWeather()

        // Do any additional setup after loading the view.
    }
    
    private func initializeWeather(){
        weatherService.getWeather(citysId: "6454924,5128581"){ (success, data) in
            if success, let data = data {
                let firstList = data.list[0]
                guard let temp = firstList.main["temp"], let min = firstList.main["temp_min"], let max = firstList.main["temp_max"], let humidity = firstList.main["humidity"], let windSpeed = firstList.wind["speed"] else{return}
                let tempInt = Int(temp)
                let tempMaxInt = Int(max)
                let tempMinInt = Int(min)
                let windSpeedInt = Int(windSpeed)
                let humidityInt = Int(humidity)
                
                self.firstCityLabel.text = firstList.name
                self.newYorkTempLabel.text = String(tempInt) + "°"
                self.newYorkMinMaxLabel.text = "min " + String(tempMinInt) + "° / max " + String(tempMaxInt) + "°"
                self.newYorkDescriptionLabel.text = "humidité: " + String(humidityInt) + " %"
                self.niceWindSpeedLabel.text = "vent: " + String(windSpeedInt) + " km/h"
                for weather in firstList.weather{
                    let description = weather.description
                    let icon = weather.icon
                    self.newYorkImageView.image = UIImage(named: icon)
                    self.newYorkDescriptionLabel.text = description
                }
                
                let secondList = data.list[1]
                guard let temp2 = secondList.main["temp"], let min2 = secondList.main["temp_min"], let max2 = secondList.main["temp_max"], let humidity2 = secondList.main["humidity"], let windSpeed2 = secondList.wind["speed"] else{return}
                let tempInt2 = Int(temp2)
                let tempMaxInt2 = Int(max2)
                let tempMinInt2 = Int(min2)
                let windSpeedInt2 = Int(windSpeed2)
                let humidityInt2 = Int(humidity2)
                
                self.secondCityLabel.text = secondList.name
                self.niceTempLabel.text = String(tempInt2) + "°"
                self.niceMinMaxLabel.text = "min " + String(tempMinInt2) + "° / max " + String(tempMaxInt2) + "°"
                self.niceDescriptionLabel.text = "humidité: " + String(humidityInt2) + " %"
                self.niceWindSpeedLabel.text = "vent: " + String(windSpeedInt2) + " km/h"
                for weather in secondList.weather{
                    let description = weather.description
                    let icon = weather.icon
                    self.niceImageView.image = UIImage(named: icon)
                    self.niceDescriptionLabel.text = description
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
