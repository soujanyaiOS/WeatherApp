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
        InitalSetup()
    }
    
    private func InitalSetup() {
        self.title = "Cities"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Call fetchWeatherData with the desired city name
        viewModel.getCityList()
        bindObjects()
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddCityAlert))
        navigationItem.rightBarButtonItem = backButton
    }
    
    @objc func showAddCityAlert() {
        let alertController = UIAlertController(title: "Add City", message: "Enter a city name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "City Name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let cityName = alertController.textFields?.first?.text, !cityName.isEmpty {
                // Add the city to your data source and reload the table view
                self?.fetchWeatherData(for: cityName)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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
    }
    
    // Implement UITableViewDataSource methods to display the weather data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityListData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.cityListData[indexPath.row].name
        // Add the detail disclosure button
        cell.accessoryView?.isUserInteractionEnabled = true
        let infoIcon = UIImage(systemName: "info.circle")
        let accessoryImageView = UIImageView(image: infoIcon)
        accessoryImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
       // cell.accessoryView = accessoryImageView
        cell.accessoryType = .detailDisclosureButton
        
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToWheatherDetailsScreen(data: viewModel.cityListData[indexPath.row])
    }
    
    private func navigateToWheatherDetailsScreen (data: WeatherEntryEntity) {
        let detailsController = WeatherDetailsViewController()
        detailsController.data = data
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {        
        let detailsController = WeatherInfoViewController()
         detailsController.data = viewModel.cityListData[indexPath.row]
        self.present(detailsController, animated: true, completion: nil)
    }
}



