//
//  WeatherViewModel.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit
import CoreLocation

class WeatherViewModel: NSObject, CLLocationManagerDelegate {

    //MARK: - Variables
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var fetchedModel: Box<Welcome?> = Box(nil)
    var weatherMessage: String?
    var arrayForTable = [ForTable]()

    
    //MARK: - Initialization
    override init() {
        super.init()
        getLocation()
    }

    private func getLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func requestWeatherForLocation() {
        guard let lat = currentLocation?.coordinate.latitude,
              let long = currentLocation?.coordinate.longitude else {
            return
        }
        NetworkManager.shared.request(lat: lat, long: long,
                                      successHandler: { [weak self] (model: Welcome) in
                                        self?.fetchedModel.value = model
                                        self?.updateWeatherMessage(with: model)
                                        self?.updateArrayForTable(with: model)
                                      },
                                      errorHandler: { (error: NetworkError) in
                                        fatalError(error.localizedDescription)
                                      })
    }

    func updateArrayForTable(with model: Welcome) {
        var weatherImages = [UIImage]()
        for element in 0...39 {
            let myImage = UIImage.donwload("\(model.list[element].weather[0].icon)") ?? UIImage(systemName: "sun.max")
            weatherImages.append(myImage!)
        }

        var tempArray = [ForTable]()
        for element in 0...39 {
            tempArray.append(ForTable(image: weatherImages[element],
                                      time: model.list[element].dtTxt,
                                      description: "\(model.list[element].weather[0].weatherDescription)",
                                      temperature: "\(model.list[element].main.temp)",
                                      city: "\(model.city.name)"))
        }
        self.arrayForTable = tempArray
    }

    func updateWeatherMessage(with model: Welcome) {
        self.weatherMessage =
        """
        You are situated in \(model.city.name), \(model.city.country)
        Today is \(String.convertToDay(date: model.list[0].dtTxt)).
        Mostly \(model.list[0].weather[0].main) and the temperature is \(model.list[0].main.temp) degrees.
        Wind speed is \(model.list[0].wind.speed) km/h. Wind angle is \(model.list[0].wind.deg) °.
        Humidity \(model.list[0].main.humidity) % and pressure is \(model.list[0].main.pressure) hPa.
        """
    }

    func calculateHeaders() -> [String] {
        var array = [String]()
        array.append(String.convertToDay(date: arrayForTable[0].time))

        for element in 0...39 {
            let day = String.convertToDay(date: arrayForTable[element].time)
            if !array.contains(day) {
                array.append(day)
            }
        }
        return array
    }

    func countSections() -> Int {
        var number = 1
        var date = String.convertToDay(date: arrayForTable[0].time)
        for element in 0...39 {
            let newDate = String.convertToDay(date: arrayForTable[element].time)
            if newDate == date {
            } else {
                number += 1
                date = newDate
            }
        }
        return number
    }

    func calculateNumberOfRowPerSection() -> [Int] {
        var array = [Int]()

        var number = 0
        var comparableDay = String.convertToDay(date: arrayForTable[0].time)
        for element in 0...39 {
            let currentDay = String.convertToDay(date: arrayForTable[element].time)
            if element == 39, number != 0, currentDay == comparableDay {
                number += 1
                array.append(number)
            } else if currentDay == comparableDay {
                number += 1
            } else {
                array.append(number)
                number = 1
                comparableDay = currentDay
            }
        }
        return array
    }

    //MARK: - ConfigureGUI methods
    func setMainImage() -> UIImage {
        guard let model = fetchedModel.value else { return UIImage(named: "default")! }
        return UIImage.donwload("\(model.list[0].weather[0].icon)") ?? UIImage(named: "default")!
    }

    func setPlaceLabel() -> String {
        guard let model = fetchedModel.value else { return "" }
        return "\(model.city.name), \(model.city.country)"
    }

    func setTemperatureLabel() -> String {
        guard let model = fetchedModel.value else { return "" }
        return "\(model.list[0].main.temp)°С | \(model.list[0].weather[0].weatherDescription)"
    }

    func setLittleImage(withIndex index: Int) -> UIImage {
        switch index {
        case 0:
            return UIImage(systemName: "cloud.rain")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) ?? UIImage(named: "default")!
        case 1:
            return UIImage(systemName: "drop")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) ?? UIImage(named: "default")!
        case 2:
            return UIImage(systemName: "lineweight")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) ?? UIImage(named: "default")!
        case 3:
            return UIImage(systemName: "wind")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) ?? UIImage(named: "default")!
        case 4:
            return UIImage(systemName: "circle")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)  ?? UIImage(named: "default")!
        default:
            return UIImage(named: "default")!
        }
    }

    func setLittleLabel(withIndex index: Int) -> String {
        guard let model = fetchedModel.value else { return "" }
        switch index {
        case 0:
            return "\(model.list[0].main.humidity) %"
        case 1:
            return "\(model.list[0].rain?.the3H ?? 0) mm"
        case 2:
            return "\(model.list[0].main.pressure) hPa"
        case 3:
            return "\(model.list[0].wind.speed) km/h"
        case 4:
            return "\(model.list[0].wind.deg) °"
        default:
            return ""
        }
    }

    //MARK: - CLLocationDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            currentLocation = locations.first
            requestWeatherForLocation()
        }
    }
}
