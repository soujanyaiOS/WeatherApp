//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation

class AddCityViewModel {
    ///GET WEATHER DATA
    private func getweatherList(city: String) {
        ApiServices.shared.loadWeatherList(city: city){ [weak  self] response in
            switch response {
            case .success(let list):
                print(list)

            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
