//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import UIKit
import SDWebImage
class WeatherDetailsViewController: UIViewController {
    
    var stack = UIStackView()
    let placeholderImage = UIImage(named: "placeholder")
    
    var imageBgView = UIView()
    let weatherIconImageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = true
        return img
    }()
    
    var weatherInfoLabel = CustomLabel()
    var weatherDescriptionLabel = CustomLabel()
    var temperatureLabel = CustomLabel()
    var humidityLabel = CustomLabel()
    var windspreadLabel = CustomLabel()
    
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        [self.weatherInfoLabel,
         self.weatherIconImageView,
         self.weatherDescriptionLabel,
         self.temperatureLabel,
         self.humidityLabel,
         self.windspreadLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    var data : WeatherEntryEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = data?.name
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        
        let frameWidth = self.view.frame.width/2
        
        ///Weather information
        weatherInfoLabel .frame = CGRect(x: weatherIconImageView .frame.width/2 - 70, y:80, width: 150, height: 100)
        
        let dateString = DateConverter().convertDateFormat(timeInterval: Double(data?.dt ?? 0 ) )
        weatherInfoLabel.text = "Weather information for \(String(describing: data?.name ?? "" )) received on \(dateString)"
        weatherInfoLabel.textAlignment = .left
        
        let temperatureInKelvin: Double = data?.temperature ?? 0.0
        let temperatureInCelsius = DateConverter().kelvinToCelsius(temperatureInKelvin)

        temperatureLabel.text = String(format: "Temperature : %.2f C",temperatureInCelsius  )
        humidityLabel.text    =  String(format: "Humidity : %i %@", data?.humidity  ?? 0, "%")
        windspreadLabel.text  = String(format: "Windspeed : %.2f kmh", data?.windSpeed ?? 0.0)
        detailsStackView .frame = CGRect(x: 10 , y: 60 , width: frameWidth*2 - 20, height: 280)
        self.view.addSubview(detailsStackView)
        
        var iconID = ""
        do {
            if let data = data?.weatherArray {
                let decodedData: [Weather] = try JSONDecoder().decode([Weather].self, from: data as! Data)
                // Handle `decodedData` here
                if !decodedData.isEmpty{
                    iconID = decodedData[0].icon ?? ""
                    weatherDescriptionLabel.text = String(format: "Description : %@",decodedData[0].description ?? "")
                }
            } else {
                // Handle the case where `data?.weatherArray` is nil
                print("Error: Data is nil")
            }
        } catch {
            // Handle the decoding error here
            print("Error decoding data: \(error)")
        }
        
        //Load icon image
        loadWeatherIconImage(imageString: iconID)
        
    }
    
    private func loadWeatherIconImage(imageString: String) {
        self.weatherIconImageView.sd_setImage(with: NSURL(string: HttpRouter.getWeatherIcon(imageString).description  ) as URL?, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            if( error != nil)
            {
                debugPrint("Error while displaying image" , (error?.localizedDescription)! as String)
            }
        })
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
