//
//  ForecastViewController.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit

class ForecastViewController: UIViewController {

    //MARK: - Variables
    private var weatherViewModel: WeatherViewModel!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }

    //MARK: - Methods
    func callToViewModelForUIUpdate() {
        self.weatherViewModel = WeatherViewModel()
    }
}
