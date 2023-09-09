//
//  ApiServices.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation

struct ApiServices {
    
    static let shared = ApiServices()
    
    private init() {}
    
    
    func loadWeatherList(city: String,completion: @escaping(Result<WeatherResponseDataModel,Error>) -> Void) {
        loadResources(from: HttpRouter.getWeatherDetails(city).description,completion: completion)
    }
    
    private func loadResources<T: Decodable>(from path: String,
                                             completion: @escaping(Result<T,Error>) -> Void) {
        if let url = path.asURL {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, _, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(T.self, from: data)
                        completion(.success(response))
                    }  catch {
                        debugPrint("error: ", error)
                    }
                }
            }
            urlSession.resume()
        }
    }
}




