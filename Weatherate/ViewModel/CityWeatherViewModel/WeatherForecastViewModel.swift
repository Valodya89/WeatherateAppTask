//
//  WeatherForecastViewModel.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherForecastViewModel: BaseViewModel {

    var city: City?
    var list = [WeatherObject]()
    var cod = ""
    var forecastList = [Forecast]()
    var nextDaysForecastList = [Forecast]()
    var oldDay = ""
    
    func initWithModel(model: WeatherForecast) -> WeatherForecastViewModel {
        
        self.cod = model.cod
        self.city = model.city
        self.list = model.list ?? [WeatherObject]()
        self.forecastList = getForecastList(self.list)
        
        return self
    }
    
    func convertKelvinToCelsius(kelv: Int) -> Int {
        return kelv - 273
    }
    
    func getForecastList(_ list: [WeatherObject]) -> [Forecast] {
        
        if list.count > 0 {
            for item in list {
                print("item.dt_txt = \(item.dt_txt)")
                if checkDate(timeStamp: Double(item.dt)) {
                    let forecast = Forecast()
                    forecast.temp = "\(convertKelvinToCelsius(kelv: (item.main?.temp)!))°"
                    forecast.icon = IMAGE_BASE_URL+item.weather[0].icon+".png"
                    forecast.time = getTime(timeStamp: Double(item.dt))
                    self.forecastList.append(forecast)
                }
            }
        }
        return self.forecastList
    }
    
    func getTime(timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH'h'"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd"
        self.oldDay = dateFormatter2.string(from: date)
        return dateFormatter.string(from: date)
    }
    
    func checkDate(timeStamp: Double) -> Bool {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let day = dateFormatter.string(from: date)
        let curentDay = dateFormatter.string(from: Date())
        if day == curentDay {
            return true
        } else {
            return false
        }
    }
    
    func checkNextDate(timeStamp: Double) -> Bool {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        if day != self.oldDay {
            self.oldDay = day
            return true
        } else {
            return false
        }
    }
}
