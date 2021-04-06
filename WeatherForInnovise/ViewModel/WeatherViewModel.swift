//
//  WeatherViewModel.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject, CLLocationManagerDelegate {

    //MARK: - Variables
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var fetchedModel: Box<Welcome?> = Box(nil)

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
                                      },
                                      errorHandler: { (error: NetworkError) in
                                        fatalError(error.localizedDescription)
                                      })
    }

    //MARK: - ConfigureGUI methods
    

    //MARK: - CLLocationDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            currentLocation = locations.first
            requestWeatherForLocation()
        }
    }
}
