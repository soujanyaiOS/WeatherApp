//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import UIKit

class WeatherInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let viewModel = AddCityViewModel()
    var data : [WeatherEntryEntity]?
    var tableArray = [Weather]()
    let tableView = UITableView()
    var city = "" {
        didSet {
            viewModel.getWeatherDataforCity(city: city)
            data = viewModel.CityWeatherInfor
            bindObjects()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupUI()
        
    }
    
    /// Method to set all binding object functionality
    private func bindObjects() {
        viewModel.reloadTable.bind { [weak self] shouldReload in
            if shouldReload {
                self?.tableView.reloadData()
            }
        }
    }
    
    func createTableView() {
        // Create a UITableView instance
        tableView.frame = CGRect(x: 20, y: 100, width: 300, height: 400)
        
        // Add the table view to the view controller's view
        view.addSubview(tableView)
        
        // Set Auto Layout constraints to define the table view's position and size
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        // Configure your table view's data source and delegate as needed
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func  setupUI() {
        
        
        self.view.backgroundColor = .white
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.frame = CGRect(x: 16, y: 30, width: 60, height: 30)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.layer.borderWidth = 2.0
        view.addSubview(doneButton)
        
        
        let titleLabel = UILabel()
        
        // Set the text for the title label
        titleLabel.text = "\(city) Historical"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        createTableView()
        
        for i in 0 ..< (data?.count ?? 0) {
            
            do {
                if let data = data?[i].weatherArray {
                    let decodedData: [Weather] = try JSONDecoder().decode([Weather].self, from: data as! Data)
                    // Handle `decodedData` here
                    tableArray.insert(contentsOf: decodedData, at: 0)
                    
                } else {
                    // Handle the case where `data?.weatherArray` is nil
                    print("Error: Data is nil")
                }
            } catch {
                // Handle the decoding error here
                print("Error decoding data: \(error)")
            }
        }
        tableView.reloadData()
        
    }
    
    @objc func doneButtonTapped() {
        // Handle the "Done" button tap event here
        dismiss(animated: true, completion: nil)
    }
    
    // Implement UITableViewDataSource methods to display the weather data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cellData =  configureCellData(row: indexPath.row)
        var contentConfig = UIListContentConfiguration.subtitleCell()
        contentConfig.text = cellData.0
        contentConfig.secondaryText = cellData.1
        cell.contentConfiguration = contentConfig
        
        return cell
    }
    
    func configureCellData(row: Int ) -> (String, String){
        
        ///Get Temp in degrees
        let temperatureInKelvin: Double = data?[row].temperature ?? 0.0
        let temperatureInCelsius = DateConverter().kelvinToCelsius(temperatureInKelvin)
        let temperatureString = String(format: "Temperature : %.2f C",temperatureInCelsius  )
       
        ///Get formatted Date
        let dateString = DateConverter().convertDateFormat(timeInterval: Double(data?[row].dt ?? 0 ) )
        var weatherDescription = ""        
        do {
            if let data = data?[row].weatherArray {
                let decodedData: [Weather] = try JSONDecoder().decode([Weather].self, from: data as! Data)
                if decodedData.count  > 0 {
                    weatherDescription = decodedData[0].description ?? ""
                }
            }
        } catch {
            print("Error decoding data: \(error)")
        }
        
        let primaryText =  dateString
        let secondaryText = weatherDescription + temperatureString
        return (primaryText,secondaryText)
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
