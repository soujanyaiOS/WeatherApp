//
//  HttpRouter.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation

enum HttpRouter {
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    static let imageUrl = "http://openweathermap.org/img/w/"
    
    case getWeatherDetails(String)
    case getWeatherIcon(String)
   
    
    var description: String {
        switch self {
           // let  urlString = String(format:  "%@%@", path.asURL,"&appid=\(apiKey)")
        case .getWeatherDetails(let city) :
            return "\(HttpRouter.baseURL)" + "\(city)&appid=f5cb0b965ea1564c50c6f1b74534d823"
        case .getWeatherIcon(let iconId):
            return  "\(HttpRouter.imageUrl)" + "\(iconId).png"
            
            
       
        }
    }
}
