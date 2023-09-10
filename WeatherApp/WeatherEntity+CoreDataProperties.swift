//
//  WeatherEntity+CoreDataProperties.swift
//  
//
//  Created by soujanya Balusu on 10/09/23.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var name: String?
    @NSManaged public var temperature: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var id: Int32

}
