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
        // Call getcities fron Coredata saved list if any
        viewModel.getCityList()
        bindObjects()
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddCityAlert))
        navigationItem.rightBarButtonItem = backButton
    }
    
    ///Show alert on add click
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
    
    /// Fetch weather data for entered city
    func fetchWeatherData(for city: String) {
        viewModel.fetchWeatherData(city: city)
    }
    
    //MARK: - UITableview Data Source delegates
    // Implement UITableViewDataSource methods to display the weather data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.uniqueCityListData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.uniqueCityListData[indexPath.row].name
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
        navigateToWheatherDetailsScreen(data: viewModel.uniqueCityListData[indexPath.row])
    }
    
    ///Navigation to weather details screen
    private func navigateToWheatherDetailsScreen (data: WeatherEntryEntity) {
        let detailsController = WeatherDetailsViewController()
        detailsController.data = data
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        ///Navigation to weather info screen
        let detailsController = WeatherInfoViewController()
        detailsController.city = viewModel.uniqueCityListData[indexPath.row].name ?? ""
        self.present(detailsController, animated: true, completion: nil)
    }
}



