//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation
import CoreData
import UIKit
import SVProgressHUD

class AddCityViewModel {
    
    ///  notify reloadTable to update the UI on data change.
    var reloadTable: DynamicObserver<Bool> = DynamicObserver(false)
    var cityList  = [WeatherResponseDataModel]()
    var cityListData  = [WeatherEntryEntity]()
    var uniqueCityListData  = [WeatherEntryEntity]()
    var CityWeatherInfor = [WeatherEntryEntity]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    ///GET WEATHER DATA
    func fetchWeatherData(city: String) {
        ApiServices.shared.loadWeatherList(city: city){ [weak  self] response in
            switch response {
            case .success(let list):
                WeatherDataManager.shared.saveWeatherResponse(weatherData: list)
                self?.getCityList()
                
                
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getCityList () {
        self.cityListData =  WeatherDataManager.shared.fetchWeatherData()
        self.uniqueCityListData = WeatherDataManager.shared.removeDuplicates(from: self.cityListData)
        
        DispatchQueue.main.async {
            self.reloadTable.value = true
        }
    }
    
    func getWeatherDataforCity (city: String) {
        self.CityWeatherInfor =  WeatherDataManager.shared.fetchWeatherData(forCityName: city)
        DispatchQueue.main.async {
            self.reloadTable.value = true
        }
    }
    
    
}
