//
//  WeatherRequests.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import Foundation
import ObjectMapper

typealias WeatherCompletionBlock = (_ resultMain: CityWeatherViewModel) -> ()
typealias WeatherForecastCompletionBlock = (_ resultMain: WeatherForecastViewModel) -> ()
typealias WeatherForecastNextDayCompletionBlock = (_ resultMain: WeatherForecastNextDayViewModel, _ success: Bool) -> ()

class WeatherRequestManager: NSObject {
    
    static let shared = WeatherRequestManager()

    
    func getWeatherByCityName(_ name: String, completionBlock: @escaping WeatherCompletionBlock) {
        
        let requestURL = APP_BASE_URL+"weather?q="+name+"&APPID="+APPKEY
        
        NetworkManager.sharedInstance.GETRequest(url: requestURL, parameters: nil, success: { (response, code) -> (Void) in
            
            let res = response as? [String:Any]
            
            let cityWeather = Mapper<CityWeather>().map(JSON: (res)!)
            let cityWeatherVM = CityWeatherViewModel().initWithModel(model: cityWeather!)
            completionBlock(cityWeatherVM)
            
        }) { (code) -> (Void) in
            
        }
    }
    
    func getWeatherByCityCoordinates(_ lat: Double, _ lng: Double,completionBlock: @escaping WeatherCompletionBlock) {

        let requestURL = APP_BASE_URL+"weather?lat=\(lat)&lon=\(lng)&APPID="+APPKEY
        
        NetworkManager.sharedInstance.GETRequest(url: requestURL, parameters: nil, success: { (response, code) -> (Void) in
            
            let res = response as? [String:Any]
            
            let cityWeather = Mapper<CityWeather>().map(JSON: (res)!)
            let cityWeatherVM = CityWeatherViewModel().initWithModel(model: cityWeather!)
            completionBlock(cityWeatherVM)
            
        }) { (code) -> (Void) in
            
        }
    }
    func getForecast(_ lat: Double, _ lng: Double, completionBlock: @escaping WeatherForecastCompletionBlock) {

        let requestURL = APP_BASE_URL+"forecast?lat=\(lat)&lon=\(lng)&APPID="+APPKEY
        
        NetworkManager.sharedInstance.GETRequest(url: requestURL, parameters: nil, success: { (response, code) -> (Void) in
            
            let res = response as? [String:Any]
            print("forecast = \(res!)")
            let weatherForecast = Mapper<WeatherForecast>().map(JSON: (res)!)
            
            let weatherForecastVM = WeatherForecastViewModel().initWithModel(model: weatherForecast!)
            completionBlock(weatherForecastVM)
            
        }) { (code) -> (Void) in
            
        }
    }
    
    func getNextDaysForecast(_ lat: Double, _ lng: Double, completionBlock: @escaping WeatherForecastNextDayCompletionBlock) {
        
        let requestURL = APP_BASE_URL+"forecast/daily?lat=\(lat)&lon=\(lng)&cnt=5&APPID="+APPKEY
        
        NetworkManager.sharedInstance.GETRequest(url: requestURL, parameters: nil, success: { (response, code) -> (Void) in
            
            let res = response as? [String:Any]
            print("forecast = \(res!)")
            let weatherForecastNextDay = Mapper<WeatherForecastNextDays>().map(JSON: (res)!)
            let weatherForecastVM = WeatherForecastNextDayViewModel().initWithModel(model: weatherForecastNextDay!)
            if (weatherForecastNextDay?.cod.count)! > 0 {
                
                completionBlock(weatherForecastVM,true)
            } else {
                completionBlock(weatherForecastVM,false)
            }
            
        }) { (code) -> (Void) in
            
        }
    }
}
