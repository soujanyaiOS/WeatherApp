//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by soujanya Balusu on 09/09/23.
//

import XCTest
import CoreData
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    var coreDataStack: WeatherDataManager!

    override func setUpWithError() throws {
        coreDataStack = WeatherDataManager.shared
    }

    override func tearDown() {
        coreDataStack = nil
        super.tearDown()
    }

    func testCreateWeatherEntity() {
        // Create and save a WeatherEntryEntity object using the Core Data stack
        let context = coreDataStack.persistentContainer.viewContext
        let weatherDataEntity = WeatherEntryEntity(context: context)
        weatherDataEntity.setValue("London", forKey: "name")
        weatherDataEntity.setValue(25, forKey: "temperature")

        do {
            try context.save()
        } catch {
            XCTFail("Failed to save context: \(error)")
        }

        // Perform assertions to test the created object
        XCTAssertEqual(weatherDataEntity.name, "London")
        XCTAssertEqual(weatherDataEntity.temperature, 25)
    }

    // Add more test methods as needed...
}

