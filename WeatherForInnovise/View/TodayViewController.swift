//
//  ViewController.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController {

    //MARK: - Variables
    private var weatherViewModel: WeatherViewModel!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        callToViewModelForUIUpdate()
    }

    //MARK: - Methods
    func callToViewModelForUIUpdate() {
        self.weatherViewModel = WeatherViewModel()
        weatherViewModel.fetchedModel.bind { _ in 
            // вызываем методы, которые будут конфигурировать GUI
        }
    }

}

