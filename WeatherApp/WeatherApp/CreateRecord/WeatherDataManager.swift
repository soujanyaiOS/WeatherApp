//
//  WeatherDataManager.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 10/09/23.
//

import UIKit
import CoreData

class WeatherDataManager {
    static let shared = WeatherDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp") // Replace with your data model name
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    
    func weatherRecordExists(forId id: Int) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking for weather record: \(error)")
            return false
        }
    }
    
    func saveWeatherResponse(weatherData : WeatherResponseDataModel) {
        if !weatherRecordExists(forId: weatherData.id ?? 0) {
            let context = persistentContainer.viewContext
            let weatherDataEntity = WeatherEntity(context: context)
            weatherDataEntity.setValue(weatherData.name, forKey: "name")
            weatherDataEntity.setValue(weatherData.name, forKey: "cityName")
            weatherDataEntity.setValue(weatherData.main?.temp, forKey: "temperature")
            weatherDataEntity.setValue(weatherData.weather?.description, forKey: "weatherDescription")
            weatherDataEntity.setValue(weatherData.id, forKey: "id")
            do {
                try context.save()
            } catch {
                print("Error saving weather data: \(error)")
            }
        }
        else {
            print("Weather record already exists for id: \(String(describing: weatherData.id))")
        }
        
        
    }
    
    func fetchWeatherData() -> [WeatherEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        
        do {
            let weatherData = try context.fetch(fetchRequest)
            print(weatherData.count)
            return weatherData
        } catch {
            print("Error fetching weather data: \(error)")
            return []
        }
    }
}

