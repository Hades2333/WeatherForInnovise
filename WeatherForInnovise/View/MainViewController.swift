//
//  MainViewController.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    //MARK: - Methods
    func setupVCs() {
        let todayVC = TodayViewController()
        let forecastVC = ForecastViewController()

        viewControllers = [todayVC, forecastVC]
    }

}
