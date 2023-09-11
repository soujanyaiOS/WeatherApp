//
//  WeatherEntryEntity+CoreDataProperties.swift
//  
//
//  Created by soujanya Balusu on 10/09/23.
//
//

import Foundation
import CoreData


extension WeatherEntryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntryEntity> {
        return NSFetchRequest<WeatherEntryEntity>(entityName: "WeatherEntryEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var cityName: String?
    @NSManaged public var name: String?
    @NSManaged public var temperature: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var icon: String?
    @NSManaged public var humidity: Int64
    @NSManaged public var windSpeed: Double
    @NSManaged public var weatherArray: NSObject?
    @NSManaged public var dt: Int64

}
