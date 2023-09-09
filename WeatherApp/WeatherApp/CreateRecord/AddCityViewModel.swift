//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation

class AddCityViewModel {
    
    ///  notify reloadTable to update the UI on data change.
    var reloadTable: DynamicObserver<Bool> = DynamicObserver(false)
    var cityList  = [WeatherResponseDataModel]()
    
    ///GET WEATHER DATA
     func fetchWeatherData(city: String) {
        ApiServices.shared.loadWeatherList(city: city){ [weak  self] response in
            switch response {
            case .success(let list):
                print(list)
                self?.cityList.append(list)
                DispatchQueue.main.async {
                    self?.reloadTable.value = true
                }

            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
