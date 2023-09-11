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
    
     lazy var persistentContainer: NSPersistentContainer = {
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
        let fetchRequest: NSFetchRequest<WeatherEntryEntity> = WeatherEntryEntity.fetchRequest()
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
            let weatherDataEntity = WeatherEntryEntity(context: context)
            
            weatherDataEntity.setValue(weatherData.name, forKey: "name")
            weatherDataEntity.setValue(weatherData.name, forKey: "cityName")
            weatherDataEntity.setValue(weatherData.main?.temp, forKey: "temperature")            
            weatherDataEntity.setValue(weatherData.weather?.description, forKey: "weatherDescription")
            weatherDataEntity.setValue(weatherData.sys?.id, forKey: "id")
            weatherDataEntity.setValue(weatherData.main?.humidity, forKey: "humidity")
            weatherDataEntity.setValue(weatherData.dt, forKey: "dt")
            
            var weatherArray = [Weather]()
           
            for i in 0 ..< (weatherData.weather?.count ?? 0) {
                if let obj =  weatherData.weather {
                    let weatherObj: Weather = obj[i]
                    let weatherentityObj: [Weather] = [
                        Weather(id: weatherObj.id, icon: weatherObj.icon, main: weatherObj.main, description: weatherObj.description)
                    ]
                    
                    weatherArray.insert(contentsOf: weatherentityObj, at: i)
                }
            }
            
            if let encodedData = try? JSONEncoder().encode(weatherArray) {
                weatherDataEntity.setValue(encodedData, forKey: "weatherArray")
            }
            weatherDataEntity.setValue(weatherData.wind?.speed, forKey: "windSpeed")
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
    
    func fetchWeatherData() -> [WeatherEntryEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WeatherEntryEntity> = WeatherEntryEntity.fetchRequest()
        
        do {
            let weatherData = try context.fetch(fetchRequest)
            return weatherData
        } catch {
              print("Error fetching weather data: \(error)")
            return []
        }
    }
    
    // Remove duplicate city data using reduce
      func removeDuplicates(from cityData: [WeatherEntryEntity]) -> [WeatherEntryEntity] {
          let uniqueCities = cityData.reduce(into: [WeatherEntryEntity]()) { (result, city) in
              if !result.contains(where: { $0.name == city.name }) {
                  result.append(city)
              }
          }
          return uniqueCities
      }
    
    // Fetch city data from Core Data based on city name
        func fetchWeatherData(forCityName cityName: String) -> [WeatherEntryEntity] {
            let context = persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<WeatherEntryEntity> = WeatherEntryEntity.fetchRequest()
            
            // Create a predicate to filter by city name
            let predicate = NSPredicate(format: "name == %@", cityName)
            fetchRequest.predicate = predicate
            
            do {
                let weatherData = try context.fetch(fetchRequest)
                return weatherData
            } catch {
                print("Error fetching city data: \(error)")
                return []
            }
        }
    
    
  
}

class CoreDataTestStack {
    static let shared = CoreDataTestStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()
}


