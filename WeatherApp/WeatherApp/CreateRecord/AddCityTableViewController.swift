//
//  AddCityTableViewController.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import UIKit



class AddCityTableViewController: UITableViewController {
    private let viewModel = AddCityViewModel()
    private var weatherData: WeatherResponseDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call fetchWeatherData with the desired city name        
        fetchWeatherData(for: "London")
        bindObjects()
    }
    
    /// Method to set all binding object functionality
    private func bindObjects() {
        viewModel.reloadTable.bind { [weak self] shouldReload in
            if shouldReload {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func fetchWeatherData(for city: String) {
        viewModel.fetchWeatherData(city: city)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // Implement UITableViewDataSource methods to display the weather data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.cityList[indexPath.row].name
        return cell
    }
}



