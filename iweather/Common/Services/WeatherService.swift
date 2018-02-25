//
//  WeatherService.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON
import Alamofire
import PromiseKit

typealias WeatherCompletionHandler = (Weather?, SWError?) -> Void

protocol WeatherServiceProtocol {
    
    func retrieveWeatherInfo(_ location: CLLocation, _ locationName: String, completionHandler: @escaping WeatherCompletionHandler)
    
}
struct WeatherService: WeatherServiceProtocol {
    
    fileprivate let urlHourly = "http://api.openweathermap.org/data/2.5/forecast/"
    fileprivate let urlDaily = "http://api.openweathermap.org/data/2.5/forecast/daily/"
    
    func getForecastsHourly(_ location: CLLocation) -> Promise<[ForecastHourly]> {
        
        return Promise { resolver in
            
            let parameters: Parameters = [
                "appid": getAppID(),
                "cnt": 12,
                "lat": location.coordinate.latitude,
                "lon": location.coordinate.longitude
            ]
            
            Alamofire.request(urlHourly, parameters: parameters).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    let forecastsHourly = self.parseForecastsHourly(json)
                    resolver.fulfill(forecastsHourly)
                    
                case .failure:
                    let error = SWError(errorCode: .networkRequestFailed)
                    resolver.reject(error)
                    
                }
            }
        }
    }
    
    
    func getForecastsDaily(_ location: CLLocation) -> Promise<[ForecastDaily]> {
        
        return Promise { resolver in
            
            let parameters: Parameters = [
                "appid": getAppID(),
                "cnt": 7,
                "lat": location.coordinate.latitude,
                "lon": location.coordinate.longitude
            ]
            
            Alamofire.request(urlDaily, parameters: parameters).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    let forecastsDaily = self.parseForecastsDaily(json)
                    resolver.fulfill(forecastsDaily)
                    
                case .failure:
                    let error = SWError(errorCode: .networkRequestFailed)
                    resolver.reject(error)
                    
                }
            }
        }
    }
    
    func createWeatherBuilder(_ locationName: String, _ forecastHourly: [ForecastHourly], _ forecaseDaily: [ForecastDaily]) -> Promise<WeatherBuilder> {
        
        guard let dayTemperature = forecaseDaily.first?.dayTemperature,
            let nightTemperature = forecaseDaily.first?.nightTemperature,
            let description = forecaseDaily.first?.description,
            let weatherIcon = forecaseDaily.first?.iconText,
            let windSpeed = forecaseDaily.first?.windSpeed,
            let pressure = forecaseDaily.first?.pressure,
            let humidity = forecaseDaily.first?.humidity,
            let windDirection = forecaseDaily.first?.windDirection
            else {
                let error = SWError(errorCode: .jsonParsingFailed)
                return Promise { resolver in
                    resolver.reject(error)
                }
        }
        
        var temperature = ""
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if hour > 6  && hour < 20 {
            temperature = dayTemperature
        }
        else {
            temperature = nightTemperature
        }
        
        
        var weatherBuilder = WeatherBuilder()
        weatherBuilder.forecastsHourly = forecastHourly
        weatherBuilder.forecastsDaily = forecaseDaily
        weatherBuilder.location = locationName
        weatherBuilder.dayTemperature = dayTemperature
        weatherBuilder.nightTemperature = nightTemperature
        weatherBuilder.temperature = temperature
        weatherBuilder.iconText = weatherIcon
        weatherBuilder.description = description
        weatherBuilder.windSpeed = windSpeed
        weatherBuilder.pressure = pressure
        weatherBuilder.humidity = humidity
        weatherBuilder.windDirection = windDirection
        
        return Promise { resolver in
            resolver.fulfill(weatherBuilder)
        }
        
    }
    
    func retrieveWeatherInfo(_ location: CLLocation, _ locationName: String, completionHandler: @escaping WeatherCompletionHandler) {
        
        let forecastHourly = getForecastsHourly(location)
        let forecaseDaily = getForecastsDaily(location)
        
        firstly {
            when(fulfilled: forecastHourly, forecaseDaily)
            }.then { forecastHourly, forecaseDaily in
                self.createWeatherBuilder(locationName, forecastHourly, forecaseDaily)
            }.done { weatherBuilder in
                completionHandler(weatherBuilder.build(), nil)
            }.catch { error in
                
                guard let swError = error as? SWError else {return}
                completionHandler(nil, swError)
                
        }
        
    }
    
    fileprivate func parseForecastsHourly(_ json: JSON) -> [ForecastHourly] {
        
        var forecasts: [ForecastHourly] = []
        
        let date = json["list"][0]["dt"].double
        var day = ForecastDateTime(date!).day
        for index in 0...12 {
            
            guard let temp = json["list"][index]["main"]["temp"].double,
                let rawDateTime = json["list"][index]["dt"].double,
                let forecastCondition = json["list"][index]["weather"][0]["id"].int,
                let forecastIcon = json["list"][index]["weather"][0]["icon"].string
                else {
                    break
            }
            
            let dayOfTime = ForecastDateTime(rawDateTime).day
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            
            let forecast = ForecastHourly(newDay: day != dayOfTime, time: ForecastDateTime(rawDateTime).shortTime, date: ForecastDateTime(rawDateTime).dayOfMonth, iconText: weatherIcon.iconText, temperature: Temperature(temp).degrees
            )
            
            if dayOfTime != day {
                day = dayOfTime
            }
            
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
    fileprivate func parseForecastsDaily(_ json: JSON) -> [ForecastDaily] {
        
        var forecasts: [ForecastDaily] = []
        
        for index in 0...6 {
            
            guard let dayTemp = json["list"][index]["temp"]["day"].double,
                let nightTemp = json["list"][index]["temp"]["night"].double,
                let rawDateTime = json["list"][index]["dt"].double,
                let forecastCondition = json["list"][index]["weather"][0]["id"].int,
                let forecastIcon = json["list"][index]["weather"][0]["icon"].string,
                let forecastDescription = json["list"][index]["weather"][0]["description"].string,
                let windSpeed = json["list"][index]["speed"].double,
                let pressure = json["list"][index]["pressure"].double,
                let humidity = json["list"][index]["humidity"].int,
                let windDirection = json["list"][index]["deg"].int
                else {
                    break
            }
            
            let forecastDayTemperature = Temperature(dayTemp)
            let forecastNightTemperature = Temperature(nightTemp)
            let forecastDateString = ForecastDateTime(rawDateTime).date
            let dayOfWeek = ForecastDateTime(rawDateTime).dayOfWeek
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            let forcastIconText = weatherIcon.iconText
            let pressureMM = Converter.hPaTommHg(pressure)
            
            let forecast = ForecastDaily(date: forecastDateString,
                                         dayOfWeek: dayOfWeek,
                                         iconText: forcastIconText,
                                         dayTemperature: forecastDayTemperature.degrees,
                                         nightTemperature: forecastNightTemperature.degrees,
                                         description: forecastDescription,
                                         windSpeed: String(windSpeed),
                                         pressure: String(pressureMM),
                                         humidity: String(humidity),
                                         windDirection: windDirection
            )
            
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
    fileprivate func getAppID() -> String {
        
        //get appId from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
        let appId = parameters!["OWMAccessToken"]! as! String
        
        return appId
    }
    
}

