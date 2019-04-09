//
//  WeatherForecastNextDayViewModel.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit

class WeatherForecastNextDayViewModel: BaseViewModel {
    
    var city: City?
    var list = [WFNextDays]()
    var cod = ""
    var forecastList = [Forecast]()
    
    func initWithModel(model: WeatherForecastNextDays) -> WeatherForecastNextDayViewModel {
        
        self.cod = model.cod
        self.city = model.city
        self.list = model.list ?? [WFNextDays]()
        self.forecastList = getForecastList(self.list)
        return self
    }
    
    func convertKelvinToCelsius(kelv: Int) -> Int {
        return kelv - 273
    }
    
    func getForecastList(_ list: [WFNextDays]) -> [Forecast] {
        
        if list.count > 0 {
            for item in list {
                print("item.dt_txt = \(item.dt)")
                    let forecast = Forecast()
                    forecast.temp = "\(convertKelvinToCelsius(kelv: (item.temp?.day)!))°"
                    forecast.icon = IMAGE_BASE_URL+item.weather[0].icon+".png"
                    forecast.time = getTime(timeStamp: Double(item.dt))
                    self.forecastList.append(forecast)
            }
        }
        return self.forecastList
    }
    
    func getTime(timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }
    
}
