//
//  WeatherEntryEntity+CoreDataClass.swift
//  
//
//  Created by soujanya Balusu on 11/09/23.
//
//

import Foundation
import CoreData

@objc(WeatherEntryEntity)
public class WeatherEntryEntity: NSManagedObject {

    
       // Add this method to your NSManagedObject subclass
       class func transformerName() -> String {
           return NSValueTransformerName.secureUnarchiveFromDataTransformerName.rawValue
       }
}
