//
//  DateConverter.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 10/09/23.
//


import Foundation

class DateConverter {
    
    func convertDateFormat(timeInterval: Double) -> String {
        // Replace this timestamp with your actual timestamp
        let unixTimestamp: TimeInterval = timeInterval

        // Create a DateFormatter
        let dateFormatter = DateFormatter()

        // Set the desired date format
        dateFormatter.dateFormat = "MM-dd-yyyy"

        // Convert the Unix timestamp to a Date object
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))

        // Format the Date object to a string
        let formattedDate = dateFormatter.string(from: date)

        return "\(formattedDate)"
    }
    
    func kelvinToCelsius(_ kelvin: Double) -> Double {
        return kelvin - 273.15
    }

}
