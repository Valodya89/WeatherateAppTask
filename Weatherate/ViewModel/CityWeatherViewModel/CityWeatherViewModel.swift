//
//  CityWeatherViewModel.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit

class CityWeatherViewModel: BaseViewModel {

    var coord = [String:Any]()
    var weather = [Weather]()
    var base = ""
    var main: WeatherMain?
    var visibility = ""
    var wind = [String:Any]()
    var clouds = [String:Any]()
    var dt = ""
    var sys = [String:Any]()
    var CityWeatherId = ""
    var name = ""
    var cod = ""
    var humidity = ""
    var temp_min = ""
    var temp_max = ""
    var temp = ""
    var pressure = ""
    var weatherDescription = ""
    
    func initWithModel(model: CityWeather) -> CityWeatherViewModel {
        
        self.coord = model.coord
        self.weather = model.weather
        self.base = model.base
        self.main = model.main
        self.visibility = model.visibility
        self.wind = model.wind
        self.clouds = model.clouds
        self.dt = model.dt
        self.sys = model.sys
        self.CityWeatherId = model.CityWeatherId
        self.name = model.name
        self.cod = model.cod
        self.humidity = "\(self.main!.humidity)%"
        self.temp_min = "\(self.convertKelvinToCelsius(kelv: self.main!.temp_min))°"
        self.temp_max = "\(self.convertKelvinToCelsius(kelv: self.main!.temp_max))°"
        self.temp = "\(self.convertKelvinToCelsius(kelv: self.main!.temp))°"
        self.pressure = "\(Double((self.main?.pressure)!) / 1000.0)"
        self.weatherDescription = self.getDescription(self.weather)
        return self
    }
    
    func convertKelvinToCelsius(kelv: Int) -> Int {
        return kelv - 273
    }
    
    func getDescription(_ weathers: [Weather]) -> String {
        if weathers.count > 0 {
            return self.weather[0].weatherDescription
        } else {
            return ""
        }
    }
}
