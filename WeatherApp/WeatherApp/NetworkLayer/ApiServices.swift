//
//  ApiServices.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation
import Alamofire
import SVProgressHUD


struct ApiServices {
    
    static let shared = ApiServices()    
    private init() {}
    
    
    func loadWeatherList(city: String,completion: @escaping(Result<WeatherResponseDataModel,Error>) -> Void) {
        loadResources(from: HttpRouter.getWeatherDetails(city).description,completion: completion)
    }
    
    private func loadResources<T: Decodable>(from path: String,
                                             completion: @escaping(Result<T,Error>) -> Void) {

        
        SVProgressHUD.show()
        if let url = path.asURL {
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: T.self) { response in
                SVProgressHUD.dismiss()
                switch response.result {
                case .success(let value):
                    // Handle successful response here
                    print("Response: \(value)")
                   
                    completion(.success(value))

                    // You can parse and process the response data here

                case .failure(let error):
                    // Handle request failure here
                    print("Error: \(error)")
                    SVProgressHUD.showError(withStatus: "Error: \(error)")

                    // You can handle errors and provide appropriate feedback to the user
                }
            }
        }
    }
}




